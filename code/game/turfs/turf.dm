/turf
	icon = 'icons/turf/floors.dmi'
	level = 1.0

	var/slowdown = 0 //negative for faster, positive for slower
	var/intact = 1
	var/baseturf = /turf/space

	//Properties for open tiles (/floor)
	var/oxygen = 0
	var/carbon_dioxide = 0
	var/nitrogen = 0
	var/toxins = 0


	//Properties for airtight tiles (/wall)
	var/thermal_conductivity = 0.05
	var/heat_capacity = 1

	//Properties for both
	var/temperature = T20C

	var/blocks_air = 0

	var/PathNode/PNode = null //associated PathNode in the A* algorithm

	flags = 0

/turf/New()
	..()
	for(var/atom/movable/AM in src)
		Entered(AM)
	return
/turf/Destroy()
	return QDEL_HINT_HARDDEL_NOW

// Adds the adjacent turfs to the current atmos processing
/turf/Del()
	for(var/direction in cardinal)
		if(atmos_adjacent_turfs & direction)
			var/turf/simulated/T = get_step(src, direction)
			if(istype(T))
				SSair.add_to_active(T)
	..()

/turf/attack_hand(mob/user)
	user.Move_Pulled(src)

/turf/attackby(obj/item/C, mob/user, params)
	if(can_lay_cable() && istype(C, /obj/item/stack/cable_coil))
		var/obj/item/stack/cable_coil/coil = C
		for(var/obj/structure/cable/LC in src)
			if((LC.d1==0)||(LC.d2==0))
				LC.attackby(C,user)
				return
		coil.place_turf(src, user)
		return 1

	return 0

/turf/Enter(atom/movable/mover as mob|obj, atom/forget as mob|obj|turf|area)
	if (!mover)
		return 1
	// First, make sure it can leave its square
	if(isturf(mover.loc))
		// Nothing but border objects stop you from leaving a tile, only one loop is needed
		for(var/obj/obstacle in mover.loc)
			if(!obstacle.CheckExit(mover, src) && obstacle != mover && obstacle != forget)
				mover.Bump(obstacle, 1)
				return 0

	var/list/large_dense = list()
	//Next, check objects to block entry that are on the border
	for(var/atom/movable/border_obstacle in src)
		if(border_obstacle.flags&ON_BORDER)
			if(!border_obstacle.CanPass(mover, mover.loc, 1) && (forget != border_obstacle))
				mover.Bump(border_obstacle, 1)
				return 0
		else
			large_dense += border_obstacle

	//Then, check the turf itself
	if (!src.CanPass(mover, src))
		mover.Bump(src, 1)
		return 0

	//Finally, check objects/mobs to block entry that are not on the border
	for(var/atom/movable/obstacle in large_dense)
		if(!obstacle.CanPass(mover, mover.loc, 1) && (forget != obstacle))
			mover.Bump(obstacle, 1)
			return 0
	return 1 //Nothing found to block so return success!

/turf/Entered(atom/movable/M)
	if(ismob(M))
		var/mob/O = M
		if(!O.lastarea)
			O.lastarea = get_area(O.loc)
//		O.update_gravity(O.mob_has_gravity())

	var/loopsanity = 100
	for(var/atom/A in range(1))
		if(loopsanity == 0)
			break
		loopsanity--
		A.HasProximity(M, 1)

/turf/proc/is_plasteel_floor()
	return 0

/turf/proc/levelupdate()
	for(var/obj/O in src)
		if(O.level == 1)
			O.hide(src.intact)

// override for space turfs, since they should never hide anything
/turf/space/levelupdate()
	for(var/obj/O in src)
		if(O.level == 1)
			O.hide(0)

// Removes all signs of lattice on the pos of the turf -Donkieyo
/turf/proc/RemoveLattice()
	var/obj/structure/lattice/L = locate(/obj/structure/lattice, src)
	if(L)
		qdel(L)

//Creates a new turf
/turf/proc/ChangeTurf(path)
	if(!path)			return
	if(path == type)	return src

	SSair.remove_from_active(src)

	var/turf/W = new path(src)
	if(istype(W, /turf/simulated))
		W:Assimilate_Air()
		W.RemoveLattice()
	W.levelupdate()
	W.CalculateAdjacentTurfs()

	if(!can_have_cabling())
		for(var/obj/structure/cable/C in contents)
			C.Deconstruct()
	return W

//////Assimilate Air//////
/turf/simulated/proc/Assimilate_Air()
	if(air)
		var/aoxy = 0//Holders to assimilate air from nearby turfs
		var/anitro = 0
		var/aco = 0
		var/atox = 0
		var/atemp = 0
		var/turf_count = 0

		for(var/direction in cardinal)//Only use cardinals to cut down on lag
			var/turf/T = get_step(src,direction)
			if(istype(T,/turf/space))//Counted as no air
				turf_count++//Considered a valid turf for air calcs
				continue
			else if(istype(T,/turf/simulated/floor))
				var/turf/simulated/S = T
				if(S.air)//Add the air's contents to the holders
					aoxy += S.air.oxygen
					anitro += S.air.nitrogen
					aco += S.air.carbon_dioxide
					atox += S.air.toxins
					atemp += S.air.temperature
				turf_count ++
		air.oxygen = (aoxy/max(turf_count,1))//Averages contents of the turfs, ignoring walls and the like
		air.nitrogen = (anitro/max(turf_count,1))
		air.carbon_dioxide = (aco/max(turf_count,1))
		air.toxins = (atox/max(turf_count,1))
		air.temperature = (atemp/max(turf_count,1))//Trace gases can get bant
		SSair.add_to_active(src)

/turf/proc/ReplaceWithLattice()
	src.ChangeTurf(src.baseturf)
	new /obj/structure/lattice(locate(src.x, src.y, src.z) )

/turf/proc/ReplaceWithCatwalk()
	src.ChangeTurf(src.baseturf)
	new /obj/structure/lattice/catwalk(locate(src.x, src.y, src.z) )

/turf/proc/phase_damage_creatures(damage,mob/U = null)//>Ninja Code. Hurts and knocks out creatures on this turf //NINJACODE
	for(var/mob/living/M in src)
		if(M==U)
			continue//Will not harm U. Since null != M, can be excluded to kill everyone.
		M.adjustBruteLoss(damage)
		M.Paralyse(damage/5)
	for(var/obj/mecha/M in src)
		M.take_damage(damage*2, "brute")

/turf/proc/Bless()
	flags |= NOJAUNT

/turf/storage_contents_dump_act(obj/item/weapon/storage/src_object, mob/user)
	for(var/obj/item/I in src_object)
		src_object.remove_from_storage(I, src) //No check needed, put everything inside
	return 1

//////////////////////////////
//Distance procs
//////////////////////////////

//Distance associates with all directions movement
/turf/proc/Distance(var/turf/T)
	return get_dist(src,T)

//  This Distance proc assumes that only cardinal movement is
//  possible. It results in more efficient (CPU-wise) pathing
//  for bots and anything else that only moves in cardinal dirs.
/turf/proc/Distance_cardinal(turf/T)
	if(!src || !T) return 0
	return abs(src.x - T.x) + abs(src.y - T.y)

////////////////////////////////////////////////////

/turf/handle_fall(mob/faller, forced)
	faller.lying = pick(90, 270)
	if(!forced)
		return
	if(has_gravity(src))
		playsound(src, "bodyfall", 50, 1)

/turf/handle_slip(mob/living/carbon/C, s_amount, w_amount, obj/O, lube)
	if(has_gravity(src))
		var/obj/buckled_obj
		var/oldlying = C.lying
		if(C.buckled)
			buckled_obj = C.buckled
			if(!(lube&GALOSHES_DONT_HELP)) //can't slip while buckled unless it's lube.
				return 0
		else
			if(C.lying || !(C.status_flags & CANWEAKEN)) // can't slip unbuckled mob if they're lying or can't fall.
				return 0
			if(C.m_intent=="walk" && (lube&NO_SLIP_WHEN_WALKING))
				return 0

		C << "<span class='notice'>You slipped[ O ? " on the [O.name]" : ""]!</span>"

		C.attack_log += "\[[time_stamp()]\] <font color='orange'>Slipped[O ? " on the [O.name]" : ""][(lube&SLIDE)? " (LUBE)" : ""]!</font>"
		playsound(C.loc, 'sound/misc/slip.ogg', 50, 1, -3)

		C.accident(C.l_hand)
		C.accident(C.r_hand)

		var/olddir = C.dir
		C.Stun(s_amount)
		C.Weaken(w_amount)
		C.stop_pulling()
		if(buckled_obj)
			buckled_obj.unbuckle_mob()
			step(buckled_obj, olddir)
		else if(lube&SLIDE)
			for(var/i=1, i<5, i++)
				spawn (i)
					step(C, olddir)
					C.spin(1,1)
		if(C.lying != oldlying) //did we actually fall?
			C.adjustBruteLoss(2)
		return 1

/turf/singularity_act()
	if(intact)
		for(var/obj/O in contents) //this is for deleting things like wires contained in the turf
			if(O.level != 1)
				continue
			if(O.invisibility == 101)
				O.singularity_act()
	ChangeTurf(src.baseturf)
	return(2)

/turf/proc/can_have_cabling()
	return 1

/turf/proc/can_lay_cable()
	return can_have_cabling() & !intact


/turf/indestructible
	name = "wall"
	icon = 'icons/turf/walls.dmi'
	density = 1
	blocks_air = 1
	opacity = 1
	explosion_block = 50

/turf/indestructible/wall/shuttle
	name = "wall"
	icon = 'icons/turf/walls/shuttle_wall2.dmi'
	icon_state = "shuttle"
	smooth = 1
	canSmoothWith = null

/turf/indestructible/wall/shuttle/New()
	..()
	if(smooth)
		smooth_icon(src)
		icon_state = ""

/turf/indestructible/wall/rock
	name = "Rock"
	icon = 'icons/turf/walls/desert.dmi'
	icon_state = "wall"

var/global/list/rockEdgeCache
#define NORTH_EDGING	"north"
#define SOUTH_EDGING	"south"
#define EAST_EDGING		"east"
#define WEST_EDGING		"west"

/turf/indestructible/rock
	name = "Rock"
	icon = 'icons/turf/rock.dmi'
	icon_state = "rock"

/turf/indestructible/rock/New()
	..()
	if(!rockEdgeCache || !rockEdgeCache.len)
		rockEdgeCache = list()
		rockEdgeCache.len = 4
		rockEdgeCache[NORTH_EDGING] = image('icons/turf/rock.dmi', "rock_side_n", layer = 6)
		rockEdgeCache[SOUTH_EDGING] = image('icons/turf/rock.dmi', "rock_side_s")
		rockEdgeCache[EAST_EDGING] = image('icons/turf/rock.dmi', "rock_side_e", layer = 6)
		rockEdgeCache[WEST_EDGING] = image('icons/turf/rock.dmi', "rock_side_w", layer = 6)

	spawn(1)
		var/turf/T
		if(istype(get_step(src, NORTH), /turf/simulated/floor/plating/desert) || istype(get_step(src, NORTH), /turf/simulated/floor/plating/grass))
			T = get_step(src, NORTH)
			if (T)
				T.overlays += rockEdgeCache[SOUTH_EDGING]
		if(istype(get_step(src, SOUTH), /turf/simulated/floor/plating/desert) || istype(get_step(src, SOUTH), /turf/simulated/floor/plating/grass))
			T = get_step(src, SOUTH)
			if (T)
				T.overlays += rockEdgeCache[NORTH_EDGING]
		if(istype(get_step(src, EAST), /turf/simulated/floor/plating/desert) || istype(get_step(src, EAST), /turf/simulated/floor/plating/grass))
			T = get_step(src, EAST)
			if (T)
				T.overlays += rockEdgeCache[WEST_EDGING]
		if(istype(get_step(src, WEST), /turf/simulated/floor/plating/desert) || istype(get_step(src, WEST), /turf/simulated/floor/plating/grass))
			T = get_step(src, WEST)
			if (T)
				T.overlays += rockEdgeCache[EAST_EDGING]

/turf/indestructible/rock/destructible // Don't ask me why.
	icon_state = "rock_d" //for mapping
	baseturf = /turf/simulated/floor/plating/desert
	var/hardness = 200

/turf/indestructible/rock/destructible/New()
	icon_state = "rock_weak"
	..()

/turf/indestructible/rock/destructible/proc/dismantle_wall()
	src.ChangeTurf(src.baseturf)

/turf/indestructible/rock/destructible/ex_act(severity, target)
	if(prob(85))
		dismantle_wall()

/turf/indestructible/rock/destructible/mech_melee_attack(obj/mecha/M)
	if(M.damtype == "brute")
		playsound(src, 'sound/weapons/punch4.ogg', 50, 1)
		visible_message("<span class='danger'>[M.name] has hit [src]!</span>")
		if(prob(5) && M.force > 20)
			dismantle_wall()
			visible_message("<span class='warning'>[src.name] smashes through the rock!</span>")
			playsound(src, 'sound/effects/meteorimpact.ogg', 100, 1)

/turf/indestructible/rock/destructible/proc/checkhardness(damage)
	hardness -= damage
	if(hardness < 0)
		dismantle_wall()

/turf/indestructible/rock/destructible/attack_alien(mob/living/carbon/alien/humanoid/M)
	if(M.a_intent == "harm")
		M.changeNext_move(CLICK_CD_MELEE)
		playsound(src, 'sound/weapons/Genhit.ogg', 25, 1)

		var/damage = rand(M.damagemin, M.damagemax)
		if(!damage)
			playsound(loc, 'sound/weapons/slashmiss.ogg', 50, 1, -1)
			visible_message("<span class='danger'>[M] has lunged at [src]!</span>", \
				"<span class='userdanger'>[M] has lunged at [src]!</span>")
			return 0

		playsound(loc, 'sound/weapons/slice.ogg', 25, 1, -1)
		visible_message("<span class='danger'>[M] has slashed at [src]!</span>", \
			"<span class='userdanger'>[M] has slashed at [src]!</span>")

		checkhardness(damage)

/turf/indestructible/rock/destructible/bullet_act(obj/item/projectile/Proj)
	if(Proj.damage)
		checkhardness(Proj.damage)
	..()

/*This is indestructible bulletproof window which will simulate
window cracks if damaged. Doesn't matter that you can't shatter it in the process and i think -
- it's still better with, than without. ~Zve
*/
/turf/indestructible/window/bulletproof
	name = "bulletproof window"
	icon = 'icons/obj/smooth_structures/bulletproof_window.dmi'
	icon_state = "b_window"
	smooth = 1
	canSmoothWith = null

	layer = 3.2
	opacity = 0
	var/maxhealth = 100
	var/health = 0
	var/image/crack_overlay

/turf/indestructible/window/bulletproof/New()
	..()
	health = maxhealth
	if(smooth)
		smooth_icon(src)
		icon_state = ""

/turf/indestructible/window/bulletproof/bullet_act(obj/item/projectile/Proj)
	playsound(loc, 'sound/effects/Glasshit.ogg', 100, 1)
	if(health > 0)
		if(Proj.damage_type == BRUTE)
			health -= Proj.damage
			update_icon()
	..()

/turf/indestructible/window/bulletproof/ex_act(severity, target)
	playsound(loc, 'sound/effects/Glasshit.ogg', 100, 1)
	if(health > 0)
		switch(severity)
			if(1.0)
				health -= 100
			if(2.0)
				health -= rand(25,50)
			if(3.0)
				if(prob(50))
					health -= rand(1,25)
		update_icon()

/turf/indestructible/window/bulletproof/hitby(AM as mob|obj)
	playsound(loc, 'sound/effects/Glasshit.ogg', 100, 1)
	if(health > 0)
		var/tforce = 0
		if(ismob(AM))
			tforce = 40

		else if(isobj(AM))
			var/obj/item/I = AM
			tforce = I.throwforce

		tforce *= 0.25

		health = max(0, health - tforce)

		update_icon()

/turf/indestructible/window/bulletproof/attack_hand(mob/user)
	user.changeNext_move(CLICK_CD_MELEE)
	user.visible_message("[user] knocks on [src].")
	add_fingerprint(user)
	playsound(loc, 'sound/effects/Glassknock.ogg', 50, 1)

/turf/indestructible/window/bulletproof/attack_paw(mob/user)
	return attack_hand(user)

/turf/indestructible/window/bulletproof/attack_alien(mob/living/user)
	if(islarva(user)) return

	playsound(loc, 'sound/effects/Glasshit.ogg', 100, 1)
	if(health > 0)
		user.do_attack_animation(src)
		user.changeNext_move(CLICK_CD_MELEE)
		health -= 15
		user.visible_message("<span class='danger'>[user] smashes into [src]!</span>")
		update_icon()

/turf/indestructible/window/bulletproof/attackby(obj/item/I, mob/living/user, params)
	playsound(loc, 'sound/effects/Glasshit.ogg', 75, 1)
	if(health > 0)
		if(I.damtype == BRUTE || I.damtype == BURN)
			user.changeNext_move(CLICK_CD_MELEE)
			var/damage = I.force * 0.5
			health = max(0, health - damage)
			update_icon()

/turf/indestructible/window/bulletproof/proc/update_icon()
	spawn(2)
		if(!src) return

		var/ratio = health / maxhealth
		ratio = Ceiling(ratio*4) * 25

		if(smooth)
			smooth_icon(src)

		overlays -= crack_overlay
		if(ratio > 75)
			return
		crack_overlay = image('icons/obj/structures.dmi',"damage[ratio]",-(layer+0.1))
		overlays += crack_overlay

/turf/indestructible/splashscreen
	name = "Space Station 13"
	icon = 'icons/misc/fullscreen.dmi'
	icon_state = "title"
	layer = FLY_LAYER

/turf/indestructible/riveted
	icon_state = "riveted"

/turf/indestructible/riveted/New()
	..()
	if(smooth)
		smooth_icon(src)
		icon_state = ""

/turf/indestructible/riveted/uranium
	icon = 'icons/turf/walls/uranium_wall.dmi'
	icon_state = "uranium"
	smooth = 1
	canSmoothWith = null

/turf/indestructible/riveted/alien
	icon = 'icons/turf/walls/alien.dmi'
	icon_state = "alien"
	smooth = 1
	canSmoothWith = null

/turf/indestructible/abductor
	icon_state = "alien1"

/turf/indestructible/fakeglass
	name = "window"
	icon_state = "fakewindows"
	opacity = 0

/turf/indestructible/fakedoor
	name = "Centcom Access"
	icon = 'icons/obj/doors/Doorele.dmi'
	icon_state = "door_closed"

#undef NORTH_EDGING
#undef SOUTH_EDGING
#undef EAST_EDGING
#undef WEST_EDGING

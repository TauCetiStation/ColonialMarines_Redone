/* Alien shit!
 * Contains:
 *		structure/alien
 *		Resin
 *		Weeds
 *		Egg
 *		effect/acid
 */

#define WEED_NORTH_EDGING "north"
#define WEED_SOUTH_EDGING "south"
#define WEED_EAST_EDGING "east"
#define WEED_WEST_EDGING "west"

/obj/structure/alien
	icon = 'icons/mob/alien.dmi'

/obj/structure/alien/New()
	..()
	if(istype(loc, /turf/simulated/floor/plating/beach))
		alpha = 80
/*
 * Resin
 */
/obj/structure/alien/resin
	name = "resin"
	desc = "Looks like some kind of thick resin."
	icon = 'icons/obj/smooth_structures/alien/resin_wall.dmi'
	icon_state = "resin"
	density = 1
	opacity = 1
	anchored = 1
	canSmoothWith = list(/obj/structure/alien/resin)
	var/health = 350
	var/resintype = null
	var/our_weed = null
	smooth = 1


/obj/structure/alien/resin/New(location)
	..()
	our_weed = locate(/obj/structure/alien/weeds) in get_turf(src)
	air_update_turf(1)
	return

/obj/structure/alien/resin/proc/can_reinforce()
	return 0

/obj/structure/alien/resin/Destroy()
	if(our_weed && loc.density) //Destroy weed under us, only if our loc is dense (mostly walls).
		qdel(our_weed)
	air_update_turf(1)
	..()

/obj/structure/alien/resin/Move()
	var/turf/T = loc
	..()
	move_update_air(T)

/obj/structure/alien/resin/CanAtmosPass()
	return !density

/obj/structure/alien/resin/wall
	name = "resin wall"
	desc = "Thick resin solidified into a wall."
	icon = 'icons/obj/smooth_structures/alien/resin_wall.dmi'
	icon_state = "wall0"	//same as resin, but consistency ho!
	layer = 3.6
	resintype = "wall"
	canSmoothWith = list(
						/obj/structure/alien/resin/wall,
						/obj/structure/alien/resin/wall/reinforced,
						/obj/structure/alien/resin/membrane,
						/obj/structure/alien/resin/membrane/reinforced)

/obj/structure/alien/resin/wall/BlockSuperconductivity()
	return 1

/obj/structure/alien/resin/wall/shadowling //For chrysalis
	name = "chrysalis wall"
	desc = "Some sort of purple substance in an egglike shape. It pulses and throbs from within and seems impenetrable."
	health = INFINITY

/obj/structure/alien/resin/membrane
	name = "resin membrane"
	desc = "Resin just thin enough to let light pass through."
	icon = 'icons/obj/smooth_structures/alien/resin_membrane.dmi'
	icon_state = "membrane0"
	layer = 3.6
	opacity = 0
	health = 270
	resintype = "membrane"
	canSmoothWith = list(
						/obj/structure/alien/resin/wall,
						/obj/structure/alien/resin/wall/reinforced,
						/obj/structure/alien/resin/membrane,
						/obj/structure/alien/resin/membrane/reinforced)

/obj/structure/alien/resin/wall/reinforced
	name = "reinforced resin wall"
	icon = 'icons/obj/smooth_structures/alien/resin_wall_reinf.dmi'

/obj/structure/alien/resin/wall/reinforced/New()
	..()
	health *= x_stats.d_hivelord_reinf

/obj/structure/alien/resin/membrane/reinforced
	name = "reinforced resin membrane"
	icon = 'icons/obj/smooth_structures/alien/resin_membrane_reinf.dmi'

/obj/structure/alien/resin/membrane/reinforced/New()
	..()
	health *= x_stats.d_hivelord_reinf

/obj/structure/alien/resin/wall/can_reinforce()
	return 1

/obj/structure/alien/resin/membrane/reinforced/can_reinforce()
	return 0

/obj/structure/alien/resin/membrane/can_reinforce()
	return 1

/obj/structure/alien/resin/membrane/reinforced/can_reinforce()
	return 0

/obj/structure/alien/resin/proc/healthcheck()
	if(health <=0)
		qdel(src)


/obj/structure/alien/resin/bullet_act(obj/item/projectile/Proj)
	health -= Proj.damage
	..()
	healthcheck()


/obj/structure/alien/resin/ex_act(severity, target)
	switch(severity)
		if(1.0)
			qdel(src)
		if(2.0)
			health -= rand(200,500)
		if(3.0)
			health -= rand(100,350)
	healthcheck()


/obj/structure/alien/resin/blob_act()
	health -= 50
	healthcheck()


/obj/structure/alien/resin/hitby(atom/movable/AM)
	..()
	var/tforce = 0
	if(!isobj(AM))
		tforce = 10
	else
		var/obj/O = AM
		tforce = O.throwforce
	playsound(loc, 'sound/effects/attackblob.ogg', 100, 1)
	health -= tforce
	healthcheck()

/obj/structure/alien/resin/attack_hulk(mob/living/carbon/human/user)
	..(user, 1)
	user.do_attack_animation(src)
	user.visible_message("<span class='danger'>[user] destroys [src]!</span>")
	health = 0
	healthcheck()

/obj/structure/alien/resin/attack_paw(mob/user)
	return attack_hand(user)


/obj/structure/alien/resin/attack_alien(mob/living/user)
	user.changeNext_move(CLICK_CD_MELEE)
	user.do_attack_animation(src)
	if(islarva(user))
		return
	user.visible_message("<span class='danger'>[user] claws at the resin!</span>")
	playsound(loc, 'sound/effects/attackblob.ogg', 100, 1)
	health -= 50
	if(health <= 0)
		user.visible_message("<span class='danger'>[user] slices the [name] apart!</span>")
	healthcheck()


/obj/structure/alien/resin/attackby(obj/item/I, mob/living/user, params)
	user.changeNext_move(CLICK_CD_MELEE)
	health -= I.force
	playsound(loc, 'sound/effects/attackblob.ogg', 100, 1)
	healthcheck()
	..()


/obj/structure/alien/resin/CanPass(atom/movable/mover, turf/target, height=0)
	if(istype(mover) && mover.checkpass(PASSGLASS))
		return !opacity
	return !density


/*
 * Weeds
 */
#define NODE_RANGE 3

/obj/structure/alien/weeds
	gender = PLURAL
	name = "resin floor"
	desc = "A thick resin surface covers the floor."
	icon_state = "weeds"
	anchored = 1
	density = 0
	layer = 2
	var/health = 15
	var/obj/structure/alien/weeds/node/linked_node = null
	var/static/list/weedImageCache

	burn_state = 0
	burntime = 3

/obj/structure/alien/weeds/burn()
	for(var/dirn in alldirs)
		if(prob(7))
			var/turf/T = get_step(src, dirn)
			var/obj/structure/alien/weeds/W = locate(/obj/structure/alien/weeds) in T
			if(W)
				W.fire_act()
	SSobj.burning -= src
	var/turf/T = get_turf(src)
	qdel(src)
	fullUpdateWeedOverlays(T)

/obj/structure/alien/weeds/New(pos, node, grow = TRUE)
	if(istype(loc, /turf/space))
		qdel(src)
		return
	..()
	linked_node = node
	if(icon_state == "weeds")
		icon_state = pick("weeds", "weeds1", "weeds2")
	fullUpdateWeedOverlays()
	if(grow)
		spawn(rand(150, 200))
			if(src && !qdeleted(src))
				grow()

/obj/structure/alien/weeds/Destroy()
	if(linked_node)
		linked_node.recover_weed(src)
		linked_node = null
	..()


/obj/structure/alien/weeds/proc/deprivation_of_node()
	linked_node = null
	spawn(rand(600, 1200))
		if(src && !qdeleted(src))
			var/turf/T = get_turf(src)
			var/obj/structure/alien/weeds/node/N = locate() in range(NODE_RANGE, T)
			if(N)
				linked_node = N
				N.linked_weeds += src
				spawn(rand(300, 600)) // just give him a new try with a new master
					if(src && !qdeleted(src))
						grow()
			else
				qdel(src)
				fullUpdateWeedOverlays(T)

/obj/structure/alien/weeds/proc/grow()
	if(!linked_node || get_dist(linked_node, src) > NODE_RANGE)
		return
	for(var/dirn in alldirs)
		var/turf/T = get_step(src, dirn)
		if(!istype(T) || istype(T, /turf/space))
			continue

		var/allowed = TRUE
		var/obj/structure/window/W
		var/obj/machinery/door/D
		for(var/O in T)
			if(istype(O, /obj/structure/alien/weeds) || istype(O, /obj/structure/alien/resin) || istype(O, /obj/structure/mineral_door/resin))
				allowed = FALSE
				break
			if(istype(O, /obj/structure/window))
				W = O
			if(istype(O, /obj/machinery/door) && !istype(O, /obj/machinery/door/firedoor))
				D = O

		if(!allowed)
			continue

		if(T.density)
			if(istype(T, /turf/simulated/wall))
				var/obj/structure/alien/resin/wall/RW = new(T)
				RW.health = 70
			continue

		var/next_growing = TRUE
		if(W)
			if(W.fulltile)
				var/obj/structure/alien/resin/membrane/RM = new(T)
				RM.health = 40
				next_growing = FALSE
			else
				continue

		if(dirn in diagonals)
			continue

		if(D && !W)
			if(!istype(D, /obj/machinery/door/window))
				var/obj/structure/mineral_door/resin/new_door = new(T)
				if(!D.density)
					new_door.state = 1
					new_door.density = 0
					new_door.opacity = 0
					new_door.air_update_turf(1)
					new_door.update_icon()
					new_door.hardness = 100
				else
					next_growing = FALSE
			else
				continue
		linked_node.create_new_weed(T, next_growing)

/obj/structure/alien/weeds/ex_act(severity, target)
	var/turf/T = get_turf(src)
	qdel(src)
	fullUpdateWeedOverlays(T)


/obj/structure/alien/weeds/attackby(obj/item/I, mob/user, params)
	user.changeNext_move(CLICK_CD_MELEE)
	if(I.attack_verb.len)
		visible_message("<span class='danger'>[user] has [pick(I.attack_verb)] [src] with [I]!</span>")
	else
		visible_message("<span class='danger'>[user] has attacked [src] with [I]!</span>")

	if(istype(I, /obj/item/weapon/weldingtool))
		var/obj/item/weapon/weldingtool/WT = I
		if(WT.remove_fuel(0, user))
			playsound(loc, 'sound/items/Welder.ogg', 100, 1)
			qdel(src)

	apply_damage(I.force / 4.0)

/obj/structure/alien/weeds/proc/apply_damage(damage)
	health -= damage
	if(health <= 0)
		var/turf/T = get_turf(src)
		qdel(src)
		fullUpdateWeedOverlays(T)

/obj/structure/alien/weeds/temperature_expose(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	if(exposed_temperature > 300)
		apply_damage(5)


/obj/structure/alien/weeds/proc/updateWeedOverlays()

	overlays.Cut()

	if(burn_state)
		overlays += fire_overlay

	if(!weedImageCache || !weedImageCache.len)
		weedImageCache = list()
		weedImageCache.len = 4
		weedImageCache[WEED_NORTH_EDGING] = image('icons/mob/alien.dmi', "weeds_side_n", layer=2.11, pixel_y = -32)
		weedImageCache[WEED_SOUTH_EDGING] = image('icons/mob/alien.dmi', "weeds_side_s", layer=2.11, pixel_y = 32)
		weedImageCache[WEED_EAST_EDGING] = image('icons/mob/alien.dmi', "weeds_side_e", layer=2.11, pixel_x = -32)
		weedImageCache[WEED_WEST_EDGING] = image('icons/mob/alien.dmi', "weeds_side_w", layer=2.11, pixel_x = 32)

	var/turf/N = get_step(src, NORTH)
	var/turf/S = get_step(src, SOUTH)
	var/turf/E = get_step(src, EAST)
	var/turf/W = get_step(src, WEST)
	if(!locate(/obj/structure/alien) in N.contents)
		if(istype(N, /turf/simulated/floor))
			overlays += weedImageCache[WEED_SOUTH_EDGING]
	if(!locate(/obj/structure/alien) in S.contents)
		if(istype(S, /turf/simulated/floor))
			overlays += weedImageCache[WEED_NORTH_EDGING]
	if(!locate(/obj/structure/alien) in E.contents)
		if(istype(E, /turf/simulated/floor))
			overlays += weedImageCache[WEED_WEST_EDGING]
	if(!locate(/obj/structure/alien) in W.contents)
		if(istype(W, /turf/simulated/floor))
			overlays += weedImageCache[WEED_EAST_EDGING]


/obj/structure/alien/weeds/proc/fullUpdateWeedOverlays(turf/TF = null)
	for(var/obj/structure/alien/weeds/W in range(1, TF ? TF : src))
		W.updateWeedOverlays()

//Weed nodes
/obj/structure/alien/weeds/node
	name = "glowing resin"
	desc = "Blue bioluminescence shines from beneath the surface."
	icon_state = "weednode"
	luminosity = 0
	var/list/linked_weeds = list()

/obj/structure/alien/weeds/node/grow() // very shitty, but actually, i cannot imagine how it works In the past implementation with similar logic
	linked_node = src
	..()
	linked_node = null

/obj/structure/alien/weeds/node/proc/create_new_weed(turf/T, grow = TRUE)
	var/obj/structure/alien/weeds/W = new(T, src, grow)
	linked_weeds += W

/obj/structure/alien/weeds/node/proc/recover_weed(obj/structure/alien/weeds/W)
	linked_weeds -= W
	var/turf/T = get_turf(W)
	spawn(rand(200, 350))
		if(src && !qdeleted(src) && !locate(/obj/structure/alien/weeds) in T)
			create_new_weed(T)

/obj/structure/alien/weeds/node/Destroy()
	for(var/O in linked_weeds)
		var/obj/structure/alien/weeds/W = O
		W.deprivation_of_node()
	linked_weeds.Cut()
	return ..()

#undef NODE_RANGE

/*
 * Egg
 */

//for the status var
#define BURST 0
#define BURSTING 1
#define GROWING 2
#define GROWN 3
#define MIN_GROWTH_TIME 1800	//time it takes to grow a hugger
#define MAX_GROWTH_TIME 3000

/obj/structure/alien/egg
	name = "egg"
	desc = "A large mottled egg."
	icon_state = "egg_growing"
	density = 0
	anchored = 1
	var/health = 50
	var/status = GROWING	//can be GROWING, GROWN or BURST; all mutually exclusive

/obj/structure/alien/egg/CanPass(atom/movable/mover, turf/target, height=0)
	if(istype(mover, /obj/item/projectile))
		return 0

	return 1

/obj/structure/alien/egg/New()
	new /obj/item/clothing/mask/facehugger(src)
	..()
	spawn(rand(MIN_GROWTH_TIME * x_stats.q_egg_boost, MAX_GROWTH_TIME * x_stats.q_egg_boost))
		Grow()


/obj/structure/alien/egg/attack_paw(mob/living/user)
	return attack_hand(user)

/obj/structure/alien/egg/attack_hand(mob/living/user)
	if(user.getorgan(/obj/item/organ/internal/alien/plasmavessel))
		switch(status)
			if(BURST)
				user << "<span class='notice'>You clear the hatched egg.</span>"
				playsound(loc, 'sound/effects/attackblob.ogg', 100, 1)
				qdel(src)
				return
			if(GROWING)
				user << "<span class='notice'>The child is not developed yet.</span>"
				return
			if(GROWN)
				user << "<span class='notice'>You retrieve the child.</span>"
				Burst(0)
				return
	else
		user << "<span class='notice'>It feels slimy.</span>"
		user.changeNext_move(CLICK_CD_MELEE)


/obj/structure/alien/egg/proc/GetFacehugger()
	return locate(/obj/item/clothing/mask/facehugger) in contents

/obj/structure/alien/egg/proc/Grow()
	icon_state = "egg"
	status = GROWN


/obj/structure/alien/egg/proc/Burst(kill = 1)	//drops and kills the hugger if any is remaining
	if(status == GROWN || status == GROWING)
		icon_state = "egg_hatched"
		flick("egg_opening", src)
		status = BURSTING
		spawn(15)
			status = BURST
			var/obj/item/clothing/mask/facehugger/child = GetFacehugger()
			if(child)
				child.loc = get_turf(src)
				if(kill && istype(child))
					child.Die()
				else
					for(var/mob/M in range(1,src))
						if(CanHug(M))
							child.Attach(M)
							break


/obj/structure/alien/egg/bullet_act(obj/item/projectile/Proj)
	health -= Proj.damage
	..()
	healthcheck()

/obj/structure/alien/egg/ex_act(severity, target)
	switch (severity)
		if (1.0)
			if(status != BURST && status != BURSTING)
				Burst()
			else if(status == BURST && prob(50))
				qdel(src)	//Remove the egg after it has been hit after bursting.
			return

		if (2.0)
			if(prob(50))
				health -= 50
			else
				health -= rand(25,50)

		if(3.0)
			health -= rand(15,45)

	healthcheck()


/obj/structure/alien/egg/attackby(obj/item/I, mob/user, params)
	if(I.attack_verb.len)
		visible_message("<span class='danger'>[user] has [pick(I.attack_verb)] [src] with [I]!</span>")
	else
		visible_message("<span class='danger'>[user] has attacked [src] with [I]!</span>")

	var/damage = I.force / 4
	if(istype(I, /obj/item/weapon/weldingtool))
		var/obj/item/weapon/weldingtool/WT = I

		if(WT.remove_fuel(0, user))
			damage = 15
			playsound(loc, 'sound/items/Welder.ogg', 100, 1)

	health -= damage
	user.changeNext_move(CLICK_CD_MELEE)
	healthcheck()


/obj/structure/alien/egg/proc/healthcheck()
	if(health <= 0)
		if(status != BURST && status != BURSTING)
			Burst()
		else if(status == BURST && prob(50))
			qdel(src)	//Remove the egg after it has been hit after bursting.


/obj/structure/alien/egg/temperature_expose(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	if(exposed_temperature > 500)
		health -= 5
		healthcheck()


/obj/structure/alien/egg/HasProximity(atom/movable/AM)
	if(status == GROWN)
		if(!CanHug(AM))
			return

		var/mob/living/carbon/C = AM
		if(C.stat == CONSCIOUS && C.getorgan(/obj/item/organ/internal/body_egg/alien_embryo))
			return

		Burst(0)

#undef BURST
#undef BURSTING
#undef GROWING
#undef GROWN
#undef MIN_GROWTH_TIME
#undef MAX_GROWTH_TIME


/*
 * Acid
 */
/obj/effect/acid
	gender = PLURAL
	name = "acid"
	desc = "Burbling corrossive stuff."
	icon = 'icons/effects/effects.dmi'
	icon_state = "acid"
	density = 0
	opacity = 0
	anchored = 1
	unacidable = 1
	var/atom/target
	var/ticks = 0
	var/target_strength = 320

/obj/effect/acid/weak
	target_strength = 640

/obj/effect/acid/strong
	target_strength = 160

/obj/effect/acid/New(loc, targ)
	..(loc)
	target = targ

	//handle APCs and newscasters and stuff nicely
	pixel_x = target.pixel_x
	pixel_y = target.pixel_y

	if(isturf(target))	//Turfs take twice as long to take down.
		target_strength *= 2
	//else
	//	target_strength = 320
	tick()


/obj/effect/acid/proc/tick()
	if(!target)
		qdel(src)

	ticks++

	if(ticks >= target_strength)
		target.visible_message("<span class='warning'>[target] collapses under its own weight into a puddle of goop and undigested debris!</span>")

		if(istype(target, /turf/simulated/wall))
			var/turf/simulated/wall/W = target
			W.dismantle_wall(1)
		else if(istype(target, /turf/simulated/floor))
			var/turf/simulated/floor/F = target
			F.make_plating()
		else
			qdel(target)

		qdel(src)
		return

	x = target.x
	y = target.y
	z = target.z

	switch(target_strength - ticks)
		if(480)
			visible_message("<span class='warning'>[target] is holding up against the acid!</span>")
		if(320)
			visible_message("<span class='warning'>[target] is being melted by the acid!</span>")
		if(160)
			visible_message("<span class='warning'>[target] is struggling to withstand the acid!</span>")
		if(80)
			visible_message("<span class='warning'>[target] begins to crumble under the acid!</span>")

	spawn(1)
		if(src)
			tick()

#undef WEED_NORTH_EDGING
#undef WEED_SOUTH_EDGING
#undef WEED_EAST_EDGING
#undef WEED_WEST_EDGING

/mob/living/carbon/human
	var/obj/structure/machinegun/mounted

	ClickOn(var/atom/A, params)
		if(mounted)
			if(mounted.loc == src.loc)
				if(A && mounted.nextshot <= world.time && mounted.anchored)
					mounted.shoot(get_turf(A))
			else
				mounted = null
		else
			..()


/obj/structure/machinegun
	name = "machine gun"
	desc = "A stationary machine gun."
	icon = 'icons/marines/portable_gun.dmi'
	icon_state = "mgun+barrier"
	var/fire_sound = 'sound/weapons/mg.ogg'
	var/empty_sound = 'sound/weapons/empty.ogg'
	var/ammo = 100
	var/ammomax = 100
	var/list/row1 = list()
	var/list/row2 = list()
	var/list/row3 = list()
	var/mob/living/carbon/human/User
	var/nextshot = 0
	var/FIRETIME = 3 //tenths of seconds
	density = 1
	anchored = 0
	flags = ON_BORDER
	var/health = 500

/obj/structure/machinegun/process()
	var/mob/living/carbon/human/U
	for(var/mob/living/carbon/human/H in range(0, src))
		if(H)
			U = H
	if(U)
		if(User && User != U)
			User.mounted = null
			User = null
		User = U
		User.mounted = src
	else
		if(User)
			User.mounted = null
			User = null
	sleep(1)
/obj/structure/machinegun/New()
	..()
	SSobj.processing |= src

/obj/structure/machinegun/Destroy()
	SSobj.processing.Remove(src)
	..()

/obj/structure/machinegun/proc/shoot(var/turf/T)
	if(ammo <= 0)
		if(User)
			playsound(src, empty_sound, 70, 1)
			User << "This machine gun is out of ammo!"
		return
	if(T && User && User.stat == CONSCIOUS && !User.stunned && !User.weakened)
		var/row = 0
		if(row1.Find(T))
			row = 1
		else if(row2.Find(T))
			row = 2
		else if(row3.Find(T))
			row = 3
		if(row)
			var/turf/shootfrom
			switch(row)
				if(1)
					shootfrom = get_step(src, turn(dir, 90))
				if(2)
					shootfrom = get_step(src, dir)
				if(3)
					shootfrom = get_step(src, turn(dir, 270))
			if(shootfrom)
				var/turf/curloc = get_turf(src)
				var/turf/targloc
				switch(row)
					if(1)
						targloc = row1[7]
					if(2)
						targloc = row2[7]
					if(3)
						targloc = row3[7]
				if (!istype(targloc) || !istype(curloc))
					return
				playsound(src, fire_sound, 80, 1, -1)
				var/obj/item/projectile/bullet/machinegun/A = new /obj/item/projectile/bullet/machinegun(shootfrom)
				A.original = targloc
				A.current = curloc
				A.starting = curloc
				A.yo = targloc.y - curloc.y
				A.xo = targloc.x - curloc.x
				A.firer = User
				A.fire()
				ammo = ammo - 1
				score_rounds_fired++
				nextshot = world.time + FIRETIME


/obj/structure/machinegun/proc/update_rows()
	row1 = list()
	row2 = list()
	row3 = list()
	//row1 + 90
	//row2 + 0
	//row3 - 90

	//row1
	var/turf/pos = get_step(src, dir)
	pos = get_step(pos, turn(dir, 90))
	row1.Add(pos)
	var/i
	for(i=2, i<8, i++)
		row1.Add(get_turf(get_step(row1[i - 1], dir)))
	//row2
	pos = get_step(src, dir)
	row2.Add(pos)
	for(i=2, i<8, i++)
		row2.Add(get_turf(get_step(row2[i - 1], dir)))
	//row3
	pos = get_step(src, dir)
	pos = get_step(pos, turn(dir, 270))
	row3.Add(pos)
	for(i=2, i<8, i++)
		row3.Add(get_turf(get_step(row3[i - 1], dir)))


/obj/structure/machinegun/attackby(obj/item/W as obj, mob/user as mob)
	var/obj/item/machinegunammo/Ammo = W
	if(istype(W, /obj/item/weapon/wrench))
		if(anchored)
			user.visible_message("\blue \The [user] starts to unbolt \the [src] from the plating...")
			if(!do_after(user,40, target = src))
				user.visible_message("\blue \The [user] decides not to unbolt \the [src].")
				return
			user.visible_message("\blue \The [user] finishes unfastening \the [src]!")
			anchored = 0
			return
		else
			user.visible_message("\blue \The [user] starts to bolt \the [src] to the plating...")
			if(!do_after(user,40, target = src))
				user.visible_message("\blue \The [user] decides not to bolt \the [src].")
				return
			user.visible_message("\blue \The [user] finishes fastening down \the [src]!")
			anchored = 1
			update_rows()
			return
	else if(Ammo)
		if(ammo < ammomax)
			var/amt = ammomax - ammo
			if(Ammo.count > amt)
				Ammo.count -= amt
				Ammo.desc = "Machine gun ammo. It has [Ammo.count] rounds remaining"
			else
				amt = Ammo.count
				del(Ammo)
			ammo = ammo + amt

	else
		return ..()

/obj/structure/machinegun/CanPass(atom/movable/mover, turf/target, height=0)
	if(istype(mover,/obj/item/projectile))
		return (check_cover(mover,target))
	if (get_dir(loc, target) == dir)
		return !density
	else
		return 1
	return 0

//checks if projectile 'P' from turf 'from' can hit whatever is behind the table. Returns 1 if it can, 0 if bullet stops.
/obj/structure/machinegun/proc/check_cover(obj/item/projectile/P, turf/from)
	var/turf/cover = get_turf(src)
/*	if(istype(P, /obj/item/projectile/energy/acid))
		return 0*/
	if (get_dist(P.starting, loc) <= 1) //Tables won't help you if people are THIS close
		return 1
	if (get_turf(P.original) == cover)
		var/chance = 50
		if (ismob(P.original))
			var/mob/M = P.original
			if (M.lying)
				chance += 20				//Lying down lets you catch less bullets

		if(get_dir(loc, from) == dir)	//Flipped tables catch mroe bullets
			chance += 20
		else
			return 1					//But only from one side
		if(prob(chance))
			health -= P.damage/2
			if (health > 0)
				visible_message("<span class='warning'>[P] hits \the [src]!</span>")
				return 0
			else
				visible_message("<span class='warning'>[src] breaks down!</span>")
				qdel(src)
				return 1
	return 1

/obj/structure/machinegun/CheckExit(atom/movable/O as mob|obj, target as turf)

	if (get_dir(loc, target) == dir)
		return !density
	else
		return 1
	return 1

/obj/item/machinegunammo
	icon = 'icons/marines/portable_gun.dmi'
	icon_state = "mgun_crate"
	name = "machinegun ammo"
	desc = "Machine gun ammo. It has 100 rounds remaining"
	var/count = 100
	w_class = 5



////////////
// Turret //
////////////
/obj/item/marines/turret_deployer
	icon = 'icons/obj/turrets.dmi'
	icon_state = "syndieturret0"
	name = "Sentry Turret (Packed)"
	desc = "Used to deploy a sentry turret."
	w_class = 5
	action_button_name = "Deploy"

	var/deploy_try = 3
	var/ammo = 250

/obj/item/marines/turret_deployer/New(loc, var/new_ammo = -1, direction)
	if(new_ammo >= 0)
		ammo = new_ammo
	if(direction)
		dir = direction
	..()

/obj/item/marines/turret_deployer/attack_self(mob/user)
	dir = user.dir
	user << "<span class='notice'>Once deployed, turret will face [dir2text(dir)].</span>"

/obj/item/marines/turret_deployer/ui_action_click()
	try_to_deploy()

/obj/item/marines/turret_deployer/proc/try_to_deploy()
	var/mob/living/carbon/human/user = usr
	if(deploy_try > 1)
		deploy_try--
		user << "<span class='danger'>Check the direction before deploying. Once deployed, direction cannot be changed!!<br>Current direction: [dir2text(dir)].<br>[deploy_try] tries left.</span>"
	else
		user << "<span class='danger'>Deploying...</span>"
		if(do_mob(user, user, 150))
			if(isturf(user.loc))
				var/turf/T = user.loc
				for(var/atom/A in T.contents)
					if(ismob(A))
						continue
					if(A.density)
						user << "<span class='danger'>Bad position.</span>"
						break
				new /obj/machinery/marines/gun_turret(T,dir,ammo)
				qdel(src)
			else
				user << "<span class='danger'>Bad position.</span>"

/obj/machinery/marines/gun_turret
	name = "Sentry Turret"
	desc = "USCM defense turret. It really packs a bunch."
	density = 1
	anchored = 1
	var/state = 0 //Like stat on mobs, 0 is alive, 1 is damaged, 2 is dead
	var/atom/cur_target = null
	var/scan_range = 9 //You will never see them coming
	var/health = 200
	var/base_icon_state = "syndieturret"
	var/projectile_type = /obj/item/projectile/bullet/turret
	var/fire_sound = 'sound/cmr/effects/turret_firing.ogg'
	icon = 'icons/obj/turrets.dmi'
	icon_state = "syndieturret0"

	var/direction = 2
	var/ammo = 500
	var/idle_count = 0
	var/firing = 0

	var/stationary = 0

/obj/machinery/marines/gun_turret/New(loc, var/new_dir = 2, var/new_ammo = -1)
	..()
	if(new_ammo >= 0)
		ammo = new_ammo
	if(!stationary)
		direction = new_dir
		dir = new_dir
	playsound(src, 'sound/cmr/effects/turret_deploy.ogg', 50)
	take_damage(0) //check your health
	icon_state = "[base_icon_state]" + "0"

/obj/machinery/marines/gun_turret/attackby(obj/item/W as obj, mob/user as mob)
	if(stationary)
		return

	if(istype(W, /obj/item/weapon/wrench))
		user.visible_message("\blue \The [user] starts to unbolt \the [src] from the plating...")
		if(!do_after(user,300, target = src))
			user.visible_message("\blue \The [user] decides not to unbolt \the [src].")
			return
		user.visible_message("\blue \The [user] finishes unfastening \the [src]!")
		if(state < 2)
			new /obj/item/marines/turret_deployer(loc, ammo, direction)
		qdel(src)
		return

/obj/machinery/marines/gun_turret/ex_act(severity, target)
	switch(severity)
		if(1)
			die()
		if(2)
			take_damage(100)
		if(3)
			take_damage(50)
	return

/obj/machinery/marines/gun_turret/emp_act() //Can't emp an mechanical turret.
	return

/obj/machinery/marines/gun_turret/update_icon()
	if(state > 2 || state < 0) //someone fucked up the vars so fix them
		take_damage(0)
	icon_state = "[base_icon_state]" + "[state]"
	return


/obj/machinery/marines/gun_turret/proc/take_damage(damage)
	health -= damage
	switch(health)
		if(101 to INFINITY)
			state = 0
		if(1 to 100)
			state = 1
		if(-INFINITY to 0)
			if(state != 2)
				die()
				return
			state = 2
	update_icon()
	return


/obj/machinery/marines/gun_turret/bullet_act(obj/item/projectile/Proj)
	take_damage(Proj.damage)
	return

/obj/machinery/marines/gun_turret/proc/die()
	playsound(src.loc, "sparks", 100, 1)
	state = 2
	update_icon()

/obj/machinery/marines/gun_turret/attack_hand(mob/user)
	return

/obj/machinery/marines/gun_turret/attack_ai(mob/user)
	return attack_hand(user)


/obj/machinery/marines/gun_turret/attack_alien(mob/living/carbon/alien/humanoid/user)
	user.changeNext_move(CLICK_CD_MELEE)
	user.do_attack_animation(src)
	user.visible_message("<span class='danger'>[user] slashes at [src]!</span>", "<span class='danger'>You slash at [src]!</span>")
	playsound(src.loc, 'sound/weapons/slash.ogg', 100, 1)
	take_damage(rand(user.damagemin, user.damagemax))
	return

/obj/machinery/marines/gun_turret/proc/validate_target(atom/target)
	if(!(target in view(scan_range,src)))
		return 0
	if(get_dist(target, src)>scan_range)
		return 0
	if(istype(target, /mob))
		var/mob/M = target
		if(M.stat != DEAD)
			return 1
	else if(istype(target, /obj/item/clothing/mask/facehugger))
		var/obj/item/clothing/mask/facehugger/FH = target
		if(FH.stat != DEAD)
			return 1
	else if(istype(target, /obj/mecha))
		var/obj/mecha/M = target
		if(M.occupant)
			return 1
	return 0


/obj/machinery/marines/gun_turret/process()
	if(state == 2)
		return
	if(!ammo)
		return
	spawn()
		if(!validate_target(cur_target))
			cur_target = null
		if(!cur_target)
			cur_target = get_target()
		if(!firing)
			if(cur_target)
				firing()
			else
				if(stationary)
					return
				idle_count++
				if(idle_count > 3)
					idle_count = 0
					playsound(src, 'sound/cmr/effects/turret_idle.ogg', 50)
	return

/obj/machinery/marines/gun_turret/proc/firing()
	firing = 1
	while(cur_target)
		if(state == 2)
			cur_target = null
			return
		if(!ammo)
			cur_target = null
			return
		if(!get_shooting_dir(cur_target))
			cur_target = null
			return
		ammo--
		fire(cur_target)
		sleep(3)
	firing = 0

/obj/machinery/marines/gun_turret/proc/get_shooting_dir(atom/target)
	if(direction == NORTH)
		if(get_dir(target, src) in list(SOUTHWEST,SOUTH,SOUTHEAST))
			return 1
	else if(direction == SOUTH)
		if(get_dir(target, src) in list(NORTHWEST,NORTH,NORTHEAST))
			return 1
	else if(direction == EAST)
		if(get_dir(target, src) in list(NORTHWEST,WEST,SOUTHWEST))
			return 1
	else if(direction == WEST)
		if(get_dir(target, src) in list(NORTHEAST, EAST, SOUTHEAST))
			return 1
	return 0

/obj/machinery/marines/gun_turret/proc/get_target()
	var/list/pos_targets = list()
	var/target = null
	for(var/obj/item/clothing/mask/facehugger/FH in view(scan_range,src))
		if(!istype(FH))
			continue
		if(!get_shooting_dir(FH))
			continue
		if(FH.stat == DEAD)
			continue
		pos_targets += FH
	for(var/mob/living/carbon/alien/M in view(scan_range,src))
		if(!istype(M))
			continue
		if(!get_shooting_dir(M))
			continue
		if(M.stat == DEAD)
			continue
		pos_targets += M
	if(pos_targets.len)
		target = pick(pos_targets)
	return target


/obj/machinery/marines/gun_turret/proc/fire(atom/target)
	if(!target)
		cur_target = null
		return
	src.dir = get_dir(src,target)
	var/turf/targloc = get_turf(target)
	if(!src)
		return
	var/turf/curloc = get_turf(src)
	if (!targloc || !curloc)
		return
	if (targloc == curloc)
		return
	playsound(src, fire_sound, 100, 1)
	var/obj/item/projectile/A = new projectile_type(curloc)
	A.original = target
	A.current = curloc
	A.starting = curloc
	A.yo = targloc.y - curloc.y
	A.xo = targloc.x - curloc.x
	A.fire()
	return

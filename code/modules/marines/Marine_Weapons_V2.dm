///***Bullets***///
/obj/item/projectile/bullet/m4a3 //Colt 45 Pistol
	damage = 25
	sound_fx = 1
	dispersion = 0.5
	penetration = -20

/obj/item/projectile/bullet/vp78
	damage = 40
	sound_fx = 1
	dispersion = 0.6

/obj/item/projectile/bullet/m44m //44 Magnum Peacemaker
	damage = 45
	sound_fx = 1
	dispersion = 0.6

/obj/item/projectile/bullet/m39 // M39 SMG
	damage = 15
	sound_fx = 1
	dispersion = 1
	penetration = -40

/obj/item/projectile/bullet/m39/incendiary
	icon_state = "tracer"

/obj/item/projectile/bullet/m39/incendiary/on_hit(atom/target, blocked = 0)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(3)
		M.IgniteMob()

/obj/item/projectile/bullet/m41 //M41 Assault Rifle
	damage = 20
	sound_fx = 1
	dispersion = 0.5
	penetration = 30

/obj/item/projectile/bullet/m37 //M37 Pump Shotgun
	name = "pellet"
	icon_state = "pellet"

/obj/item/projectile/bullet/m37/buckshot
	damage = 13
	dispersion = 1.5

/obj/item/projectile/bullet/m37/flechette
	damage = 30
	dispersion = 1
	penetration = -60

/obj/item/projectile/bullet/m37/slug
	damage = 150
	dispersion = 0.5
	penetration = 60

/obj/item/projectile/bullet/m37/buckshot/on_fire()
	..()
	pixel_x += rand(-8,8)
	pixel_y += rand(-8,8)

/obj/item/projectile/bullet/m37/flechette/on_fire()
	..()
	pixel_x += rand(-8,8)
	pixel_y += rand(-8,8)


/obj/item/projectile/bullet/a10x28 //M59B Smartgun
	damage = 30
	sound_fx = 1
	dispersion = 0.5

/obj/item/projectile/bullet/m42c
	icon_state = "tracer"
	layer = 16
	damage = 120
	sound_fx = 1
	dispersion = 0.2
	penetration = 80

	var/special = 0

/obj/item/projectile/bullet/m42c/incendiary
	damage = 90
	penetration = 70

/obj/item/projectile/bullet/m42c/special
	damage = 140
	dispersion = 0.1
	special = 1
	penetration = 100

/obj/item/projectile/bullet/m42c/on_hit(atom/target, blocked = 0)
	..()
	spawn(7)
		if(special ? prob(100) : prob(50) && target && isliving(target))
			var/mob/living/L = target
			if(L.stat == DEAD)
				L.gib()

/obj/item/projectile/bullet/m42c/incendiary/on_hit(atom/target, blocked = 0)
	..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(20)
		M.IgniteMob()

/obj/item/projectile/bullet/machinegun
	damage = 60
	sound_fx = 1
	dispersion = 0.5
	penetration = 50

/obj/item/projectile/bullet/turret
	damage = 25
	sound_fx = 1
	dispersion = 0.5
	penetration = -30

/obj/item/projectile/bullet/turret/on_hit(atom/target, blocked = 0)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		if(M.stat == DEAD && prob(15))
			M.gib()

/obj/item/projectile/bullet/rocket
	name = "rocket"
	sound_fx = 1
	sound_fx_type = "rocket"
	dispersion = 0.5

/obj/item/projectile/bullet/rocket/on_fire()
	var/datum/effect/effect/system/smoke_spread/smoke = new
	smoke.set_up(1, 0, loc)
	smoke.start()

/obj/item/projectile/bullet/rocket/he
	icon_state = "rocket_he"
	damage = 100
	penetration = -50

/obj/item/projectile/bullet/rocket/he/on_hit(atom/target, blocked = 0)
	..()
	explosion(get_turf(get_step(src, oppositedir(dir))), 1, 2, 3, 2, 1, flame_range = 5)
	return 1

/obj/item/projectile/bullet/rocket/ap
	icon_state = "rocket_ap"
	damage = 100
	penetration = 60

/obj/item/projectile/bullet/rocket/ap/on_hit(atom/target, blocked = 0)
	..()
	explosion(target, 1, 2, 3, 2, 1, flame_range = 3)
	return 1

///***Ammo***///

/obj/item/ammo_casing/m4a3 //45 Pistol
	desc = "A .45 special bullet casing."
	caliber = "45s"
	projectile_type = /obj/item/projectile/bullet/m4a3

/obj/item/ammo_casing/vp78 //VP78 Pistol
	desc = "A 9mm squash head bullet casing."
	caliber = "9mmsh"
	projectile_type = /obj/item/projectile/bullet/vp78

/obj/item/ammo_casing/m44m //44 Magnum Peacemaker
	desc = "A 44 Magnum bullet casing."
	caliber = "38s"
	projectile_type = /obj/item/projectile/bullet/m44m

/obj/item/ammo_casing/m39 // M39 SMG
	desc = "A .9mm special bullet casing."
	caliber = "9mms"
	projectile_type = /obj/item/projectile/bullet/m39

/obj/item/ammo_casing/m39/incendiary
	projectile_type = /obj/item/projectile/bullet/m39/incendiary

/obj/item/ammo_casing/m41 //M41Assault Rifle
	desc = "A 10mm special bullet casing."
	caliber = "10mms"
	projectile_type = /obj/item/projectile/bullet/m41

/obj/item/ammo_casing/m37 //M37 Pump Shotgun
	name = "Shotgun shell"
	desc = "A 12 gauge shell."
	caliber = "12gs"

/obj/item/ammo_casing/m37/buckshot
	name = "Shotgun shell"
	desc = "A 12 gauge shell."
	icon_state = "buckshell"
	projectile_type = /obj/item/projectile/bullet/m37/buckshot
	pellets = 11
	variance = 0.8

/obj/item/ammo_casing/m37/flechette
	name = "Shotgun shell"
	desc = "A 12 gauge flechette shell."
	icon_state = "flecshell"
	projectile_type = /obj/item/projectile/bullet/m37/flechette
	pellets = 10
	variance = 0.8

/obj/item/ammo_casing/m37/slug
	name = "Shotgun shell"
	desc = "A 12 gauge slug shell."
	icon_state = "slugshell"
	projectile_type = /obj/item/projectile/bullet/m37/slug

/obj/item/ammo_casing/a10x28 //M59B Smartgun
	desc = "A 10mm special bullet casing."
	caliber = "a10x28"
	projectile_type = /obj/item/projectile/bullet/a10x28

/obj/item/ammo_casing/m42c
	desc = "A 10mm special bullet casing."
	caliber = "a10x26"
	projectile_type = /obj/item/projectile/bullet/m42c

/obj/item/ammo_casing/m42c/incendiary
	projectile_type = /obj/item/projectile/bullet/m42c/incendiary

/obj/item/ammo_casing/m42c/special
	projectile_type = /obj/item/projectile/bullet/m42c/special

/obj/item/ammo_casing/rocket
	caliber = "60mm"
	w_class = 5

/obj/item/ammo_casing/rocket/update_icon()
	if(BB)
		icon_state = "rocket-[istype(src, /obj/item/ammo_casing/rocket/he) ? "he" : "ap"]-live"//if there will be more than two type of rockets in future, this and below must be rewritten.
	else
		icon_state = "rocket-[istype(src, /obj/item/ammo_casing/rocket/he) ? "he" : "ap"]"

/obj/item/ammo_casing/rocket/he
	name = "Rocket (High Explosive)"
	icon_state = "rocket_he"
	projectile_type = /obj/item/projectile/bullet/rocket/he

/obj/item/ammo_casing/rocket/ap
	name = "Rocket (Armor Piercing)"
	icon_state = "rocket_ap"
	projectile_type = /obj/item/projectile/bullet/rocket/ap

///***Ammo Boxes***///

/obj/item/ammo_box/magazine/m4a3 //45 Pistol
	name = "M4A3 Magazine (.45)"
	desc = "A magazine with .45 ammo"
	icon_state = ".45a"
	ammo_type = /obj/item/ammo_casing/m4a3
	max_ammo = 12

/obj/item/ammo_box/magazine/m4a3/update_icon()
	..()
	icon_state = ".45a[ammo_count() ? "" : "0"]"

/obj/item/ammo_box/magazine/vp78
	name = "VP78 Magazine"
	desc = "A magazine with 9mm ammo"
	icon_state = "vp78"
	ammo_type = /obj/item/ammo_casing/vp78
	max_ammo = 18

/obj/item/ammo_box/magazine/vp78/update_icon()
	..()
	icon_state = "vp78[ammo_count() ? "" : "-0"]"

/obj/item/ammo_box/magazine/m44m // 44 Magnum Peacemaker
	name = "44 Magnum Speed Loader (.44)"
	desc = "A 44 Magnum speed loader"
	icon_state = "38"
	ammo_type = "/obj/item/ammo_casing/m44m"
	max_ammo = 6
	multiple_sprites = 1

/obj/item/ammo_box/magazine/m39 // M39 SMG
	name = "M39 SMG Mag (9mm)"
	desc = "A 9mm special magazine"
	icon_state = "9x19p-8"
	ammo_type = /obj/item/ammo_casing/m39
	max_ammo = 48

/obj/item/ammo_box/magazine/m39/highcap
	name = "M39 SMG Mag (High Cap)"
	desc = "A 9mm special magazine"
	max_ammo = 70

/obj/item/ammo_box/magazine/m39/highcap/incendiary
	name = "M39 SMG Mag (Incendiary)"
	desc = "A 9mm special magazine"
	ammo_type = /obj/item/ammo_casing/m39/incendiary

/obj/item/ammo_box/magazine/m39/update_icon()
	..()
	icon_state = "9x19p[ammo_count() ? "-8" : "-0"]"

/obj/item/ammo_box/magazine/m41 //M41 Assault Rifle
	name = "M41A Magazine (10mm)"
	desc = "A 10mm special magazine"
	icon_state = "10caseless"
	ammo_type = /obj/item/ammo_casing/m41
	max_ammo = 40

/obj/item/ammo_box/magazine/m41/update_icon()
	..()
	icon_state = "[initial(icon_state)][ammo_count() ? "" : "-0"]"

/obj/item/ammo_box/m37 //M37 Shotgun
	icon = 'icons/obj/storage.dmi'
	icon_state = "shells"
	max_ammo = 7

/obj/item/ammo_box/m37/buckshot
	name = "M37 Shotgun buckshot shells (box)"
	desc = "A box of standard issue high-powered 12 gauge buckshot rounds. Manufactured by Armat Systems for military and civilian use."
	icon = 'icons/obj/storage.dmi'
	icon_state = "buckshells"
	ammo_type = /obj/item/ammo_casing/m37/buckshot

/obj/item/ammo_box/m37/flechette
	name = "M37 Shotgun flechette shells (box)"
	desc = "A box of standard issue high-powered 12 gauge flechette rounds. Manufactured by Armat Systems for military and civilian use."
	icon = 'icons/obj/storage.dmi'
	icon_state = "flecshells"
	ammo_type = /obj/item/ammo_casing/m37/flechette

/obj/item/ammo_box/m37/slug
	name = "M37 Shotgun slug shells (box)"
	desc = "A box of standard issue high-powered 12 gauge slug rounds. Manufactured by Armat Systems for military and civilian use."
	icon = 'icons/obj/storage.dmi'
	icon_state = "slugshells"
	ammo_type = /obj/item/ammo_casing/m37/slug

/obj/item/ammo_box/magazine/internal/m37
	name = "combat shotgun internal magazine"
	desc = "Oh god, this shouldn't be here"
	ammo_type = /obj/item/ammo_casing/m37
	caliber = "12gs"
	max_ammo = 7
	multiload = 0
	new_and_loaded = 0

/obj/item/ammo_box/magazine/internal/combat
	name = "combat shotgun internal magazine"
	desc = "Oh god, this shouldn't be here"
	ammo_type = /obj/item/ammo_casing/m37
	caliber = "12gs"
	max_ammo = 5
	multiload = 0
	new_and_loaded = 0

/obj/item/ammo_box/magazine/a10x28 //M59B Smartgun
	name = "Magazine (10x28)"
	desc = "A 10mm special magazine"
	icon_state = "a10x28"
	ammo_type = /obj/item/ammo_casing/a10x28
	max_ammo = 150

/obj/item/ammo_box/magazine/a10x28/update_icon()
	..()
	icon_state = "[initial(icon_state)][ammo_count() ? "" : "-0"]"

/obj/item/ammo_box/magazine/m42c
	name = "Magazine (10x26)"
	desc = "A 10mm magazine"
	icon_state = "m42c"
	ammo_type = /obj/item/ammo_casing/m42c
	max_ammo = 6

/obj/item/ammo_box/magazine/m42c/incendiary
	name = "Magazine (10x26 incendiary)"
	desc = "A 10mm magazine with incendiary rounds"
	ammo_type = /obj/item/ammo_casing/m42c/incendiary

/obj/item/ammo_box/magazine/m42c/special
	name = "Magazine (10x26 special)"
	desc = "A 10mm magazine with special rounds"
	ammo_type = /obj/item/ammo_casing/m42c/special

/obj/item/ammo_box/magazine/m42c/update_icon()
	..()
	icon_state = "[initial(icon_state)][ammo_count() ? "" : "-0"]"

/obj/item/ammo_box/magazine/internal/m6b
	name = "m-6b rocket launcher internal magazine"
	desc = "Oh god, this shouldn't be here"
	ammo_type = /obj/item/ammo_casing/rocket
	caliber = "60mm"
	max_ammo = 1
	multiload = 0
	new_and_loaded = 0

///***Pistols***///

/obj/item/weapon/gun/projectile/pistol/m4a3 //45 Pistol
	name = "M4A3 Service Pistol"
	desc = "M4A3 Service Pistol, the standard issue sidearm of the Colonial Marines. Uses .45 special rounds."
	icon_state = "m4a3"
	w_class = 2
	mag_type = /obj/item/ammo_box/magazine/m4a3
	new_and_loaded = 0
	can_suppress = 0
	burst_size = 1
	fire_delay = 0
	fire_sound = 'sound/weapons/servicepistol.ogg'

/obj/item/weapon/gun/projectile/pistol/m4a3_hiks //45 Pistol
	name = "Cpl. Hicks' pistol"
	desc = "Personal weapons. Uses .45 special rounds."
	icon_state = "pistol"
	w_class = 2
	mag_type = /obj/item/ammo_box/magazine/m4a3
	new_and_loaded = 0
	can_suppress = 0
	burst_size = 1
	fire_delay = 0
	fire_sound = 'sound/weapons/servicepistol.ogg'

/obj/item/weapon/gun/projectile/pistol/m4a3/update_icon()
	..()
	icon_state = "[initial(icon_state)][magazine ? "" : "-e"]"

/obj/item/weapon/gun/projectile/pistol/VP78 //VP78
	name = "VP78 pistol"
	desc = "A specially made pistol manufactured by the Weyland Yutani corporation. Chambered with custom-made rounds."
	icon_state = "vp78"
	w_class = 2
	mag_type = /obj/item/ammo_box/magazine/vp78
	new_and_loaded = 0
	can_suppress = 0
	burst_size = 1
	fire_delay = 0
	fire_sound = 'sound/cmr/weapons/Gunshot_vp78.ogg'

/obj/item/weapon/gun/projectile/pistol/VP78/update_icon()
	return

/*
/obj/item/weapon/gun/projectile/pistol/m4a3/afterattack(atom/target as mob|obj|turf|area, mob/living/user as mob|obj, flag)
	..()
	if(!loaded.len && empty_mag)
		empty_mag.loc = get_turf(src.loc)
		empty_mag = null
	return*/



/obj/item/weapon/gun/projectile/m44m //mm44 Magnum Peacemaker
	name = "44 Magnum"
	desc = "A bulky 44 Magnum revolver, occasionally carried by assault troops and officers in the Colonial Marines. Uses 44 Magnum rounds"
	icon_state = "mateba"
	mag_type = /obj/item/ammo_box/magazine/m44m

/obj/item/weapon/gun/projectile/m44panther //mm44 Magnum Peacemaker
	name = "44 Magnum"
	desc = "A bulky 44 Magnum revolver, occasionally carried by assault troops and officers in the Colonial Marines. Uses 44 Magnum rounds"
	icon_state = "detective_panther"
	mag_type = /obj/item/ammo_box/magazine/m44m
	w_class = 3

///***SMGS***///

/obj/item/weapon/gun/projectile/Assault/m39 // M39 SMG
	name = "M39 SMG"
	desc = " Armat Battlefield Systems M39 SMG. Occasionally carried by light-infantry, scouts or non-combat personnel. Uses 9mm rounds."
	icon_state = "m39"
	item_state = "c20r"
	w_class = 4
	can_suppress = 0
	mag_type = /obj/item/ammo_box/magazine/m39
	new_and_loaded = 0
	fire_sound = 'sound/weapons/Gunshot2.ogg'
	fire_delay = 1
	burst_size = 1
	can_flashlight = 1

	var/obj/item/device/mod/scope = null
	zoomdevicename = "Reflex Sight"

/obj/item/weapon/gun/projectile/Assault/m39/process_chamber(eject_casing = 0, empty_chamber = 1, no_casing = 1)
	..()

/obj/item/weapon/gun/projectile/Assault/m39/attackby(obj/item/A, mob/user, params)
	if(istype(A, /obj/item/device/mod/scope4) && !scope)
		if(user.l_hand != src && user.r_hand != src)
			user << "<span class='warning'>You'll need [src] in your hands to do that!</span>"
			return
		if(!user.unEquip(A))
			user << "<span class='warning'>\The [A] is stuck to you and cannot be installed onto the [name].</span>"
			return

		var/obj/item/device/mod/scope4/S = A
		user << "<span class='notice'>You click [S] into place on [src].</span>"
		scope = S
		S.installed = src
		S.loc = src
		update_icon()
	else
		..()

/obj/item/weapon/gun/projectile/Assault/m39/update_icon()
	..()
	icon_state = "[initial(icon_state)][magazine ? "" : "-e"]"
	overlays.Cut()
	if(scope)
		var/image/mod = image("icon" = 'icons/obj/guns/projectile.dmi', "icon_state" = "m39-s")
		overlays += mod
	return

///***RIFLES***///

/obj/item/weapon/gun/projectile/Assault/m41 //M41 Assault Rifle
	name = "M41A MK2"
	desc = "M41A Pulse Rifle MK2. The standard issue rifle of the Colonial Marines. Commonly carried by most combat personnel. Uses 10mm special ammunition."
	icon_state = "m41a"
	item_state = "m41a"
	w_class = 4
	mag_type = /obj/item/ammo_box/magazine/m41
	new_and_loaded = 0
	fire_sound = 'sound/weapons/Gunshot_m41.ogg'
	can_suppress = 0
	var/obj/item/weapon/gun/projectile/revolver/grenadelauncher/underbarrel
	burst_size = 1
	fire_delay = 1.5
	two_handed = 1
	var/select = 1
	action_button_name = "Toggle Firemode"
	can_flashlight = 1

	var/obj/item/device/mod/scope = null
	zoomdevicename = "Reflex Sight"

/obj/item/weapon/gun/projectile/Assault/m41/New()
	..()
	underbarrel = new /obj/item/weapon/gun/projectile/revolver/grenadelauncher(src)
	update_icon()
	return

/obj/item/weapon/gun/projectile/Assault/m41/process_chamber(eject_casing = 0, empty_chamber = 1, no_casing = 1)
	..()

/obj/item/weapon/gun/projectile/Assault/m41/afterattack(atom/target, mob/living/user, flag, params)
	if(select == 2)
		underbarrel.afterattack(target, user, flag, params)
	else
		..()
		return

/obj/item/weapon/gun/projectile/Assault/m41/attackby(obj/item/A, mob/user, params)
	if(istype(A, /obj/item/device/mod/scope4) && !scope && user.unEquip(A))
		if(user.l_hand != src && user.r_hand != src)
			user << "<span class='warning'>You'll need [src] in your hands to do that!</span>"
			return
		if(!user.unEquip(A))
			user << "<span class='warning'>\The [A] is stuck to you and cannot be installed onto the [name].</span>"
			return

		var/obj/item/device/mod/scope4/S = A
		user << "<span class='notice'>You click [S] into place on [src].</span>"
		scope = S
		S.installed = src
		S.loc = src
		update_icon()
	else if(istype(A, /obj/item/ammo_casing))
		if(istype(A, underbarrel.magazine.ammo_type))
			underbarrel.attack_self()
			underbarrel.attackby(A, user, params)
	else
		..()

/obj/item/weapon/gun/projectile/Assault/m41/update_icon()
	..()
	icon_state = "[initial(icon_state)][magazine ? "" : "-e"]"
	overlays.Cut()
	if(scope)
		var/image/mod = image("icon" = 'icons/obj/guns/projectile.dmi', "icon_state" = "m41a-s")
		overlays += mod
	return

/obj/item/weapon/gun/projectile/Assault/m41/ui_action_click()
	burst_select()

/obj/item/weapon/gun/projectile/Assault/m41/proc/burst_select()
	var/mob/living/carbon/human/user = usr
	switch(select)
		if(1)
			select = 2
			user << "<span class='notice'>You switch to grenades.</span>"
		if(2)
			select = 1
			burst_size = initial(burst_size)
			fire_delay = initial(fire_delay)
			user << "<span class='notice'>You switch to fully-auto.</span>"
	playsound(user, 'sound/weapons/empty.ogg', 100, 1)
	update_icon()
	return

/obj/item/weapon/gun/projectile/Assault/m41/verb/selectfire()
	set name = "Rifle: selectfire" // i put such name after ":" - so it easier to understand which exact macro command we need.
	set category = "Weapon"

	var/mob/living/carbon/human/user = usr
	switch(select)
		if(1)
			select = 2
			user << "<span class='notice'>You switch to grenades.</span>"
		if(2)
			select = 1
			burst_size = initial(burst_size)
			fire_delay = initial(fire_delay)
			user << "<span class='notice'>You switch to fully-auto.</span>"
	playsound(user, 'sound/weapons/empty.ogg', 100, 1)
	update_icon()
	return

///***SHOTGUNS***///

/obj/item/weapon/gun/projectile/shotgun/m37 //M37 Pump Shotgun
	name = "M37A2 Pump Shotgun"
	desc = "Colonial Marine M37 Pump Shotgun"
	icon_state = "m37a2"
	item_state = "shotgun"
	w_class = 4
	force = 10
	flags =  CONDUCT
	slot_flags = SLOT_BACK
	mag_type = /obj/item/ammo_box/magazine/internal/m37
	new_and_chambered = 0
	two_handed = 1

/obj/item/weapon/gun/projectile/shotgun/verb/pump()
	set name = "Shotgun: pump"
	set category = "Weapon"

	var/mob/living/carbon/human/user = usr
	if(recentpump)	return
	do_pump(user)
	recentpump = 1
	spawn(10)
		recentpump = 0
	return

/obj/item/weapon/gun/projectile/shotgun/combat
	name = "combat shotgun"
	desc = "A semi automatic shotgun with tactical furniture and a five-shell capacity underneath."
	icon_state = "cshotgun"
	origin_tech = "combat=5;materials=2"
	mag_type = /obj/item/ammo_box/magazine/internal/combat
	w_class = 5
	two_handed = 1

/obj/item/weapon/gun/projectile/shotgun/combat/shoot_live_shot(mob/living/user as mob|obj)
	..()
	src.do_pump(user)

///***m59b***///
/obj/item/weapon/gun/var/smart_weapon = 0

/obj/item/weapon/gun/projectile/Assault/m59b
	name = "M59/B Smartgun"
	desc = "Colonial Marine M59/B Smartgun, uses 10x28 ammunition."
	icon_state = "smartgun"
	item_state = "l6closedmag" //temp
	w_class = 4
	force = 10
	flags =  CONDUCT
	slot_flags = SLOT_BACK
	mag_type = /obj/item/ammo_box/magazine/a10x28
	new_and_loaded = 0
	fire_sound = 'sound/weapons/Gunshot_m59.ogg'
	fire_delay = 1
	burst_size = 1
	two_handed = 1
	smart_weapon = 1
	action_button_name = "Aim Mode"
	var/smart_aim = 1
	var/mob/living/locked_target = null
	var/obj/screen/ammo_counter

/obj/item/weapon/gun/projectile/Assault/m59b/New()
	..()
	SSobj.processing |= src

	ammo_counter = new /obj/screen()
	ammo_counter.name = "ammo"
	ammo_counter.screen_loc = "CENTER+1,CENTER-1"
	ammo_counter.layer = 20

	update_ammo()

/obj/item/weapon/gun/projectile/Assault/m59b/Destroy()
	SSobj.processing -= src
	..()

/obj/item/weapon/gun/projectile/Assault/m59b/process()
	if(smart_aim && ismob(loc) && locked_target)
		if(locked_target.stat == DEAD)
			target_reset(loc)
	return

/obj/item/weapon/gun/projectile/Assault/m59b/process_chamber(eject_casing = 0, empty_chamber = 1, no_casing = 1)
	..()

/obj/item/weapon/gun/projectile/Assault/m59b/afterattack(atom/target, mob/living/user, flag, params)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.head && istype(H.head, /obj/item/clothing/head/helmet/space/pa))
			var/obj/item/clothing/head/helmet/space/pa/helmet = H.head
			if(helmet.activated && helmet.nuclear_cell.charge)
				helmet.drain_power(75)
				if(chambered && chambered.BB)
					chambered.BB.damage += rand(5,15)
					..()
					update_ammo()
				return
		if(H.wear_suit && istype(H.wear_suit, /obj/item/clothing/suit/storage/marine2/harness))
			var/obj/item/clothing/suit/storage/marine2/harness/Armor = H.wear_suit
			if(Armor.harness_cell && (Armor.harness_cell.charge >= 30))
				if(smart_aim)
					if(target == user)
						target_reset(user)
						return

					if(!locked_target)
						target_get(target)

					if(locked_target && (locked_target.stat == DEAD))
						target_reset(user)
					else if(locked_target)
						if(ismob(target) && target != locked_target)
							target_reset(user)
							target_get(target)
						else if(get_dist(locked_target,user) > 7)
							target_reset(user)
						else if(get_dist(locked_target,user.ms_last_pos) > 1)
							target_reset(user)
						if(locked_target)
							target = locked_target

				var/obj/item/weapon/gun/offhand/O = H.get_inactive_hand()
				if(istype(O))
					if(chambered && chambered.BB)
						if(smart_aim)
							chambered.BB.damage -= 5
					..()
					Armor.harness_cell.charge -= 30
					Armor.update_power()
					update_ammo()
				else
					H.mouse_hold = 0
					return
			else
				H.mouse_hold = 0
				user << "<span class='warning'>Not enough charge.</span>"
				return
		else
			H.mouse_hold = 0
			user << "<span class='warning'>No power.</span>"
			return
	return

/obj/item/weapon/gun/projectile/Assault/m59b/proc/target_get(atom/A)
	if(ishuman(loc))
		var/mob/living/carbon/human/user = loc
		if(ismob(A))
			var/mob/living/L = A
			if(L.stat == DEAD)
				target_get(get_turf(L),user)
			else
				target_lock(L,user)
		else
			var/list/targets = list()
			for(var/mob/living/L in view(1,user.ms_last_pos))
				if(ishuman(L))
					var/mob/living/carbon/human/H = L
					if(H.wear_suit && istype(H.wear_suit, /obj/item/clothing/suit/storage/marine2))
						continue
				if(L.stat == DEAD)
					continue
				if(L != user)
					targets += L
			if(targets.len)
				target_lock(pick(targets),user)

/obj/item/weapon/gun/projectile/Assault/m59b/proc/target_lock(mob/living/A, mob/living/carbon/human/user)
	if(!istype(A) || !istype(user))
		return

	if(locked_target)
		return

	var/image/I
	if(isalienadult(A))
		var/mob/living/carbon/alien/humanoid/H = A
		var/pix_x = -H.custom_pixel_x_offset
		var/pix_y = -H.custom_pixel_y_offset
		I = image('icons/marines/cr_lock.dmi', loc = A, icon_state = "hms_lock", layer = 16, pixel_x = pix_x, pixel_y = pix_y)
	else
		I = image('icons/marines/cr_lock.dmi', loc = A, icon_state = "hms_lock", layer = 16)
	if(user.glasses && istype(user.glasses, /obj/item/clothing/glasses/hms))
		user.client.images += I
	locked_target = A
	user << 'sound/items/timer.ogg'

/obj/item/weapon/gun/projectile/Assault/m59b/proc/target_reset(mob/living/carbon/human/user)
	locked_target = null
	if(user && user.client)
		for(var/image/I in user.client.images)
			if(I.icon_state == "hms_lock")
				user.client.images.Remove(I)

/obj/item/weapon/gun/projectile/Assault/m59b/ui_action_click()
	aimmode()

/obj/item/weapon/gun/projectile/Assault/m59b/proc/aimmode()
	var/mob/living/carbon/human/user = usr
	switch(smart_aim)
		if(1)
			smart_aim = 0
			target_reset(user)
			user << "<span class='notice'>Aiming: manual.</span>"
		if(0)
			smart_aim = 1
			user << "<span class='notice'>Aiming: auto.</span>"
	playsound(user, 'sound/weapons/empty.ogg', 100, 1)
	return

/obj/item/weapon/gun/projectile/Assault/m59b/pickup(mob/living/carbon/human/user)
	if(istype(user) && user.client)
		user.client.screen += ammo_counter

/obj/item/weapon/gun/projectile/Assault/m59b/dropped(mob/user)
	if(istype(user) && user.client)
		for(var/obj/screen/S in user.client.screen)
			if(S.name == "ammo")
				user.client.screen.Remove(S)
	target_reset(user)
	..()

/obj/item/weapon/gun/projectile/Assault/m59b/attackby(obj/item/I as obj, mob/user as mob)
	if(istype(I, /obj/item/ammo_box/magazine))
		if(do_reload(user, src, I, 25))
			if(user.get_active_hand() == I)
				..()
	else
		..()
	update_ammo()

/obj/item/weapon/gun/projectile/Assault/m59b/proc/update_ammo()
	if(ammo_counter)
		var/ammo = 0
		if(magazine)
			ammo = magazine.ammo_count()
		if(chambered)
			ammo += 1
		ammo_counter.maptext = "<div align='center' valign='middle' style='position:relative; top:0px; left:6px'><font color='#e40000'>[ammo]</font></div>"

/obj/item/clothing/glasses/hms
	name = "HMS"
	icon_state = "hms"
	desc = "The Head Mounted Sight. Allow user to see targets detected by the smartgun's infrared tracker."
	flags = null
	origin_tech = "magnets=3;biotech=2"

/obj/item/clothing/glasses/hms/New()
	..()
	SSobj.processing |= src

/obj/item/clothing/glasses/hms/Destroy()
	SSobj.processing -= src
	if(ishuman(loc))
		reset_treats(loc)
	..()

/obj/item/clothing/glasses/hms/proc/reset_treats(mob/living/carbon/human/user)
	if(user.client)
		for(var/image/I in user.client.images)
			if(I.icon_state == "hms_treats")
				user.client.images.Remove(I)

/obj/item/clothing/glasses/hms/process()
	if(ishuman(loc))
		var/mob/living/carbon/human/user = loc
		if(user.glasses == src && user.wear_suit && istype(user.wear_suit, /obj/item/clothing/suit/storage/marine2/harness))
			if(user.client)
				reset_treats(user)
				for(var/mob/living/L in living_mob_list)
					if(ishuman(L))
						var/mob/living/carbon/human/H = L
						if(H.wear_suit && istype(H.wear_suit, /obj/item/clothing/suit/storage/marine2))
							continue

					var/turf/location
					if(L.z == 0)
						var/turf/T = get_turf(L)
						if(T.z != user.z)
							continue
						else
							location = T
					else if(L.z != user.z)
						continue

					if(location && (get_dist(location,user) > 2))
						continue

					var/image/I
					if(isalienadult(L))
						var/mob/living/carbon/alien/humanoid/H = L
						var/pix_x = -H.custom_pixel_x_offset
						var/pix_y = -H.custom_pixel_y_offset
						I = image('icons/marines/cr_lock.dmi', loc = location ? location : L, icon_state = "hms_treats", layer = 16, pixel_x = pix_x, pixel_y = pix_y)
					else
						I = image('icons/marines/cr_lock.dmi', loc = location ? location : L, icon_state = "hms_treats", layer = 16)
					user.client.images += I

/obj/item/weapon/stock_parts/cell/harness_cell
	name = "combat harness power cell"
	maxcharge = 10000
	rating = 3
	chargerate = 500

/obj/item/clothing/suit/storage/marine2/harness
	name = "Combat harness"
	desc = "A harness for use with M59/B Smartgun."
	blood_overlay_type = "armor"
	armor = list(melee = 75, bullet = 80, laser = 50, energy = 10, bomb = 35, bio = 0, rad = 0)
	action_button_name = "Insert/Remove Battery"
	var/obj/item/weapon/stock_parts/cell/harness_cell
	var/obj/screen/power_counter

/obj/item/clothing/suit/storage/marine2/harness/New()
	..()
	harness_cell = new /obj/item/weapon/stock_parts/cell/harness_cell(src)

	power_counter = new /obj/screen()
	power_counter.name = "power"
	power_counter.screen_loc = "CENTER-1,CENTER-1"
	power_counter.layer = 20

	update_power()

/obj/item/clothing/suit/storage/marine2/harness/ui_action_click()
	ins_rem_battery()

/obj/item/clothing/suit/storage/marine2/harness/proc/ins_rem_battery()
	var/mob/living/carbon/human/user = usr
	if(harness_cell)
		if(user.get_active_hand())
			user << "<span class='warning'>You need a free hand to do that.</span>"
			return

		harness_cell.loc = get_turf(loc)
		user.put_in_hands(harness_cell)
		harness_cell = null
		user << "<span class='warming'>You took the [harness_cell] out of [src].</span>"
	else
		var/obj/item/weapon/stock_parts/cell/harness_cell/HC = user.get_active_hand()
		if(istype(HC))
			user.remove_from_mob(HC)
			harness_cell = HC
			HC.loc = src
			user << "<span class='notice'>You insert the [HC] into [src].</span>"

	update_power()

/obj/item/clothing/suit/storage/marine2/harness/proc/update_power()
	if(power_counter)
		var/power = 0
		if(harness_cell)
			power = harness_cell.charge * 100 / harness_cell.maxcharge
		power_counter.maptext = "<div align='center' valign='middle' style='position:relative; top:0px; left:6px'><font color='#e40000'>[power]</font></div>"

/obj/item/clothing/suit/storage/marine2/harness/equipped(mob/living/carbon/human/user, slot)
	..()
	if(istype(user) && user.client && slot == slot_wear_suit)
		user.client.screen += power_counter

/obj/item/clothing/suit/storage/marine2/harness/unequipped(mob/living/carbon/human/user)
	if(istype(user) && user.client && user.wear_suit != src)
		for(var/obj/screen/S in user.client.screen)
			if(S.name == "power")
				user.client.screen.Remove(S)
	..()

//M-6B Rocket Launcher
/obj/item/weapon/gun/projectile/rocket/m6b
	name = "M-6B Rocket Launcher"
	desc = ""
	icon_state = "m6b-e"
	item_state = "rocket"
	w_class = 5
	force = 10
	mag_type = /obj/item/ammo_box/magazine/internal/m6b
	fire_sound = 'sound/weapons/grenadelaunch.ogg'
	burst_size = 1
	fire_delay = 0
	two_handed = 1
	action_button_name = "Use Scope"
	zoomdevicename = "Scope"
	new_and_chambered = 0
	var/locking_in = 0

/obj/item/weapon/gun/projectile/rocket/m6b/ui_action_click()//Scope must be coded as separate item later.
	zoom()

/obj/item/weapon/gun/projectile/rocket/m6b/New()
	..()
	new/obj/item/action_buttons/weapons/m6b/unload_rocket(src)

/obj/item/action_buttons/weapons/m6b/unload_rocket/proc/unload_shell()
	var/mob/living/carbon/human/user = usr
	var/obj/item/weapon/gun/projectile/rocket/m6b/Gun = loc
	var/obj/item/ammo_box/magazine = Gun.magazine

	if(weapon_unload_check(user,Gun,1))
		if(magazine.stored_ammo.len)
			if(do_unload(user, Gun, 25))
				if(Gun.chambered)
					Gun.chambered = null
				var/obj/item/ammo_casing/AC = locate(/obj/item/ammo_casing) in magazine.stored_ammo
				if(AC)
					magazine.stored_ammo -= AC
					AC.loc = get_turf(src.loc)
					Gun.update_icon()
			else
				user << "<span class='warning'>Unloading has been interrupted!</span>"
		else
			user << "<span class='notice'>Nothing to unload.</span>"
	return

/obj/item/weapon/gun/projectile/rocket/m6b/afterattack(atom/target, mob/living/user, flag, params)
	if(!chambered || !chambered.BB)
		..()
		return

	if(!can_trigger_gun(user))
		return
	if(locking_in)
		return

	locking_in = 1
	var/turf/T = get_turf(target)
	var/image/I = image('icons/marines/cr_lock.dmi',loc = T, icon_state = "hms_treats", layer = 16)
	user.client.images += I
	spawn()
		var/scl = 6
		while(locking_in)
			scl--
			var/matrix/M = matrix()
			M.Scale(scl,scl)
			I.transform = M
			if(ismob(target))
				I.loc = get_turf(target)
			sleep(10)

	if(do_mob(user,user,50))
		if(!can_trigger_gun(user))
			return
		..()
	user.client.images -= I
	locking_in = 0

/obj/item/weapon/gun/projectile/rocket/m6b/update_icon()
	if(magazine)
		var/obj/item/ammo_casing/rocket/AC = locate(/obj/item/ammo_casing/rocket) in magazine
		if(AC)
			if(AC.BB)
				icon_state = "m6b-[istype(AC, /obj/item/ammo_casing/rocket/he) ? "he" : "ap"]"//if there will be more than two type of rockets in future, this and below must be rewritten.
			else
				icon_state = "m6b-[istype(AC, /obj/item/ammo_casing/rocket/he) ? "he" : "ap"]-e"
		else
			icon_state = "m6b-e"

/obj/item/weapon/gun/projectile/rocket/m6b/chamber_round()
	if ((chambered && chambered.BB)|| !magazine) //if there's a live ammo in the chamber or no magazine
		return
	else if (magazine.ammo_count())
		chambered = magazine.get_round(1)
	return

/obj/item/weapon/gun/projectile/rocket/m6b/process_chamber(eject_casing = 0, empty_chamber = 1)
	..()

/obj/item/weapon/gun/projectile/rocket/m6b/attackby(obj/item/A, mob/user, params)
	if(chambered || magazine.stored_ammo.len)
		user << "<span class='warning'>There is a rocket inside already, unload it first!</span>"
		return

	if(do_reload(user, src, A, 25))
		var/loaded = magazine.attackby(A, user, params, 1)
		if(loaded)
			user << "<span class='notice'>You load [A] into \the [src].</span>"
			update_icon()
			chamber_round()
	else
		user << "<span class='warning'>Loading has been interrupted!</span>"

//M42C
/obj/item/weapon/gun/projectile/Assault/m42c //M42C Scoped Rifle
	name = "M42C Rifle"
	desc = "The M42C Rifle is a sniper rifle manufactured by Armat Battlefield Systems and used primarily by the United States Colonial Marine Corps and Weyland-Yutani."
	icon_state = "m42c"
	item_state = "c20r"
	w_class = 4
	mag_type = /obj/item/ammo_box/magazine/m42c
	new_and_loaded = 0
	fire_sound = 'sound/cmr/weapons/Gunshot_m42c.ogg'
	can_suppress = 0
	burst_size = 1
	fire_delay = 25
	two_handed = 1

	var/obj/item/device/mod/scope = null
	zoomdevicename = "Rifle Scope"

/obj/item/weapon/gun/projectile/Assault/m42c/process_chamber(eject_casing = 0, empty_chamber = 1, no_casing = 1)
	..()

/obj/item/weapon/gun/projectile/Assault/m42c/attackby(obj/item/I as obj, mob/user as mob)
	if(istype(I, /obj/item/device/mod/scope1224) && !scope)
		if(user.l_hand != src && user.r_hand != src)
			user << "<span class='warning'>You'll need [src] in your hands to do that!</span>"
			return
		if(!user.unEquip(I))
			user << "<span class='warning'>\The [I] is stuck to you and cannot be installed onto the [name].</span>"
			return

		var/obj/item/device/mod/scope1224/S = I
		user << "<span class='notice'>You click [S] into place on [src].</span>"
		scope = S
		S.installed = src
		S.loc = src
		update_icon()
	else if(istype(I, /obj/item/ammo_box/magazine/m42c))
		drop_magazine(user)
		if(do_reload(user, src, I, 12))
			if(user.get_active_hand() == I)
				..()
	else
		..()

/obj/item/weapon/gun/projectile/Assault/m42c/update_icon()
	..()
	icon_state = "[initial(icon_state)][magazine ? "" : "-e"]"
	overlays.Cut()
	if(scope)
		var/image/mod = image("icon" = 'icons/obj/guns/projectile.dmi', "icon_state" = "m42c-scope")
		overlays += mod
	return



///***MELEE/THROWABLES***///

/obj/item/weapon/combat_knife
	name = "Marine Combat Knife"
	icon = 'icons/obj/weapons.dmi'
	icon_state = "combat_knife"
	item_state = "knife"
	desc = "When shits gets serious! You can slide this knife into your boots."
	flags = CONDUCT
	force = 35.0
	w_class = 1.0
	throwforce = 20
	throw_speed = 3
	throw_range = 6
	hitsound = 'sound/weapons/slash.ogg'
	attack_verb = list("slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	slot_flags = SLOT_MASK | SLOT_BELT
	var/attachable = 1

	suicide_act(mob/user)
		viewers(user) << pick("\red <b>[user] is slitting \his wrists with the [src.name]! It looks like \he's trying to commit suicide.</b>", \
							"\red <b>[user] is slitting \his throat with the [src.name]! It looks like \he's trying to commit suicide.</b>", \
							"\red <b>[user] is slitting \his stomach open with the [src.name]! It looks like \he's trying to commit seppuku.</b>")
		return (BRUTELOSS)

/obj/item/weapon/throwing_knife
	name ="Throwing Knife"
	icon='icons/obj/weapons.dmi'
	item_state="knife"
	desc="A military knife designed to be thrown at the enemy. Much quieter than a firearm, but requires a steady hand to be used effectively."
	flags = CONDUCT
	force = 10.0
	w_class = 1.0
	throwforce = 35
	throw_speed = 4
	throw_range = 7
	hitsound = 'sound/weapons/slash.ogg'
	attack_verb = list("slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	slot_flags = SLOT_POCKET
		// Slayerplayer99: Different type of throwing knives if more wanted
	Carbon_Steel
		name="Throwing Knife"
		throw_speed=5
		throw_range=8
		throwforce=40
		icon_state="temp"

///***GRENADES***///
/obj/item/weapon/grenade/explosive
	name = "Grenade (HE)"
	desc = "A Colonial Marines fragmentation grenade. It explodes 5 seconds after the pin has been pulled."
	icon = 'icons/obj/grenade.dmi'
	icon_state = "grenade_ex"
	item_state = "grenade_ex"
	det_time = 50
	slot_flags = SLOT_BELT
	w_class = 3

	prime()
		spawn(0)
			explosion(src.loc,-1,-1,3)
			if(isliving(loc))
				var/mob/living/L = loc
				if(prob(50))
					L.gib()
				else
					L.adjustBruteLoss(150)
			qdel(src)
		return


///***MINES***///
/obj/item/device/mine
	name = "Proximity Mine"
	desc = "An anti-personnel mine. Useful for setting traps or for area denial. "
	icon = 'icons/obj/grenade.dmi'
	icon_state = "mine"
	force = 5.0
	w_class = 2.0
	layer = 3
	throwforce = 5.0
	throw_range = 6
	throw_speed = 3
	unacidable = 1

	var/triggered = 0
	/*
		"explosive"
		//"incendiary" //New bay//
	*/


//Arming
/obj/item/device/mine/attack_self(mob/living/user as mob)
	if(locate(/obj/item/device/mine) in get_turf(src))
		src << "There's already a mine at this position!"
		return
	if(!anchored)
		user.visible_message("\blue \The [user] is deploying \the [src]")
		if(!do_after(user,40))
			user.visible_message("\blue \The [user] decides not to deploy \the [src].")
			return
		user.visible_message("\blue \The [user] deployed \the [src].")
		anchored = 1
		icon_state = "mine_armed"
		user.drop_item()
		return

//Disarming
/obj/item/device/mine/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W, /obj/item/device/multitool))
		if(anchored)
			user.visible_message("\blue \The [user] starts to disarm \the [src].")
			if(!do_after(user,80))
				user.visible_message("\blue \The [user] decides not to disarm \the [src].")
				return
			user.visible_message("\blue \The [user] finishes disarming \the [src]!")
			anchored = 0
			icon_state = "mine"
			return

/obj/item/device/mine/attack_hand(mob/user)
	if(anchored)
		return
	..()

//Triggering
/obj/item/device/mine/Crossed(AM as mob|obj)
	Bumped(AM)

/obj/item/device/mine/Uncrossed(AM as mob|obj)
	Bumped(AM)

/obj/item/device/mine/Bumped(mob/M as mob|obj)
	if(!anchored) return //If armed
	if(triggered) return

	if(istype(M, /mob/living/carbon/alien) && !istype(M, /mob/living/carbon/alien/larva)) //Only humanoid aliens can trigger it.
		visible_message("<span class='danger'>[M] triggered the \icon[src] [src]!</span>")
		triggered = 1
		trigger(M)

//TYPES//
//Explosive
/obj/item/device/mine/proc/trigger(mob/living/carbon/alien/A)
	if(isalien_t1(A))
		A.gib()
	explosion(src.loc,-1,-1,2)
	spawn(0)
		qdel(src)
//Incendiary
//**//TODO

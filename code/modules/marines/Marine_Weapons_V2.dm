///**************NEW LORE COLONIAL MARINES WEAPON EDIT 31JAN2015 - BY APOPHIS**************///

///***Bullets***///
/obj/item/projectile/bullet/m4a3 //Colt 45 Pistol
	damage = 25

/obj/item/projectile/bullet/m44m //44 Magnum Peacemaker
	damage = 45

/obj/item/projectile/bullet/m39 // M39 SMG
	damage = 15

/obj/item/projectile/bullet/m41 //M41 Assault Rifle
	damage = 20

/obj/item/projectile/bullet/m37 //M37 Pump Shotgun
	name = "pellet"
	damage = 30

/obj/item/projectile/bullet/a10x28
	damage = 30

///***Ammo***///

/obj/item/ammo_casing/m4a3 //45 Pistol
	desc = "A .45 special bullet casing."
	caliber = "45s"
	projectile_type = /obj/item/projectile/bullet/m4a3

/obj/item/ammo_casing/m44m //44 Magnum Peacemaker
	desc = "A 44 Magnum bullet casing."
	caliber = "38s"
	projectile_type = /obj/item/projectile/bullet/m44m

/obj/item/ammo_casing/m39 // M39 SMG
	desc = "A .9mm special bullet casing."
	caliber = "9mms"
	projectile_type = /obj/item/projectile/bullet/m39

/obj/item/ammo_casing/m41 //M41Assault Rifle
	desc = "A 10mm special bullet casing."
	caliber = "10mms"
	projectile_type = /obj/item/projectile/bullet/m41

/obj/item/ammo_casing/m37 //M37 Pump Shotgun
	name = "Shotgun shell"
	desc = "A 12 gauge shell."
	icon_state = "gshell"
	caliber = "12gs"
	projectile_type = /obj/item/projectile/bullet/m37
	pellets = 5
	variance = 0.8

/obj/item/ammo_casing/a10x28
	desc = "A 10mm special bullet casing."
	caliber = "a10x28"
	projectile_type = /obj/item/projectile/bullet/a10x28

///***Ammo Boxes***///

/obj/item/ammo_box/magazine/m4a3 //45 Pistol
	name = "M4A3 Magazine (.45)"
	desc = "A magazine with .45 ammo"
	icon_state = ".45a"
	ammo_type = "/obj/item/ammo_casing/m4a3"
	max_ammo = 12

/obj/item/ammo_box/magazine/m4a3/update_icon()
	..()
	icon_state = ".45a[ammo_count() ? "" : "0"]"

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
	ammo_type = "/obj/item/ammo_casing/m39"
	max_ammo = 48

/obj/item/ammo_box/magazine/m39/update_icon()
	..()
	icon_state = "9x19p[ammo_count() ? "-8" : "-0"]"

/obj/item/ammo_box/magazine/m41 //M41 Assault Rifle
	name = "M41A Magazine (10mm)"
	desc = "A 10mm special magazine"
	icon_state = "10caseless"
	ammo_type = "/obj/item/ammo_casing/m41"
	max_ammo = 40

/obj/item/ammo_box/magazine/m41/update_icon()
	..()
	icon_state = "[initial(icon_state)][ammo_count() ? "" : "-0"]"

/obj/item/ammo_box/m37 //M37 Shotgun
	name = "M37 Shotgun shells (box)"
	desc = "A box of standard issue high-powered 12 gauge buckshot rounds. Manufactured by Armat Systems for military and civilian use."
	icon = 'icons/obj/storage.dmi'
	icon_state = "shells"
	ammo_type = /obj/item/ammo_casing/m37
	max_ammo = 8

/obj/item/ammo_box/magazine/internal/m37
	name = "combat shotgun internal magazine"
	desc = "Oh god, this shouldn't be here"
	ammo_type = /obj/item/ammo_casing/m37
	caliber = "12gs"
	max_ammo = 8
	multiload = 0

/obj/item/ammo_box/magazine/a10x28
	name = "Magazine (10x28)"
	desc = "A 10mm special magazine"
	icon_state = "a10x28"
	ammo_type = /obj/item/ammo_casing/a10x28
	max_ammo = 150

/obj/item/ammo_box/magazine/a10x28/update_icon()
	..()
	icon_state = "[initial(icon_state)][ammo_count() ? "" : "-0"]"

///***Pistols***///

/obj/item/weapon/gun/projectile/pistol/m4a3 //45 Pistol
	name = "M4A3 Service Pistol"
	desc = "M4A3 Service Pistol, the standard issue sidearm of the Colonial Marines. Uses .45 special rounds."
	icon_state = "m4a3"
	w_class = 2
	mag_type = /obj/item/ammo_box/magazine/m4a3
	can_suppress = 0
	burst_size = 1
	fire_delay = 0
	fire_sound = 'sound/weapons/servicepistol.ogg'

/obj/item/weapon/gun/projectile/pistol/m4a3/update_icon()
	..()
	icon_state = "[initial(icon_state)][magazine ? "" : "-e"]"

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

///***SMGS***///

/obj/item/weapon/gun/projectile/Assault/m39 // M39 SMG
	name = "M39 SMG"
	desc = " Armat Battlefield Systems M39 SMG. Occasionally carried by light-infantry, scouts or non-combat personnel. Uses 9mm rounds."
	icon_state = "m39"
	item_state = "c20r"
	w_class = 4
	can_suppress = 0
	mag_type = /obj/item/ammo_box/magazine/m39
	fire_sound = 'sound/weapons/Gunshot2.ogg'
	fire_delay = 1
	burst_size = 1
	can_flashlight = 1

/obj/item/weapon/gun/projectile/Assault/m39/process_chamber(eject_casing = 0, empty_chamber = 1, no_casing = 1)
	..()

/obj/item/weapon/gun/projectile/Assault/m39/update_icon()
	..()
	icon_state = "[initial(icon_state)][magazine ? "" : "-e"]"
	return

///***RIFLES***///

/obj/item/weapon/gun/projectile/Assault/m41 //M41 Assault Rifle
	name = "M41A MK2"
	desc = "M41A Pulse Rifle MK2. The standard issue rifle of the Colonial Marines. Commonly carried by most combat personnel. Uses 10mm special ammunition."
	icon_state = "m41a"
	item_state = "m41a"
	w_class = 4
	mag_type = /obj/item/ammo_box/magazine/m41
	fire_sound = 'sound/weapons/Gunshot_m41.ogg'
	can_suppress = 0
	var/obj/item/weapon/gun/projectile/revolver/grenadelauncher/underbarrel
	burst_size = 1
	fire_delay = 1.5
	two_handed = 1
	var/select = 1
	action_button_name = "Toggle Firemode"
	can_flashlight = 1

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
	if(istype(A, /obj/item/ammo_casing))
		if(istype(A, underbarrel.magazine.ammo_type))
			underbarrel.attack_self()
			underbarrel.attackby(A, user, params)
	else
		..()

/obj/item/weapon/gun/projectile/Assault/m41/update_icon()
	..()
	icon_state = "[initial(icon_state)][magazine ? "" : "-e"]"
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
	fire_sound = 'sound/weapons/Gunshot_m59.ogg'
	fire_delay = 1
	burst_size = 1
	two_handed = 1
	smart_weapon = 1
	var/smart_aim = 1
	var/locking_in = 0
	var/mob/living/locked_target = null

/obj/item/weapon/gun/projectile/Assault/m59b/New()
	..()
	SSobj.processing |= src

/obj/item/weapon/gun/projectile/Assault/m59b/Destroy()
	SSobj.processing -= src
	..()

/obj/item/weapon/gun/projectile/Assault/m59b/process()
	if(smart_aim && ismob(loc) && locked_target)
		if(locked_target.stat == DEAD)
			target_reset(loc)
	return

/obj/item/weapon/gun/projectile/Assault/m59b/afterattack(atom/target, mob/living/user, flag, params)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.wear_suit && istype(H.wear_suit, /obj/item/clothing/suit/storage/marine2/harness))
			var/obj/item/clothing/suit/storage/marine2/harness/Armor = H.wear_suit
			if(Armor.harness_cell && (Armor.harness_cell.charge >= 45))
				if(smart_aim)
					if(target == user)
						target_reset(user)
						return

					if(locking_in)
						return

					if(!locked_target)
						target_get(target)
						return

					if(locked_target && (locked_target.stat == DEAD))
						target_reset(user)
						return
					else if(locked_target)
						if(ismob(target) && target != locked_target)
							target_reset(user)
							target_get(target)
							return
						else if(get_dist(locked_target,user) > 7)
							target_reset(user)
							return
						else if(get_dist(locked_target,user.ms_last_pos) > 1)
							target_reset(user)
							return
						target = locked_target
						Armor.harness_cell.charge -= 45
						..()
				else
					Armor.harness_cell.charge -= 45
					..()
			else
				user << "<span class='warning'>Not enough power. Recharge current power cell or insert a fresh one..</span>"
				return
		else
			user << "<span class='warning'>No power. Must equipped with Combat Harness.</span>"
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
				if(L.stat == DEAD)
					continue
				if(L != user)
					targets += L
			if(targets.len)
				target_lock(pick(targets),user)

/obj/item/weapon/gun/projectile/Assault/m59b/proc/target_lock(mob/living/A, mob/living/carbon/human/user)
	if(!istype(A) || !istype(user))
		return

	if(locking_in || locked_target)
		return

	locking_in = 1
	var/image/I
	var/drawn_crooshair = 0
	if(isalienadult(A))
		var/mob/living/carbon/alien/humanoid/H = A
		var/pix_x = -H.custom_pixel_x_offset
		var/pix_y = -H.custom_pixel_y_offset
		I = image('icons/effects/effects.dmi', loc = A, icon_state = "medi_holo", layer = 16, pixel_x = pix_x, pixel_y = pix_y)
	else
		I = image('icons/effects/effects.dmi', loc = A, icon_state = "medi_holo", layer = 16)
	if(user.glasses && istype(user.glasses, /obj/item/clothing/glasses/hms))
		drawn_crooshair = 1
		user.client.images += I
	I.color = "#ff0000"
	user << 'sound/items/timer.ogg'
	spawn(10)
		if(locking_in)
			locking_in = 0
			if(A)
				if(get_dist(A,user.ms_last_pos) <= 1)
					locked_target = A
					I.color = "#ffffff"
					user << 'sound/items/timer.ogg'
				else
					if(drawn_crooshair)
						user.client.images -= I

/obj/item/weapon/gun/projectile/Assault/m59b/proc/target_reset(mob/living/carbon/human/user)
	locked_target = null
	locking_in = 0
	if(user && user.client)
		for(var/image/I in user.client.images)
			if(I.icon_state == "medi_holo")
				user.client.images.Remove(I)
				user << 'sound/items/timer.ogg'

/obj/item/weapon/gun/projectile/Assault/m59b/verb/aimmode()
	set name = "Rifle: aimmode" // i put such name after ":" - so it easier to understand which exact macro command we need.
	set category = "Weapon"

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

/obj/item/weapon/gun/projectile/Assault/m59b/dropped(mob/user)
	target_reset(user)
	..()

/obj/item/clothing/glasses/hms
	name = "HMS"
	icon_state = "hms"
	desc = "The Head Mounted Sight. Allow user to see targets detected by the smartgun's infrared tracker."
	flags = null
	origin_tech = "magnets=3;biotech=2"

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
	var/obj/item/weapon/stock_parts/cell/harness_cell

/obj/item/clothing/suit/storage/marine2/harness/New()
	..()
	harness_cell = new /obj/item/weapon/stock_parts/cell/harness_cell(src)

/obj/item/clothing/suit/storage/marine2/harness/verb/remove_cell()
	set name = "Remove Power Cell"
	set category = "Object"

	if(harness_cell)
		harness_cell.loc = get_turf(usr)
		harness_cell = null
	return

/obj/item/clothing/suit/storage/marine2/harness/attackby(obj/item/weapon/W, mob/user, params)
	if(istype(W, /obj/item/weapon/stock_parts/cell/harness_cell))
		if(harness_cell)
			user << "\red Must remove power cell from [src] first."
			return

		if(!user.drop_item())
			return

		harness_cell = W
		W.loc = src
		user.visible_message("[user] inserts [W] in [src].", \
							"<span class='notice'>You insert [W] in [src].</span>")

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
	desc = "A Colonial Marines fragmentation grenade. It explodes 5 seconds after the pin has been pulled."
	name = "Frag grenade"
	icon = 'icons/obj/grenade.dmi'
	icon_state = "grenade_ex"
	det_time = 50
	item_state = "grenade_ex"
	slot_flags = SLOT_BELT
	w_class = 3

	prime()
		spawn(0)
			explosion(src.loc,-1,-1,3)
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
	var/triggertype = "explosive" //Calls that proc
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

//Triggering
/obj/item/device/mine/Crossed(AM as mob|obj)
	Bumped(AM)

/obj/item/device/mine/Bumped(mob/M as mob|obj)
	if(!anchored) return //If armed
	if(triggered) return

	if(istype(M, /mob/living/carbon/alien) && !istype(M, /mob/living/carbon/alien/larva)) //Only humanoid aliens can trigger it.
		for(var/mob/O in viewers(world.view, src.loc))
			O << "<font color='red'>[M] triggered the \icon[src] [src]!</font>"
		triggered = 1
		call(src,triggertype)(M)

//TYPES//
//Explosive
/obj/item/device/mine/proc/explosive(obj)
	explosion(src.loc,-1,-1,2)
	spawn(0)
		qdel(src)
//Incendiary
//**//TODO

///**************NEW LORE COLONIAL MARINES WEAPON EDIT 31JAN2015 - BY APOPHIS**************///


///***Bullets***///
/obj/item/projectile/bullet/m4a3 //Colt 45 Pistol
	damage = 25

/obj/item/projectile/bullet/m44m //44 Magnum Peacemaker
	damage = 45

/obj/item/projectile/bullet/m39 // M39 SMG
	damage = 20

/obj/item/projectile/bullet/m41 //M41 Assault Rifle
	damage = 30

/obj/item/projectile/bullet/m37 //M37 Pump Shotgun
	damage = 40

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

///***Ammo Boxes***///

/obj/item/ammo_box/magazine/m4a3 //45 Pistol
	name = "M4A3 Magazine (.45)"
	desc = "A magazine with .45 ammo"
	icon_state = ".45a"
	ammo_type = "/obj/item/ammo_casing/m4a3"
	max_ammo = 12

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
	max_ammo = 30

/obj/item/ammo_box/magazine/m39/empty // M39 SMG
	icon_state = "9x19p-0"
	max_ammo = 0

/obj/item/ammo_box/magazine/m41 //M41 Assault Rifle
	name = "M41A Magazine (10mm)"
	desc = "A 10mm special magazine"
	icon_state = "m309a"
	ammo_type = "/obj/item/ammo_casing/m41"
	max_ammo = 30

/obj/item/ammo_box/magazine/m41/empty //Assault Rifle
	max_ammo = 0
	icon_state = "m309a0"


/obj/item/ammo_box/m37 //M37 Shotgun
	name = "M37 Shotgun shells (box)"
	desc = "A box of standard issue high-powered 12 gauge buckshot rounds. Manufactured by Armat Systems for military and civilian use."
	icon_state = "shells"
	ammo_type = /obj/item/ammo_casing/m37
	max_ammo = 7

/obj/item/ammo_box/magazine/internal/m37
	name = "combat shotgun internal magazine"
	desc = "Oh god, this shouldn't be here"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	caliber = "shotgun"
	max_ammo = 7
	multiload = 0

///***Pistols***///

/obj/item/weapon/gun/projectile/pistol/m4a3 //45 Pistol
	name = "\improper M4A3 Service Pistol"
	desc = "M4A3 Service Pistol, the standard issue sidearm of the Colonial Marines. Uses .45 special rounds."
	icon_state = "colt"
	w_class = 2
	mag_type = /obj/item/ammo_box/magazine/m4a3
	can_suppress = 0
	burst_size = 1
	fire_delay = 0
	fire_sound = 'sound/weapons/servicepistol.ogg'

/*
/obj/item/weapon/gun/projectile/pistol/m4a3/afterattack(atom/target as mob|obj|turf|area, mob/living/user as mob|obj, flag)
	..()
	if(!loaded.len && empty_mag)
		empty_mag.loc = get_turf(src.loc)
		empty_mag = null
	return*/

/obj/item/weapon/gun/projectile/m44m //mm44 Magnum Peacemaker
	name = "\improper 44 Magnum"
	desc = "A bulky 44 Magnum revolver, occasionally carried by assault troops and officers in the Colonial Marines. Uses 44 Magnum rounds"
	icon_state = "mateba"
	mag_type = /obj/item/ammo_box/magazine/m44m

///***SMGS***///

/obj/item/weapon/gun/projectile/automatic/Assault/m39 // M39 SMG
	name = "\improper M39 SMG"
	desc = " Armat Battlefield Systems M39 SMG. Occasionally carried by light-infantry, scouts or non-combat personnel. Uses 9mm rounds."
	icon_state = "smg"
	item_state = "c20r"
	can_suppress = 0
	mag_type = /obj/item/ammo_box/magazine/m39
	fire_sound = 'sound/weapons/Gunshot_m39.ogg'
	fire_delay = 2
	burst_size = 2
	two_handed = 1

/obj/item/weapon/gun/projectile/automatic/Assault/m39/process_chamber(eject_casing = 0, empty_chamber = 1, no_casing = 1)
	..()

/obj/item/weapon/gun/projectile/automatic/Assault/m39/update_icon()
	..()
	icon_state = "[initial(icon_state)][magazine ? "" : "-e"]"
	return

/*
	afterattack(atom/target as mob|obj|turf|area, mob/living/user as mob|obj, flag)
		..()
		if(!loaded.len && empty_mag)
			empty_mag.loc = get_turf(src.loc)
			empty_mag = null
		return

	New()
		..()
		empty_mag = new /obj/item/ammo_magazine/m39/empty(src)
		update_icon()
		return

	isHandgun()
		return 0*/


///***RIFLES***///

/obj/item/weapon/gun/projectile/automatic/Assault/m41 //M41 Assault Rifle
	name = "\improper M41A Rifle"
	desc = "M41A Pulse Rifle. The standard issue rifle of the Colonial Marines. Commonly carried by most combat personnel. Uses 10mm special ammunition."
	icon_state = "m41a"
	item_state = "m41a"
	mag_type = /obj/item/ammo_box/magazine/m41
	fire_sound = 'sound/weapons/Gunshot_m41.ogg'
	can_suppress = 0
	var/obj/item/weapon/gun/projectile/revolver/grenadelauncher/underbarrel
	burst_size = 3
	fire_delay = 2
	two_handed = 1

/obj/item/weapon/gun/projectile/automatic/Assault/m41/New()
	..()
	underbarrel = new /obj/item/weapon/gun/projectile/revolver/grenadelauncher(src)
	update_icon()
	return

/obj/item/weapon/gun/projectile/automatic/Assault/m41/process_chamber(eject_casing = 0, empty_chamber = 1, no_casing = 1)
	..()

/obj/item/weapon/gun/projectile/automatic/Assault/m41/afterattack(atom/target, mob/living/user, flag, params)
	if(select == 2)
		underbarrel.afterattack(target, user, flag, params)
	else
		..()
		return

/obj/item/weapon/gun/projectile/automatic/Assault/m41/attackby(obj/item/A, mob/user, params)
	if(istype(A, /obj/item/ammo_casing))
		if(istype(A, underbarrel.magazine.ammo_type))
			underbarrel.attack_self()
			underbarrel.attackby(A, user, params)
	else
		..()

/obj/item/weapon/gun/projectile/automatic/Assault/m41/update_icon()
	..()
	overlays.Cut()
	switch(select)
		if(0)
			overlays += "[initial(icon_state)]semi"
		if(1)
			overlays += "[initial(icon_state)]burst"
		if(2)
			overlays += "[initial(icon_state)]gren"
	icon_state = "[initial(icon_state)][magazine ? "" : "-e"]"
	return

/obj/item/weapon/gun/projectile/automatic/Assault/m41/burst_select()
	var/mob/living/carbon/human/user = usr
	switch(select)
		if(0)
			select = 1
			burst_size = initial(burst_size)
			fire_delay = initial(fire_delay)
			user << "<span class='notice'>You switch to [burst_size]-rnd burst.</span>"
		if(1)
			select = 2
			user << "<span class='notice'>You switch to grenades.</span>"
		if(2)
			select = 0
			burst_size = 1
			fire_delay = 0
			user << "<span class='notice'>You switch to semi-auto.</span>"
	playsound(user, 'sound/weapons/empty.ogg', 100, 1)
	update_icon()
	return


///***SHOTGUNS***///

/obj/item/weapon/gun/projectile/shotgun/m37 //M37 Pump Shotgun
	name = "\improper M37 Pump Shotgun"
	desc = "Colonial Marine M37 Pump Shotgun"
	icon_state = "cshotgun"
	item_state = "shotgun"
	w_class = 4.0
	force = 10
	flags =  CONDUCT
	slot_flags = SLOT_BACK
	mag_type = /obj/item/ammo_box/magazine/internal/m37
	two_handed = 1

///***MELEE/THROWABLES***///

/obj/item/weapon/combat_knife
	name = "\improper Marine Combat Knife"
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
	desc = "A Colonial Marines fragmentation grenade. It explodes 3 seconds after the pin has been pulled."
	name = "Frag grenade"
	icon = 'icons/obj/grenade.dmi'
	icon_state = "grenade_ex"
	det_time = 30
	item_state = "grenade_ex"
	slot_flags = SLOT_BELT

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

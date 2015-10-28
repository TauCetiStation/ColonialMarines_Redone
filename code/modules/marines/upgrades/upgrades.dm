//datum/upgrade
//	name = ""
//	desc = ""
//	desc_req = ""
//	id = "id"
//	category = list("")

//	research_time = 0			Time in seconds this research will take
//	cost = 1 					How much tokens this upgrade cost
//	maxlevel = 0				Maximum level
//	req_upgrade = null			id of required research
//	req_upgrade_level = null	level of required research

//M4A3 Pistol

//VP78 Pistol
/datum/upgrade/vp78
	name = "VP78 Pistol"
	desc = "Better than that gun."
	id = "vp78"
	category = list("VP78 Pistol")

	vendor = "ColMarWeap"

	research_time = 300
	maxlevel = 1

/datum/upgrade/vp78/on_level()
	for(var/obj/machinery/vending/marine/weapons/V in world)
		var/list/upgrade = list(/obj/item/weapon/gun/projectile/pistol/VP78 = 5)
		V.build_inventory(upgrade)

	for(var/obj/machinery/vending/marine/ammunition/V in world)
		var/list/upgrade = list(/obj/item/ammo_box/magazine/vp78 = 10)
		V.build_inventory(upgrade)

//Shotgun
/datum/upgrade/shotcom
	name = "Combat Shotgun"
	desc = "Totally legal."
	id = "shotcom"
	category = list("Shotgun")

	vendor = "ColMarWeap"

	research_time = 240
	cost = 2
	maxlevel = 1

/datum/upgrade/shotcom/on_level()
	for(var/obj/machinery/vending/marine/weapons/V in world)
		var/list/upgrade = list(/obj/item/weapon/gun/projectile/shotgun/combat = 5)
		V.build_inventory(upgrade)

/datum/upgrade/m37_flec
	name = "12 gauge flechette shells"
	desc = "Provides highest damage against unarmored targets and better accuracy than buckshot. Worst against armor."
	id = "m37_flec"
	category = list("Shotgun")

	vendor = "ColMarAmmo"

	research_time = 240
	cost = 2
	maxlevel = 1

/datum/upgrade/m37_flec/on_level()
	for(var/obj/machinery/vending/marine/ammunition/V in world)
		var/list/upgrade = list(/obj/item/ammo_box/m37/flechette = 10)
		V.build_inventory(upgrade)

/datum/upgrade/m37_slug
	name = "12 gauge slug shells"
	desc = "Highest accuracy and penetration just for your shotgun."
	id = "m37_slug"
	category = list("Shotgun")

	vendor = "ColMarAmmo"

	research_time = 240
	cost = 2
	maxlevel = 1

/datum/upgrade/m37_slug/on_level()
	for(var/obj/machinery/vending/marine/ammunition/V in world)
		var/list/upgrade = list(/obj/item/ammo_box/m37/slug = 10)
		V.build_inventory(upgrade)

//M39 Submachine Gun
/datum/upgrade/m39_high_cap
	name = "Magazine (High Cap)"
	desc = "With standard ammunition (70 bullets)."
	id = "m39_hc"
	category = list("M39 Submachine Gun")

	vendor = "ColMarWeap"

	research_time = 300
	cost = 2
	maxlevel = 1

/datum/upgrade/m39_high_cap/on_level()
	for(var/obj/machinery/vending/marine/ammunition/V in world)
		var/list/upgrade = list(/obj/item/ammo_box/magazine/m39/highcap = 10)
		V.build_inventory(upgrade)

/datum/upgrade/m39_incendiary
	name = "Magazine (Incendiary)"
	desc = "Can help to prepare some hot food."
	desc_req = "High Cap magazine must be researched."
	id = "m39_inc"
	category = list("M39 Submachine Gun")

	vendor = "ColMarAmmo"

	research_time = 300
	maxlevel = 1
	req_upgrade = "m39_hc"
	req_upgrade_level = 1

/datum/upgrade/m39_incendiary/on_level()
	for(var/obj/machinery/vending/marine/ammunition/V in world)
		var/list/upgrade = list(/obj/item/ammo_box/magazine/m39/highcap/incendiary = 10)
		V.build_inventory(upgrade)

//"M41A Pulse Rifle MK2"
/datum/upgrade/m41a_u_gren
	name = "40mm grenades"
	desc = "For use with underbarrel grenade launcher.."
	id = "m41a_u_gren"
	category = list("M41A Pulse Rifle MK2")

	vendor = "ColMarAmmo"

	research_time = 300
	maxlevel = 1

/datum/upgrade/m41a_u_gren/on_level()
	for(var/obj/machinery/vending/marine/ammunition/V in world)
		var/list/upgrade = list(/obj/item/ammo_box/a40mm = 2)
		V.build_inventory(upgrade)

//"M59B Smartgun"
/datum/upgrade/m59b
	name = "M59B Smartgun"
	desc = "Actually dumb, if used without HMS and junk without combat harness."
	id = "m59b"
	category = list("M59B Smartgun")

	vendor = "ColMarWeap and ColMarAmmo"

	research_time = 600
	cost = 3
	maxlevel = 1

/datum/upgrade/m59b/on_level()
	for(var/obj/machinery/vending/marine/weapons/V in world)
		var/list/upgrade = list(/obj/item/weapon/gun/projectile/Assault/m59b = 2)
		V.build_inventory(upgrade)

	for(var/obj/machinery/vending/marine/ammunition/V in world)
		var/list/upgrade = list(/obj/item/ammo_box/magazine/a10x28 = 4)
		V.build_inventory(upgrade)

/datum/upgrade/m59b_harn
	name = "Combat Harness, Battery and HMS"
	desc = "Armor that required for smartgun functionality. Provides better protection than regular armor."
	desc_req = "M59B research required."
	id = "m59b_harn"
	category = list("M59B Smartgun")

	vendor = "ColMarEquip"

	research_time = 300
	maxlevel = 1
	req_upgrade = "m59b"
	req_upgrade_level = 1

/datum/upgrade/m59b_harn/on_level()
	for(var/obj/machinery/vending/marine/equipment/V in world)
		var/list/upgrade = list(
								/obj/item/clothing/suit/storage/marine2/harness = 2,
								/obj/item/clothing/glasses/hms = 2,
								/obj/item/weapon/stock_parts/cell/harness_cell = 20
								)
		V.build_inventory(upgrade)

//"M42C Rifle"
/datum/upgrade/m42c
	name = "M42C Rifle"
	desc = "No one can hide from you.. If only this comes with scope by default.."
	id = "m42c"
	category = list("M42C Rifle")

	vendor = "ColMarWeap and ColMarAmmo"

	research_time = 600
	cost = 2
	maxlevel = 1

/datum/upgrade/m42c/on_level()
	for(var/obj/machinery/vending/marine/weapons/V in world)
		var/list/upgrade = list(/obj/item/weapon/gun/projectile/Assault/m42c = 2)
		V.build_inventory(upgrade)

	for(var/obj/machinery/vending/marine/ammunition/V in world)
		var/list/upgrade = list(/obj/item/ammo_box/magazine/m42c = 4)
		V.build_inventory(upgrade)

/datum/upgrade/m42c_scope
	name = "M42C Rifle Scope"
	desc = "Provide 12x-24x magnification. You can peek girls dressing room with this!"
	desc_req = "M42C Rifle research required."
	id = "m42c_scope"
	category = list("M42C Rifle")

	vendor = "ColMarEquip"

	research_time = 120
	maxlevel = 1
	req_upgrade = "m42c"
	req_upgrade_level = 1

/datum/upgrade/m42c_scope/on_level()
	for(var/obj/machinery/vending/marine/equipment/V in world)
		var/list/upgrade = list(/obj/item/device/mod/scope1224 = 2)
		V.build_inventory(upgrade)

/datum/upgrade/m42c_inc
	name = "Magazine (Incendiary)"
	desc = "Very flammable."
	desc_req = "M42C Rifle research required."
	id = "m42c_inc"
	category = list("M42C Rifle")

	vendor = "ColMarAmmo"

	research_time = 300
	maxlevel = 1
	req_upgrade = "m42c"
	req_upgrade_level = 1

/datum/upgrade/m42c_inc/on_level()
	for(var/obj/machinery/vending/marine/ammunition/V in world)
		var/list/upgrade = list(/obj/item/ammo_box/magazine/m42c/incendiary = 10)
		V.build_inventory(upgrade)

/datum/upgrade/m42c_spc
	name = "Magazine (Special)"
	desc = "Armor? What armor?"
	desc_req = "Magazine (Incendiary) research required."
	id = "m42c_spc"
	category = list("M42C Rifle")

	vendor = "ColMarAmmo"

	research_time = 540
	maxlevel = 1
	req_upgrade = "m42c_inc"
	req_upgrade_level = 1

/datum/upgrade/m42c_spc/on_level()
	for(var/obj/machinery/vending/marine/ammunition/V in world)
		var/list/upgrade = list(/obj/item/ammo_box/magazine/m42c/special = 10)
		V.build_inventory(upgrade)

//"M-6B Rocket Launcher"
/datum/upgrade/m6b
	name = "M-6B Rocket Launcher"
	desc = "Not for indoor use. You warned!"
	id = "m6b"
	category = list("M-6B Rocket Launcher")

	vendor = "ColMarWeap"

	research_time = 300
	cost = 4
	maxlevel = 1

/datum/upgrade/m6b/on_level()
	for(var/obj/machinery/vending/marine/weapons/V in world)
		var/list/upgrade = list(/obj/item/weapon/gun/projectile/rocket/m6b = 2)
		V.build_inventory(upgrade)

/datum/upgrade/m6b_r_he
	name = "Rocket (High Explosive)"
	desc = "Best against crowd."
	id = "m6b_r_he"
	category = list("M-6B Rocket Launcher")

	vendor = "ColMarAmmo"

	research_time = 420
	maxlevel = 1

/datum/upgrade/m6b/on_level()
	for(var/obj/machinery/vending/marine/ammunition/V in world)
		var/list/upgrade = list(/obj/item/ammo_casing/rocket/he = 5)
		V.build_inventory(upgrade)

/datum/upgrade/m6b_r_ap
	name = "Rocket (Armor Piercing)"
	desc = "Best against single target."
	id = "m6b_r_ap"
	category = list("M-6B Rocket Launcher")

	vendor = "ColMarAmmo"

	research_time = 420
	maxlevel = 1

/datum/upgrade/m6b/on_level()
	for(var/obj/machinery/vending/marine/ammunition/V in world)
		var/list/upgrade = list(/obj/item/ammo_casing/rocket/ap = 5)
		V.build_inventory(upgrade)

//Weapon Mods and Special
/datum/upgrade/scope4
	name = "Scope (4x)"
	desc = "Can be installed on M39 SMG and M41A MK2."
	id = "scope4"
	category = list("Mods and Special")

	vendor = "ColMarEquip"

	research_time = 120
	maxlevel = 1

/datum/upgrade/scope4/on_level()
	for(var/obj/machinery/vending/marine/equipment/V in world)
		var/list/upgrade = list(/obj/item/device/mod/scope4 = 5)
		V.build_inventory(upgrade)

/datum/upgrade/gr_frag
	name = "Fragmentation Grenade"
	desc = "DO. NOT. USE. If you have no escape plan."
	id = "gr_frag"
	category = list("Mods and Special")

	vendor = "ColMarAmmo"

	research_time = 300
	cost = 1
	maxlevel = 1

/datum/upgrade/gr_frag/on_level()
	for(var/obj/machinery/vending/marine/ammunition/V in world)
		var/list/upgrade = list(/obj/item/weapon/grenade/frag = 5)
		V.build_inventory(upgrade)

/datum/upgrade/sentry
	name = "Sentry Turret"
	desc = "Will shoot those pesky intruders."
	id = "sentry"
	category = list("Mods and Special")

	vendor = "ColMarEquip"

	research_time = 500
	maxlevel = 1

/datum/upgrade/sentry/on_level()
	for(var/obj/machinery/vending/marine/equipment/V in world)
		var/list/upgrade = list(/obj/item/marines/turret_deployer = 2)
		V.build_inventory(upgrade)

/datum/upgrade/p_scn_speed
	name = "Planetary Scanner Accelerator"
	desc = "For each level: Scan time reduced to (30, 15) seconds. Rescan possible every (3, 1) minutes."
	id = "p_scn_speed"
	category = list("Planetary Scanner")

	vendor = "skip"

	research_time = 180
	maxlevel = 2

/datum/upgrade/p_scn_speed/on_level()
	planscan_scan -= 150
	planscan_clear -= 1200

/datum/upgrade/p_scn_acc
	name = "Planetary Scanner Accuracy"
	desc = "Unknown targets will be marked with purple color."
	desc_req = "Lv. 2 Scanner Accelerator research required."
	id = "p_scn_acc"
	category = list("Planetary Scanner")

	vendor = "skip"

	research_time = 600
	maxlevel = 1
	req_upgrade = "p_scn_speed"
	req_upgrade_level = 2

/datum/upgrade/p_scn_acc/on_level()
	planscan_accurate = 1

/datum/upgrade/adv_pa
	name = "Advanced Power Armor"
	desc = "Produce two sets."
	id = "adv_pa"
	category = list("Power Armor")

	vendor = "skip"

	research_time = 500
	cost = 5
	maxlevel = 1

/datum/upgrade/adv_pa/on_level()
	var/obj/machinery/upgrade_station/US = locate(/obj/machinery/upgrade_station) in world
	if(US)
		new /obj/item/clothing/head/helmet/space/pa(US.loc)
		new /obj/item/clothing/suit/space/pa(US.loc)
		new /obj/item/clothing/head/helmet/space/pa(US.loc)
		new /obj/item/clothing/suit/space/pa(US.loc)

//MARINE CLOSESTS
/**********************Marine Gear**************************/
//STANDARD MARINE CLOSET
/obj/structure/closet/secure_closet/marine
	name = "Marine's Locker"
	req_access = list()
	icon_state = "standard"

/obj/structure/closet/secure_closet/marine/New()
	update_icon()
	new /obj/item/clothing/suit/storage/marine2(src)
	new /obj/item/weapon/storage/belt/marine(src)
	new /obj/item/clothing/head/helmet/marine2(src)
	new /obj/item/device/flashlight/seclite(src)
	new /obj/item/clothing/glasses/sunglasses(src)
	new /obj/item/clothing/shoes/marine(src)
	new /obj/item/clothing/gloves/marine(src)
	new /obj/item/clothing/under/marine2(src)
	new /obj/item/device/radio/headset/msulaco(src)
	return

//MARINE COMMAND CLOSET
/obj/structure/closet/secure_closet/marine/marine_commander
	name = "Marine Commander's Locker"
	req_access = list()
	icon_state = "cap"

/obj/structure/closet/secure_closet/marine/marine_commander/New()
	update_icon()
	new /obj/item/weapon/storage/backpack/mcommander(src)
	new /obj/item/clothing/shoes/marinechief/commander(src)
	new /obj/item/clothing/gloves/marine/techofficer/commander(src)
	new /obj/item/clothing/under/marine/officer/commander(src)
	new /obj/item/clothing/suit/storage/marine/officer/commander(src)
	new /obj/item/weapon/storage/belt/marine(src)
	new /obj/item/clothing/head/beret/marine/commander(src)
	new /obj/item/device/flashlight/seclite(src)
	new /obj/item/clothing/glasses/sunglasses(src)
	new /obj/item/device/radio/headset/mcom(src)
	return

/obj/structure/closet/secure_closet/marine/marine_lo
	name = "Logistics Locker"
	req_access = list()
	icon_state = "hop"

/obj/structure/closet/secure_closet/marine/marine_lo/New()
	update_icon()
	new /obj/item/clothing/head/beret/marine/logisticsofficer(src)
	new /obj/item/clothing/head/beret/marine/logisticsofficer(src)
	new /obj/item/device/radio/headset/mcom(src)
	new /obj/item/device/radio/headset/mcom(src)
	new /obj/item/clothing/under/marine/officer/logistics(src)
	new /obj/item/clothing/under/marine/officer/logistics(src)
	new /obj/item/clothing/shoes/marine(src)
	new /obj/item/clothing/shoes/marine(src)
	new /obj/item/clothing/suit/storage/marine(src)
	new /obj/item/clothing/suit/storage/marine(src)
	new /obj/item/weapon/storage/belt/marine(src)
	new /obj/item/weapon/storage/belt/marine(src)
	new /obj/item/weapon/storage/box/helmet_cameras(src)
	return





/**********************Military Police Gear**************************/
/obj/structure/closet/secure_closet/marine/military_officer
	name = "Military Police's Locker"
	req_access = list()
	icon_state = "sec"

/obj/structure/closet/secure_closet/marine/military_officer/New()
	update_icon()
	new /obj/item/clothing/shoes/marine(src)
	new /obj/item/clothing/under/marine/mp(src)
	new /obj/item/clothing/suit/armor/riot/marine(src)
	new /obj/item/clothing/head/helmet/riot(src)
	new /obj/item/weapon/storage/belt/marine(src)
	new /obj/item/weapon/storage/box/rubbershot(src)
	new /obj/item/device/flashlight/seclite(src)
	new /obj/item/clothing/glasses/sunglasses(src)
	new /obj/item/device/radio/headset/mmpo(src)
	new /obj/item/weapon/gun/projectile/shotgun/riot(src)
	new /obj/item/weapon/gun/energy/taser(src)
	new /obj/item/weapon/melee/baton/loaded(src)
	return


/obj/structure/closet/secure_closet/marine/military_officer_spare
	name = "Extra Equipment Locker"
	req_access = list()
	icon_state = "sec"

/obj/structure/closet/secure_closet/marine/military_officer_spare/New()
	update_icon()
	new /obj/item/clothing/shoes/marine(src)
	new /obj/item/clothing/under/marine/mp(src)
	new /obj/item/clothing/suit/armor/riot/marine(src)
	new /obj/item/clothing/head/helmet/riot(src)
	new /obj/item/weapon/storage/box/rubbershot(src)
	new /obj/item/weapon/storage/box/rubbershot(src)
	new /obj/item/weapon/storage/box/rubbershot(src)
	new /obj/item/device/flashlight/seclite(src)
	new /obj/item/clothing/glasses/sunglasses(src)
	new /obj/item/device/radio/headset/mmpo(src)
	new /obj/item/weapon/gun/projectile/shotgun/riot(src)
	new /obj/item/weapon/shield/riot(src)
	new /obj/item/weapon/shield/riot(src)
	new /obj/item/weapon/melee/baton/loaded(src)
	new /obj/item/weapon/gun/energy/taser(src)
	new /obj/item/clothing/gloves/color/black(src)
	new /obj/item/clothing/gloves/color/black(src)
	return



//ALPHA EQUIPMENT CLOSET
/obj/structure/closet/secure_closet/marine/marine_alpha_equipment
	name = "Alpha Equipment Locker"
	req_access = list()
	icon_state = "squad_alpha"

/obj/structure/closet/secure_closet/marine/marine_alpha_equipment/New()
	update_icon()
	new /obj/item/clothing/shoes/marine(src)
	new /obj/item/clothing/gloves/marine/alpha(src)
	new /obj/item/clothing/under/marine2(src)
	new /obj/item/clothing/suit/storage/marine2(src)
	new /obj/item/weapon/storage/belt/marine(src)
	new /obj/item/clothing/head/helmet/marine2(src)
	new /obj/item/device/flashlight/seclite(src)
	new /obj/item/clothing/glasses/sunglasses(src)
	new /obj/item/device/radio/headset/malpha(src)
	return

//BRAVO EQUIPMENT CLOSET
/obj/structure/closet/secure_closet/marine/marine_bravo_equipment
	name = "Bravo Equipment Locker"
	req_access = list()
	icon_state = "squad_bravo"

/obj/structure/closet/secure_closet/marine/marine_bravo_equipment/New()
	update_icon()
	new /obj/item/clothing/shoes/marine(src)
	new /obj/item/clothing/gloves/marine/bravo(src)
	new /obj/item/clothing/under/marine2(src)
	new /obj/item/clothing/suit/storage/marine2(src)
	new /obj/item/weapon/storage/belt/marine(src)
	new /obj/item/clothing/head/helmet/marine2(src)
	new /obj/item/device/flashlight/seclite(src)
	new /obj/item/clothing/glasses/sunglasses(src)
	new /obj/item/device/radio/headset/mbravo(src)
	return

//CHARLIE EQUIPMENT CLOSET
/obj/structure/closet/secure_closet/marine/marine_charlie_equipment
	name = "Charlie Equipment Locker"
	req_access = list()
	icon_state = "squad_charlie"

/obj/structure/closet/secure_closet/marine/marine_charlie_equipment/New()
	update_icon()
	new /obj/item/clothing/shoes/marine(src)
	new /obj/item/clothing/gloves/marine/charlie(src)
	new /obj/item/clothing/under/marine2(src)
	new /obj/item/clothing/suit/storage/marine2(src)
	new /obj/item/weapon/storage/belt/marine(src)
	new /obj/item/clothing/head/helmet/marine2(src)
	new /obj/item/device/flashlight/seclite(src)
	new /obj/item/clothing/glasses/sunglasses(src)
	new /obj/item/device/radio/headset/mcharlie(src)
	return

//Delta EQUIPMENT CLOSET
/obj/structure/closet/secure_closet/marine/marine_delta_equipment
	name = "Delta Equipment Locker"
	req_access = list()
	icon_state = "squad_delta"

/obj/structure/closet/secure_closet/marine/marine_delta_equipment/New()
	update_icon()
	new /obj/item/clothing/shoes/marine(src)
	new /obj/item/clothing/gloves/marine/delta(src)
	new /obj/item/clothing/under/marine2(src)
	new /obj/item/clothing/suit/storage/marine2(src)
	new /obj/item/weapon/storage/belt/marine(src)
	new /obj/item/clothing/head/helmet/marine2(src)
	new /obj/item/device/flashlight/seclite(src)
	new /obj/item/clothing/glasses/sunglasses(src)
	new /obj/item/device/radio/headset/mdelta(src)
	return



//SULACO MEDICAL CLOSET
/obj/structure/closet/secure_closet/marine/medical
	name = "Sulaco Medical Doctor's Locker"
	req_access_txt = 504
	icon_state = "med_secure"

/obj/structure/closet/secure_closet/marine/medical/New()
	update_icon()
	if(prob(50))
		new /obj/item/weapon/storage/backpack/medic(src)
	else
		new /obj/item/weapon/storage/backpack/satchel_med(src)
	new /obj/item/clothing/under/rank/nursesuit (src)
	new /obj/item/clothing/head/nursehat (src)
	switch(pick("blue", "green", "purple"))
		if ("blue")
			new /obj/item/clothing/under/rank/medical/blue(src)
			//new /obj/item/clothing/head/surgery/blue(src)
		if ("green")
			new /obj/item/clothing/under/rank/medical/green(src)
			//new /obj/item/clothing/head/surgery/green(src)
		if ("purple")
			new /obj/item/clothing/under/rank/medical/purple(src)
			//new /obj/item/clothing/head/surgery/purple(src)
	switch(pick("blue", "green", "purple"))
		if ("blue")
			new /obj/item/clothing/under/rank/medical/blue(src)
			//new /obj/item/clothing/head/surgery/blue(src)
		if ("green")
			new /obj/item/clothing/under/rank/medical/green(src)
			//new /obj/item/clothing/head/surgery/green(src)
		if ("purple")
			new /obj/item/clothing/under/rank/medical/purple(src)
			//new /obj/item/clothing/head/surgery/purple(src)
	new /obj/item/clothing/under/rank/medical(src)
	new /obj/item/clothing/under/rank/nursesuit(src)
	new /obj/item/clothing/suit/toggle/labcoat(src)
	new /obj/item/clothing/suit/toggle/labcoat/genetics(src)
	new /obj/item/clothing/suit/toggle/labcoat/chemist(src)
	new /obj/item/clothing/suit/toggle/labcoat/virologist(src)
	new /obj/item/clothing/shoes/sneakers/white(src)
	new /obj/item/device/radio/headset/msulaco(src)
	new /obj/item/weapon/storage/belt/medical(src)
	new /obj/item/weapon/reagent_containers/hypospray(src)
	new /obj/item/clothing/glasses/hud/health(src)
	return


//MARINE SUPPLY CRATES APOPHIS775 15JAN2015

/obj/structure/closet/crate/large/marine/gear
	name = "Marine Gear"
	desc = "A crate containing standard issue Marine gear for 5 marines"
	New()
		..()
		for(var/c, c<5, c++)
			new /obj/item/clothing/under/marine2(src)
			new /obj/item/clothing/head/helmet/marine2(src)
			new /obj/item/clothing/suit/storage/marine2(src)
			new /obj/item/clothing/shoes/marine(src)
			new /obj/item/weapon/storage/belt/marine(src)
		return



/obj/structure/closet/crate/plastic/marine/alpha
	name = "Alpha Supply Crate"
	desc = "A crate with additional Alpha Squad Supplies"
	New()
		..()
		for(var/c, c<10, c++)
			new /obj/item/clothing/gloves/marine/alpha(src)
			new /obj/item/device/radio/headset/malpha(src)
		new /obj/item/device/radio/headset/malphal(src)
		return

/obj/structure/closet/crate/plastic/marine/bravo
	name = "Bravo Supply Crate"
	desc = "A crate with additional Bravo Squad Supplies"
	New()
		..()
		for(var/c, c<5, c++)
			new /obj/item/clothing/gloves/marine/bravo(src)
			new /obj/item/device/radio/headset/mbravo(src)
		new /obj/item/device/radio/headset/mbravol(src)
		return

/obj/structure/closet/crate/plastic/marine/charlie
	name = "Charlie Supply Crate"
	desc = "A crate with additional Charlie Squad Supplies"
	New()
		..()
		for(var/c, c<5, c++)
			new /obj/item/clothing/gloves/marine/charlie(src)
			new /obj/item/device/radio/headset/mcharlie(src)
		new /obj/item/device/radio/headset/mcharliel(src)
		return

/obj/structure/closet/crate/plastic/marine/delta
	name = "Delta Supply Crate"
	desc = "A crate with additional Delta Squad Supplies"
	New()
		..()
		for(var/c, c<5, c++)
			new /obj/item/clothing/gloves/marine/delta(src)
			new /obj/item/device/radio/headset/mdelta(src)
		new /obj/item/device/radio/headset/mdeltal(src)
		return



/obj/structure/closet/crate/plastic/marine/REBEL
	name = "REBEL Supply Crate"
	desc = "A crate with additional REBEL ALLIANCE Supplies"
	New()
		..()
		for(var/c, c<5, c++)
			new /obj/item/clothing/under/color/grey(src)
			new /obj/item/clothing/head/helmet/swat(src)
			new /obj/item/clothing/suit/armor/vest(src)
			new /obj/item/clothing/shoes/marine(src)
			new /obj/item/weapon/storage/belt/marine(src)
			new /obj/item/weapon/storage/belt/utility/full(src)
			new /obj/item/device/multitool(src)
			new /obj/item/weapon/storage/backpack(src)
		return


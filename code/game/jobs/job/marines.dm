//Commander
/datum/job/captain
	title = "Commander"
	flag = COMMANDER
	department_head = list("Centcom")
	department_flag = MARINES
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "Central Command"
	selection_color = "#ccccff"
	req_admin_notify = 1
	access = list() 			//See get_access()
	minimal_access = list() 	//See get_access()
	minimal_player_age = 14

	default_id = /obj/item/weapon/card/id/gold
	default_headset = /obj/item/device/radio/headset/mcom

/datum/job/captain/equip_items(mob/living/carbon/human/H)
	H.equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/mcommander(H), slot_back)

	var/obj/item/clothing/under/U = new /obj/item/clothing/under/marine/officer/commander(H)
	U.attachTie(new /obj/item/clothing/tie/medal/gold/captain())
	H.equip_to_slot_or_del(U, slot_w_uniform)

	H.equip_to_slot_or_del(new /obj/item/weapon/storage/belt/marine/full(H), slot_belt)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/marinechief/commander(H), slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/clothing/head/beret/marine/commander(H), slot_head)

	//Implant him
	var/obj/item/weapon/implant/loyalty/L = new/obj/item/weapon/implant/loyalty(H)
	L.imp_in = H
	L.implanted = 1
	H.sec_hud_set_implants()

	minor_announce("[H.real_name] is the Marine Commander!")

/datum/job/captain/get_access()
	return get_all_marine_accesses()

//Marine
/datum/job/marine
	title = "Marine"
	flag = MARINE
	department_flag = MARINES
	faction = "Station"
	total_positions = -1
	spawn_positions = -1
	supervisors = "the commander"
	selection_color = "#ffeeee"
	access = list()
	minimal_access = list()
	minimal_player_age = 0

/datum/job/marine/equip_items(mob/living/carbon/human/H)
	H.equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/marine(H), slot_back)

	H.equip_to_slot_or_del(new /obj/item/clothing/under/marine/casual(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/device/radio/marine(H), slot_l_store)
	H.equip_to_slot_or_del(new /obj/item/weapon/storage/box/marine(H), slot_in_backpack)


//Millitary Police
/datum/job/military_officer
	title = "Military Police"
	flag = MPOLICE
	department_flag = MARINES
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "the commander"
	selection_color = "#ffeeee"
	access = list(access_logistics, access_sulaco_brig, access_sulaco_cells)
	minimal_access = list(access_logistics, access_sulaco_brig, access_sulaco_cells)
	minimal_player_age = 3

	default_headset = /obj/item/device/radio/headset/mmpo

/datum/job/military_officer/equip_items(mob/living/carbon/human/H)
	H.equip_to_slot_or_del(new /obj/item/clothing/under/marine/mp(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine(H), slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/weapon/storage/belt/marine, slot_belt)

//Logistics Officer
/datum/job/logistics_officer
	title = "Logistics Officer"
	flag = LOGISTICS
	department_flag = MARINES
	faction = "Station"
	total_positions = 3
	spawn_positions = 3
	supervisors = "the commander"
	selection_color = "#ffeeee"
	access = list(access_logistics, access_sulaco_brig, access_sulaco_cells)
	minimal_access = list(access_logistics, access_sulaco_brig, access_sulaco_cells)
	minimal_player_age = 7

	default_id = /obj/item/weapon/card/id/silver
	default_headset = /obj/item/device/radio/headset/mcom

/datum/job/logistics_officer/equip_items(mob/living/carbon/human/H)
	H.equip_to_slot_or_del(new /obj/item/clothing/head/beret/marine/logisticsofficer(H), slot_head)
	H.equip_to_slot_or_del(new /obj/item/clothing/under/marine/officer/logistics(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine(H), slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine(H), slot_wear_suit)
	H.equip_to_slot_or_del(new /obj/item/weapon/storage/belt/marine/full(H), slot_belt)

//Sulaco Medic
/datum/job/sulmed
	title = "Sulaco Medic"
	flag = SULMED
	department_flag = MARINES
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "the commander"
	selection_color = "#ffeeee"
	access = list(access_medical_bay, access_medical_chem, access_medical_surgery, access_medical_genetics, access_medical_storage)
	minimal_access = list(access_medical_bay, access_medical_chem, access_medical_surgery, access_medical_genetics, access_medical_storage)
	minimal_player_age = 3

	default_headset = /obj/item/device/radio/headset/msulaco

/datum/job/sulmed/equip_items(mob/living/carbon/human/H)
	H.equip_to_slot_or_del(new /obj/item/clothing/under/pj/red(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/sneakers/white(H), slot_shoes)

/obj/item/clothing/under/marine2
	name = "Marine jumpsuit"
	desc = "A standard quilted Colonial Marine jumpsuit. Weaved with armored plates to protect against low-caliber rounds and light impacts."
	armor = list(melee = 20, bullet = 20, laser = 0,energy = 0, bomb = 10, bio = 0, rad = 0)
	flags = FPRINT
	siemens_coefficient = 0.9

	icon = 'icons/marines/marine_armor.dmi'
	icon_state = "jumpsuit2_s"
	item_state = "jumpsuit2"
	item_color = "jumpsuit2"
	var/sleeves = 2
	alternate_worn_icon = 'icons/marines/marine_armor.dmi'
//Sleves 2 = long
//Sleves 1 = short
//Sleves 0 = none
/obj/item/clothing/under/marine2/verb/sleeves()
	set category = "Object"
	set name = "Adjust sleeves"
	set src in usr

	if(usr.canmove && !usr.stat && !usr.restrained())
		src.sleeves += 1
		if(src.sleeves > 2)
			src.sleeves = 0
		switch(src.sleeves)
			if(0)
				icon_state = "jumpsuit0_s"
				item_state = "jumpsuit0"
				item_color = "jumpsuit0"
				usr << "You roll up the sleves."
			if(1)
				icon_state = "jumpsuit1_s"
				item_state = "jumpsuit1"
				item_color = "jumpsuit1"
				usr << "You roll down the sleves."
			if(2)
				icon_state = "jumpsuit2_s"
				item_state = "jumpsuit2"
				item_color = "jumpsuit2"
				usr << "You roll down the sleves."
		usr.update_inv_w_uniform()	//so our mob-overlays updates



#define ALPHA		1
#define BRAVO		2
#define CHARLIE		3
#define DELTA		4
#define NONE 		5

var/list/armormarkings = list()
var/list/armormarkings_sql = list()
var/list/helmetmarkings = list()
var/list/helmetmarkings_sql = list()
var/list/squad_colors = list(rgb(255,0,0), rgb(255,255,0), rgb(160,32,240), rgb(0,0,255))



/proc/initialize_marine_armor()
	var/i
	for(i=1, i<5, i++)
		var/image/armor
		var/image/helmet
		armor = image('icons/marines/marine_armor.dmi',icon_state = "std-armor")
		armor.color = squad_colors[i]
		armormarkings += armor
		armor = image('icons/marines/marine_armor.dmi',icon_state = "sql-armor")
		armor.color = squad_colors[i]
		armormarkings_sql += armor

		helmet = image('icons/marines/marine_armor.dmi',icon_state = "std-helmet")
		helmet.color = squad_colors[i]
		helmetmarkings += helmet
		helmet = image('icons/marines/marine_armor.dmi',icon_state = "sql-helmet")
		helmet.color = squad_colors[i]
		helmetmarkings_sql += helmet

/obj/item/clothing/head/helmet/marine2
	icon = 'icons/marines/marine_armor.dmi'
	icon_state = "helmet"
	alternate_worn_icon = 'icons/marines/marine_armor.dmi'
	item_state = "comhelm"
	name = "M10 Pattern Marine Helmet"
	desc = "A standard M10 Pattern Helmet. It reads on the label, 'The difference between an open-casket and closed-casket funeral. Wear on head for best results.'."
	armor = list(melee = 50, bullet = 80, laser = 50,energy = 10, bomb = 35, bio = 0, rad = 0)
	health = 4
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	var/mob/living/carbon/human/wornby
	var/squad = 0
	var/rank = 0
	var/image/markingoverlay
	var/obj/machinery/camera/portable/helmetCam = null

/obj/item/clothing/head/helmet/marine2/New(loc)
	..(loc)

/obj/item/clothing/head/helmet/marine2/attackby(var/obj/item/A as obj, mob/user as mob, params)
	if(istype(A, /obj/item/weapon/camera_assembly))
		if(helmetCam)
			user << "<span class='notice'>[src] already has a mounted camera.</span>"
			return
		user.drop_item()
		helmetCam = new /obj/machinery/camera/portable(src)
		helmetCam.assembly = A
		A.loc = helmetCam
		helmetCam.c_tag = "Helmet-Mounted Camera (No User)([rand(1,999)])"
		helmetCam.network = list("Sulaco")
		user.visible_message("[user] attaches [A] to [src].","<span class='notice'>You attach [A] to [src].</span>")
		update_icon()
		return

	if(istype(A, /obj/item/weapon/crowbar))
		if(!helmetCam)
			..()
			return
		helmetCam.assembly.loc = get_turf(src)
		helmetCam.assembly = null
		qdel(helmetCam)
		helmetCam = null
		user.visible_message("[user] removes [helmetCam] from [src].","<span class='notice'>You remove [helmetCam] from [src].</span>")
		update_icon()
		return

/obj/item/clothing/head/helmet/marine2/proc/get_squad(var/obj/item/weapon/card/id/card)
	rank = 0
	squad = 0
	if(!card)
		return

	if(findtext(card.assignment, "Leader") != 0)
		rank = 1
	if(findtext(card.assignment, "Alpha") != 0)
		squad = 1
	if(findtext(card.assignment, "Bravo") != 0)
		squad = 2
	if(findtext(card.assignment, "Charlie") != 0)
		squad = 3
	if(findtext(card.assignment, "Delta") != 0)
		squad = 4

	if(helmetCam)
		switch(squad)
			if(0)
				helmetCam.network = list("Sulaco")
			if(1)
				helmetCam.network = list("Alpha")
			if(2)
				helmetCam.network = list("Bravo")
			if(3)
				helmetCam.network = list("Charlie")
			if(4)
				helmetCam.network = list("Delta")
	return

/obj/item/clothing/head/helmet/marine2/equipped(mob/living/carbon/human/user, slot)
	if(slot == slot_head)
		if(helmetCam)
			helmetCam.c_tag = "Helmet-Mounted Camera ([user.name])([rand(1,999)])"

		wornby = user
		update_helmet()

/obj/item/clothing/head/helmet/marine2/unequipped(mob/living/carbon/human/user)
	if(user.head != src)
		if(helmetCam)
			helmetCam.c_tag = "Helmet-Mounted Camera (No User)([rand(1,999)])"

		if(istype(markingoverlay) && markingoverlay in user.overlays_standing)
			user.overlays_standing.Remove(markingoverlay)
		user.update_icons()
		wornby = null
		update_icon()

/obj/item/clothing/head/helmet/marine2/proc/update_helmet(var/obj/item/weapon/card/id/card = null)
	if(!card)
		if(wornby && wornby.wear_id)
			card = wornby.wear_id
	get_squad(card)
	update_icon()

/obj/item/clothing/head/helmet/marine2/update_icon()
	overlays = list() //resets list
	underlays = list()

	if(helmetCam)
		overlays += "cam" //"helmet-cam"

	if(wornby)
		if(istype(markingoverlay) && markingoverlay in wornby.overlays_standing)
			wornby.overlays_standing.Remove(markingoverlay)

		if(squad > 0)
			if(rank)
				markingoverlay = helmetmarkings_sql[squad]
				overlays += markingoverlay
				wornby.overlays_standing += markingoverlay
			else
				markingoverlay = helmetmarkings[squad]
				overlays += markingoverlay
				wornby.overlays_standing += markingoverlay
		wornby.update_icons()


/obj/item/clothing/suit/storage/marine2
	icon = 'icons/marines/marine_armor.dmi'
	icon_state = "1"
	item_state = "1"
	alternate_worn_icon = 'icons/marines/marine_armor.dmi'
	body_parts_covered = CHEST|GROIN
	cold_protection = CHEST|GROIN
	min_cold_protection_temperature = ARMOR_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	name = "M3 Pattern Marine Armor"
	desc = "A standard Colonial Marines M3 Pattern Chestplate. Protects the chest from ballistic rounds, bladed objects and accidents. It has a small leather pouch strapped to it for limited storage."
	blood_overlay_type = "armor"
	armor = list(melee = 50, bullet = 80, laser = 50, energy = 10, bomb = 35, bio = 0, rad = 0)
	siemens_coefficient = 0.7
	allowed = list(/obj/item/weapon/gun/, /obj/item/weapon/tank/internals/emergency_oxygen, /obj/item/device/flashlight,/obj/item/ammo_box/magazine,/obj/item/ammo_casing,/obj/item/weapon/melee/baton, /obj/item/weapon/melee/stunprod, /obj/item/weapon/restraints, /obj/item/weapon/storage/fancy/cigarettes,/obj/item/weapon/lighter,/obj/item/weapon/grenade, /obj/item/weapon/combat_knife)
	var/mob/living/carbon/human/wornby
	var/squad = 0
	var/rank = 0
	var/image/markingoverlay

/obj/item/clothing/suit/storage/marine2/New(loc)
	..(loc)
	icon_state = "[rand(1,6)]"
	item_state = icon_state

/obj/item/clothing/suit/storage/marine2/proc/get_squad(var/obj/item/weapon/card/id/card)
	rank = 0
	squad = 0
	if(!card)
		return
	if(findtext(card.assignment, "Leader") != 0)
		rank = 1
	if(findtext(card.assignment, "Alpha") != 0)
		squad = 1
	if(findtext(card.assignment, "Bravo") != 0)
		squad = 2
	if(findtext(card.assignment, "Charlie") != 0)
		squad = 3
	if(findtext(card.assignment, "Delta") != 0)
		squad = 4
	return

/obj/item/clothing/suit/storage/marine2/equipped(mob/living/carbon/human/user, slot)
	if(slot == slot_wear_suit)
		wornby = user
		update_armor()

/obj/item/clothing/suit/storage/marine2/unequipped(mob/living/carbon/human/user)
	if(user.wear_suit != src)
		if(istype(markingoverlay) && markingoverlay in user.overlays_standing)
			user.overlays_standing.Remove(markingoverlay)
		user.update_icons()
		wornby = null
		update_icon()

/obj/item/clothing/suit/storage/marine2/proc/update_armor(var/obj/item/weapon/card/id/card = null)
	if(!card)
		if(wornby && wornby.wear_id)
			card = wornby.wear_id
	get_squad(card)
	update_icon()

/obj/item/clothing/suit/storage/marine2/update_icon()
	overlays = list() //resets list
	underlays = list()

	if(wornby)
		if(istype(markingoverlay) && markingoverlay in wornby.overlays_standing)
			wornby.overlays_standing.Remove(markingoverlay)

		if(squad > 0)
			if(rank)
				markingoverlay = armormarkings_sql[squad]
				overlays += markingoverlay
				wornby.overlays_standing += markingoverlay
			else
				markingoverlay = armormarkings[squad]
				overlays += markingoverlay
				wornby.overlays_standing += markingoverlay
		wornby.update_icons()

/obj/item/weapon/card/id/equipped(mob/living/carbon/human/user, slot)
	if(slot == slot_wear_id)
		if(user.wear_suit && istype(user.wear_suit, /obj/item/clothing/suit/storage/marine2))
			var/obj/item/clothing/suit/storage/marine2/armor = user.wear_suit
			armor.wornby = user
			armor.update_armor(src)
		if(user.head && istype(user.head, /obj/item/clothing/head/helmet/marine2))
			var/obj/item/clothing/head/helmet/marine2/helmet = user.head
			helmet.wornby = user
			helmet.update_helmet(src)

/obj/item/weapon/card/id/unequipped(mob/living/carbon/human/user)
	if(user.wear_id != src)
		if(user.wear_suit && istype(user.wear_suit, /obj/item/clothing/suit/storage/marine2))
			var/obj/item/clothing/suit/storage/marine2/armor = user.wear_suit
			if(istype(armor.markingoverlay) && armor.markingoverlay in user.overlays_standing)
				user.overlays_standing.Remove(armor.markingoverlay)
			user.update_icons()
			armor.wornby = null
			armor.update_armor(src)
		if(user.head && istype(user.head, /obj/item/clothing/head/helmet/marine2))
			var/obj/item/clothing/head/helmet/marine2/helmet = user.head
			if(istype(helmet.markingoverlay) && helmet.markingoverlay in user.overlays_standing)
				user.overlays_standing.Remove(helmet.markingoverlay)
			user.update_icons()
			helmet.wornby = null
			helmet.update_helmet(src)

//Power Armor
/obj/item/clothing/glasses/power_armor
	name = "Visor"
	desc = "Part of a Power Armor."
	icon_state = "visor"

	flags = NODROP
	vision_flags = 0
	darkness_view = 2
	invis_view = SEE_INVISIBLE_LIVING

	action_button_name = "Toggle Vision"
	var/vision = 0
	var/obj/item/clothing/head/helmet/space/pa/helmet

/obj/item/clothing/glasses/power_armor/ui_action_click()
	switch_vision()

/obj/item/clothing/glasses/power_armor/proc/switch_vision()
	switch(vision)
		if(0)
			vision = 1
			usr << "Night Vision Mode."

			darkness_view = 8
			vision_flags = SEE_TURFS
			invis_view = SEE_INVISIBLE_MINIMUM
		if(1)
			vision = 2
			usr << "Thermal Vision Mode."

			darkness_view = 2
			vision_flags = SEE_MOBS
			invis_view = 2
		if(2)
			vision = 3
			usr << "Advanced Thermal Vision Mode."

			darkness_view = 8
			vision_flags = SEE_TURFS|SEE_MOBS
			invis_view = SEE_INVISIBLE_MINIMUM
		if(3)
			vision = 0
			usr << "Normal Vision Mode."

			darkness_view = 2
			vision_flags = 0
			invis_view = SEE_INVISIBLE_LIVING

/obj/item/weapon/stock_parts/cell/nuclear_cell
	name = "nuclear power cell"
	maxcharge = 50000
	rating = 3
	chargerate = 150

/obj/item/clothing/head/helmet/space/pa
	name = "advanced power helmet"
	desc = "Top secret helmet."
	icon_state = "pa_helm"
	item_state = "pa_helm"
	desc = "Has a tag: Totally not property of an Weyland-Yutani, honest."
	w_class = 5
	armor = list(melee = 60, bullet = 60, laser = 55,energy = 55, bomb = 60, bio = 45, rad = 45)
	action_button_name = "Toggle Power"
	unacidable = 1
	var/obj/item/weapon/stock_parts/cell/nuclear_cell

	var/obj/item/clothing/glasses/power_armor/visor

	var/busy = 0
	var/activated = 0
	var/drain_power = 83

	var/obj/screen/power_counter
	var/obj/screen/health_counter

/obj/screen
	var/text_color = "#ffffff"

/obj/item/clothing/head/helmet/space/pa/New()
	..()
	SSobj.processing |= src
	nuclear_cell = new /obj/item/weapon/stock_parts/cell/nuclear_cell(src)

	power_counter = new /obj/screen()
	power_counter.name = "power_c"
	power_counter.screen_loc = "CENTER+1,CENTER+1"
	power_counter.layer = 20
	power_counter.text_color = "#00ff00"

	health_counter = new /obj/screen()
	health_counter.name = "health_c"
	health_counter.screen_loc = "CENTER-1,CENTER+1"
	health_counter.layer = 20

	if(!visor)
		visor = new /obj/item/clothing/glasses/power_armor(src)
		visor.helmet = src

/obj/item/clothing/head/helmet/space/pa/Destroy()
	SSobj.processing.Remove(src)
	if(ishuman(loc))
		deactivate(loc)
	..()

/obj/item/clothing/head/helmet/space/pa/take_damage(var/amt)
	if(activated)
		drain_power(amt * (rand(1,3) * 1000))
	else
		..()

/obj/item/clothing/head/helmet/space/pa/proc/drain_power(amount)
	if(!amount || !activated)
		return

	nuclear_cell.charge = max(0, nuclear_cell.charge - amount)
	update_counters()

/obj/item/clothing/head/helmet/space/pa/process()
	if(activated)
		if(ishuman(loc))
			var/mob/living/carbon/human/H = loc
			if(H.stat == DEAD)
				deactivate(H)
			else if(nuclear_cell.charge)
				nuclear_cell.charge = max(0, nuclear_cell.charge - (drain_power * (visor.vision ? visor.vision * 3 : 1)))
			else
				deactivate(H)
	else
		power_counter.text_color = "#00ff00"
		nuclear_cell.charge = min(nuclear_cell.maxcharge, nuclear_cell.charge + 150)
	update_counters()

/obj/item/clothing/head/helmet/space/pa/ui_action_click()
	switch_power()

/obj/item/clothing/head/helmet/space/pa/proc/equip_visor()
	var/mob/living/carbon/human/H = usr
	H.equip_to_slot_if_possible(visor,slot_glasses,0,0,1)
	H.update_inv_wear_suit()

/obj/item/clothing/head/helmet/space/pa/proc/remove_visor()
	if(ishuman(visor.loc))
		var/mob/living/carbon/H = visor.loc
		H.unEquip(visor, 1)
		H.update_inv_wear_suit()
	visor.loc = src

/obj/item/clothing/head/helmet/space/pa/proc/activate(mob/living/carbon/human/H)
	if(activated) return

	activated = 1

	H.status_resistance = 100
	H.staminaloss = 0
	H.stunned = 0
	H.weakened = 0
	H.paralysis = 0
	H.sleeping = 0

	var/obj/item/clothing/suit/space/pa/armor = H.wear_suit
	equip_visor()
	armor.slowdown = 2

	playsound(src.loc, 'sound/mecha/mechmove03.ogg', 50, 1)
	var/image/overlay = image('icons/mob/head.dmi', icon_state = "pa_helm_over", layer = 16)
	H.overlays_standing += overlay

	overlay = image('icons/mob/suit.dmi', icon_state = "pa_suit_over", layer = 16)
	H.overlays_standing += overlay
	H.update_icons()

	H.client.screen += health_counter
	power_counter.text_color = "#ff0000"
	update_counters()

/obj/item/clothing/head/helmet/space/pa/equipped(mob/living/carbon/human/user, slot)
	..()
	if(user.client && slot == slot_head)
		user.client.screen += power_counter
		update_counters()

/obj/item/clothing/head/helmet/space/pa/unequipped(mob/living/carbon/human/user)
	if(user.client && user.head != src)
		for(var/obj/screen/S in user.client.screen)
			if(S.name == "power_c")
				user.client.screen.Remove(S)
	..()

/obj/item/clothing/head/helmet/space/pa/proc/deactivate(mob/living/carbon/human/H)
	if(!activated) return

	activated = 0

	H.status_resistance = 0

	playsound(src.loc, 'sound/mecha/mechmove03.ogg', 50, 1)
	remove_visor()
	var/obj/item/clothing/suit/space/pa/armor = H.wear_suit
	armor.slowdown = initial(armor.slowdown)
	armor.flags &= ~NODROP
	src.flags &= ~NODROP

	for(var/image/I in H.overlays_standing)
		if(I.icon_state == "pa_helm_over" || I.icon_state == "pa_suit_over")
			H.overlays_standing.Remove(I)

	H.update_icons()

	for(var/obj/screen/S in H.client.screen)
		if(S.name == "health_c")
			H.client.screen.Remove(S)

/obj/item/clothing/head/helmet/space/pa/proc/update_counters()
	if(power_counter)
		var/power = 0
		power = nuclear_cell.charge * 100 / nuclear_cell.maxcharge
		power_counter.maptext = "<div align='center' valign='middle' style='position:relative; top:0px; left:6px'><font color='[power_counter.text_color]'>[round(power)]</font></div>"

	if(health_counter && ishuman(loc))
		var/mob/living/carbon/human/H = loc
		var/health = 0
		health = H.health
		health_counter.maptext = "<div align='center' valign='middle' style='position:relative; top:0px; left:6px'><font color='#FFAB00'>[round(health)]</font></div>"

/obj/item/clothing/head/helmet/space/pa/proc/switch_power()
	if(busy)
		return
	if(nuclear_cell.charge < 10000)
		usr << "Error... Not enough power to start the system."
		return
	busy = 1

	var/mob/living/carbon/human/H = usr
	if(!activated)
		if(H.head == src)
			if(!(H.glasses))
				if(istype(H.wear_suit, /obj/item/clothing/suit/space/pa))
					var/fail = 1
					var/obj/item/clothing/suit/space/pa/armor = H.wear_suit
					armor.flags |= NODROP
					src.flags |= NODROP
					if(do_mob(H,H, 200))
						if(!(H.glasses))
							activate(H)
							fail = 0
						else
							H << "Error... Remove glasses."
					if(fail)
						armor.flags &= ~NODROP
						src.flags &= ~NODROP
						H << "Activation interrupted."
				else
					H << "Error... Armor not found."
			else
				H << "Error... Remove glasses."
		else
			H << "Error... No user."
	else
		deactivate(H)

	busy = 0

/obj/item/clothing/suit/space/pa
	name = "advanced power armor"
	icon_state = "pa_suit"
	item_state = "pa_suit"
	desc = "Has a tag: Totally not property of an Weyland-Yutani, honest."
	w_class = 5
	allowed = list(/obj/item/weapon/gun,/obj/item/ammo_box,/obj/item/ammo_casing,/obj/item/weapon/melee/baton,/obj/item/weapon/melee/energy/sword/saber,/obj/item/weapon/restraints/handcuffs,/obj/item/weapon/tank/internals)
	slowdown = 5
	armor = list(melee = 60, bullet = 60, laser = 55,energy = 55, bomb = 60, bio = 45, rad = 45)
	unacidable = 1

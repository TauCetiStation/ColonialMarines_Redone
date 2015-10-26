#define U_MAIN_MENU       1
#define U_CATEGORY_MENU   2

/obj/machinery/upgrade_station
	name = "Upgrade Station"
	desc = "Research various upgrades for your needs."
	icon_state = "ustation"
	density = 1

	var/operating = 0.0
	anchored = 1.0
	use_power = 1
	idle_power_usage = 10
	active_power_usage = 100
	var/busy = 0

	var/datum/upgrade/being_researched
	var/progress = 0
	var/datum/researchable_upgrades/files
	var/selected_category
	var/screen = 1

	var/tokens = 0

	var/obj/item/device/radio/Radio //needed to send messages to sec radio

	var/list/categories = list(
							//"M4A3 Service Pistol",
							"VP78 Pistol",
							"M37A2 Pump Shotgun",
							"M39 Submachine Gun",
							"M41A Pulse Rifle MK2",
							"M59B Smartgun",
							"M42C Rifle",
							"M-6B Rocket Launcher",
							"Mods and Special",
							"Planetary Scanner"
							)

var/datum/researchable_upgrades/current_marine_upgrades = new /datum/researchable_upgrades()

/obj/machinery/upgrade_station/New()
	..()

	Radio = new/obj/item/device/radio(src)
	Radio.listening = 0

	files = current_marine_upgrades

/obj/machinery/upgrade_station/interact(mob/user)
	if(!is_operational())
		return

	var/dat

	switch(screen)
		if(U_MAIN_MENU)
			dat = main_win(user)
		if(U_CATEGORY_MENU)
			dat = category_win(user,selected_category)

	var/datum/browser/popup = new(user, "upgstation", name, 400, 500)
	popup.set_content(dat)
	popup.open()

	return

/obj/machinery/upgrade_station/attackby(obj/item/O, mob/user, params)
	if(busy)
		user << "<span class=\"alert\">The [name] is busy. Please wait for completion of previous operation.</span>"
		return 1

	if(stat)
		return 1

	if(!user.unEquip(O))
		user << "<span class='warning'>\The [O] is stuck to you and cannot be placed into the [name].</span>"
		return 1

	if(istype(O, /obj/item/token))
		user << "<span class='notice'>You insert token to the [name].</span>"
		tokens++
		qdel(O)

	src.updateUsrDialog()

/obj/machinery/upgrade_station/attack_paw(mob/user)
	return attack_hand(user)

/obj/machinery/upgrade_station/attack_hand(mob/user)
	if(..(user, 0))
		return
	interact(user)

/obj/machinery/upgrade_station/Topic(href, href_list)
	if(..())
		return
	if (!busy)
		if(href_list["menu"])
			screen = text2num(href_list["menu"])

		if(href_list["category"])
			selected_category = href_list["category"]

		if(href_list["make"])

			being_researched = files.FindUpgradeByID(href_list["make"])
			if(!being_researched)
				return

			if(can_research(being_researched, usr))
				busy = 1
				start_research(being_researched)
			else
				being_researched = null
				return

	else
		usr << "<span class=\"alert\">The [name] is busy. Please wait for completion of previous operation.</span>"

	src.updateUsrDialog()

	return

/obj/machinery/upgrade_station/proc/main_win(mob/user)
	var/dat = "<div class='statusDisplay'>"
	var/line_length = 1
	dat += "<table style='width:100%' align='center'><tr>"

	for(var/C in categories)
		if(line_length > 2)
			dat += "</tr><tr>"
			line_length = 1

		dat += "<td><A href='?src=\ref[src];category=[C];menu=[U_CATEGORY_MENU]'>[C]</A></td>"
		line_length++

	dat += "</tr></table></div>"
	dat += "<b>Tokens amount:</b> [tokens ? "<span class='good'>[tokens]</span>" : "<span class='bad'>[0]</span>"]<br>"
	return dat

/obj/machinery/upgrade_station/proc/category_win(mob/user,selected_category)
	var/dat = "<A href='?src=\ref[src];menu=[U_MAIN_MENU]'>Return to main menu</A> Browsing <b>[selected_category]:</b>"
	dat += "<div class='statusDisplay'><b>Researching:</b> [being_researched ? "[being_researched.name] ([progress]% done)" : "nothing"]</div>"
	dat += "<div class='statusDisplay'>"

	for(var/datum/upgrade/U in files.known_upgrades)
		if(!(selected_category in U.category))
			continue

		if(!can_research(U))
			dat += "<span class='linkOff'>[U.name] ([U.level] / [U.maxlevel]) [U.cost > 1 ? "(Price: [U.cost])" : ""]</span><br>"
			if(req_research(U))
				dat += "<span class='bad'>[U.desc_req]</span><br>"
		else
			dat += "<a href='?src=\ref[src];make=[U.id]'>[U.name] ([U.level] / [U.maxlevel])</a><br>"
		dat += "<span class='average'>[U.desc]</span><br>"

	dat += "</div>"
	dat += "<b>Tokens amount:</b> [tokens ? "<span class='good'>[tokens]</span>" : "<span class='bad'>[0]</span>"]<br>"
	return dat

/obj/machinery/upgrade_station/proc/req_research(datum/upgrade/U)
	if(U.req_upgrade)
		var/datum/upgrade/RU = files.FindUpgradeByID(U.req_upgrade)
		if(RU.level < U.req_upgrade_level)
			return 1
	return 0

/obj/machinery/upgrade_station/proc/can_research(datum/upgrade/U, mob/user)
	if(U.cost > tokens)
		return 0

	if(U.level >= U.maxlevel)
		return 0

	if(U.req_upgrade)
		var/datum/upgrade/RU = files.FindUpgradeByID(U.req_upgrade)
		if(RU.level < U.req_upgrade_level)
			return 0

	return 1

/obj/machinery/upgrade_station/proc/start_research(datum/upgrade/U)
	var/time_started = world.time
	var/time_needed = U.research_time*10
	var/time_finished = world.time + time_needed
	tokens--

	var/image/prog_bar
	prog_bar = image("icon" = 'icons/effects/doafter_icon.dmi', "icon_state" = "prog_bar_0")
	prog_bar.pixel_y = 32
	spawn()
		while(src && world.time < time_finished)
			overlays.Cut()
			var/cur_progress = ((world.time-time_started) / time_needed) * 100
			prog_bar.icon_state = "prog_bar_[round(cur_progress, 10)]"
			overlays += prog_bar
			progress = round(cur_progress)
			src.updateUsrDialog()
			sleep(10)

		playsound(loc, 'sound/machines/ping.ogg', 50, 0)
		end_research(U)
		src.updateUsrDialog()

/obj/machinery/upgrade_station/proc/end_research(datum/upgrade/U)
	Radio.set_frequency(MSUL_FREQ)
	Radio.talk_into(src, "[U.name] research completed. [U.vendor == "skip" ? "You can find new toys at [U.vendor] vending machines." : ""]", MSUL_FREQ)

	being_researched = null
	overlays.Cut()
	progress = 0
	U.increase_level()
	busy = 0

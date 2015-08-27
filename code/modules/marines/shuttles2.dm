

/obj/machinery/computer/shuttle/marine1
	name = "Shuttle Console I"
	desc = "Used to pilot the mining shuttle."
	circuit = /obj/item/weapon/circuitboard/shuttle
	shuttleId = "marine1"
	possible_destinations = "sulaco1;planet1"

/obj/machinery/computer/shuttle/marine1/one_way/sulaco
	name = "shuttle console"
	desc = "A one-way shuttle console, used to summon the shuttle to the labor camp."
	possible_destinations = "sulaco1"
	circuit = /obj/item/weapon/circuitboard/shuttle

/obj/machinery/computer/shuttle/marine1/one_way/planet
	name = "shuttle console"
	desc = "A one-way shuttle console, used to summon the shuttle to the labor camp."
	possible_destinations = "planet1"
	circuit = /obj/item/weapon/circuitboard/shuttle

/obj/machinery/computer/shuttle/marine2
	name = "Shuttle Console II"
	desc = "Used to pilot the shuttle."
	circuit = /obj/item/weapon/circuitboard/shuttle
	shuttleId = "marine2"
	possible_destinations = "sulaco2;planet2"

/obj/machinery/computer/shuttle/marine2/one_way/sulaco
	name = "shuttle console"
	desc = "A one-way shuttle console, used to summon the shuttle to the labor camp."
	possible_destinations = "sulaco2"
	circuit = /obj/item/weapon/circuitboard/shuttle

/obj/machinery/computer/shuttle/marine2/one_way/planet
	name = "shuttle console"
	desc = "A one-way shuttle console, used to summon the shuttle to the labor camp."
	possible_destinations = "planet2"
	circuit = /obj/item/weapon/circuitboard/shuttle


/obj/machinery/computer/shuttle/marine1/one_way/sulaco/Topic(href, href_list)
	if(href_list["move"])
		var/obj/docking_port/mobile/M = SSshuttle.getShuttle("marine1")
		if(!M)
			usr << "<span class='warning'>Cannot locate shuttle!</span>"
			return 0
		var/obj/docking_port/stationary/S = M.get_docked()
		if(S && S.name == "sulaco1")
			usr << "<span class='warning'>Shuttle is already here!</span>"
			return 0
	..()

/obj/machinery/computer/shuttle/marine1/one_way/planet/Topic(href, href_list)
	if(href_list["move"])
		var/obj/docking_port/mobile/M = SSshuttle.getShuttle("marine1")
		if(!M)
			usr << "<span class='warning'>Cannot locate shuttle!</span>"
			return 0
		var/obj/docking_port/stationary/S = M.get_docked()
		if(S && S.name == "planet1")
			usr << "<span class='warning'>Shuttle is already at the outpost!</span>"
			return 0
	..()

/obj/machinery/computer/shuttle/marine2/one_way/sulaco/Topic(href, href_list)
	if(href_list["move"])
		var/obj/docking_port/mobile/M = SSshuttle.getShuttle("marine2")
		if(!M)
			usr << "<span class='warning'>Cannot locate shuttle!</span>"
			return 0
		var/obj/docking_port/stationary/S = M.get_docked()
		if(S && S.name == "sulaco2")
			usr << "<span class='warning'>Shuttle is already here!</span>"
			return 0
	..()

/obj/machinery/computer/shuttle/marine2/one_way/planet/Topic(href, href_list)
	if(href_list["move"])
		var/obj/docking_port/mobile/M = SSshuttle.getShuttle("marine2")
		if(!M)
			usr << "<span class='warning'>Cannot locate shuttle!</span>"
			return 0
		var/obj/docking_port/stationary/S = M.get_docked()
		if(S && S.name == "planet2")
			usr << "<span class='warning'>Shuttle is already at the outpost!</span>"
			return 0
	..()
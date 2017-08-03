/obj/machinery/computer/security/marine_hlemet
	name = "Marine Status Display (All)"
	network = list("Sulaco", "Alpha", "Bravo", "Charlie", "Delta")
	circuit = /obj/item/weapon/circuitboard/marine_hlemet

/obj/machinery/computer/security/marine_hlemet/alpha
	name = "Marine Status Display (Alpha)"
	network = list("Alpha")

/obj/machinery/computer/security/marine_hlemet/alpha/New()
	..()
	var/obj/item/weapon/circuitboard/marine_hlemet/C = circuit
	C.switch_mode(2)

/obj/machinery/computer/security/marine_hlemet/bravo
	name = "Marine Status Display (Bravo)"
	network = list("Bravo")

/obj/machinery/computer/security/marine_hlemet/bravo/New()
	..()
	var/obj/item/weapon/circuitboard/marine_hlemet/C = circuit
	C.switch_mode(3)

/obj/machinery/computer/security/marine_hlemet/charlie
	name = "Marine Status Display (Charlie)"
	network = list("Charlie")

/obj/machinery/computer/security/marine_hlemet/charlie/New()
	..()
	var/obj/item/weapon/circuitboard/marine_hlemet/C = circuit
	C.switch_mode(4)

/obj/machinery/computer/security/marine_hlemet/delta
	name = "Marine Status Display (Delta)"
	network = list("Delta")

/obj/machinery/computer/security/marine_hlemet/delta/New()
	..()
	var/obj/item/weapon/circuitboard/marine_hlemet/C = circuit
	C.switch_mode(5)

/obj/item/weapon/circuitboard/marine_hlemet
	name = "circuit board (Marine Status Display (All))"
	build_path = /obj/machinery/computer/security/marine_hlemet

	var/build_type = 1
	var/max_build_type = 5

/obj/item/weapon/circuitboard/marine_hlemet/proc/switch_mode(var/mode)
	build_type = mode
	switch(build_type)
		if(1)
			name = "circuit board (Marine Status Display (All))"
			build_path = /obj/machinery/computer/security/marine_hlemet
		if(2)
			name = "circuit board (Marine Status Display (Alpha))"
			build_path = /obj/machinery/computer/security/marine_hlemet/alpha
		if(3)
			name = "circuit board (Marine Status Display (Bravo))"
			build_path = /obj/machinery/computer/security/marine_hlemet/bravo
		if(4)
			name = "circuit board (Marine Status Display (Charlie))"
			build_path = /obj/machinery/computer/security/marine_hlemet/charlie
		if(5)
			name = "circuit board (Marine Status Display (Delta))"
			build_path = /obj/machinery/computer/security/marine_hlemet/delta

/obj/item/weapon/circuitboard/marine_hlemet/attackby(obj/item/W, mob/user, params)
	if(!istype(W, /obj/item/device/multitool))
		..()
		return

	build_type++

	if(build_type > max_build_type)
		build_type = 1

	var/mode_name = "All"
	switch(build_type)
		if(1)
			mode_name = "All"
		if(2)
			mode_name = "Alpha"
		if(3)
			mode_name = "Bravo"
		if(4)
			mode_name = "Charlie"
		if(5)
			mode_name = "Delta"
	user << "<span class='notice'>You switch camera chanel to [mode_name]</span>"

	switch_mode(build_type)


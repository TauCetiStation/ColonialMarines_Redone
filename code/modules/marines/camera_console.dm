/obj/machinery/computer/security/marine_hlemet
	name = "Marine Status Display (All)"
	network = list("Sulaco", "Alpha", "Bravo", "Charlie", "Delta")

/obj/machinery/computer/security/marine_hlemet/alpha
	name = "Marine Status Display (Alpha)"
	network = list("Alpha")

/obj/machinery/computer/security/marine_hlemet/bravo
	name = "Marine Status Display (Bravo)"
	network = list("Bravo")

/obj/machinery/computer/security/marine_hlemet/charlie
	name = "Marine Status Display (Charlie)"
	network = list("Charlie")

/obj/machinery/computer/security/marine_hlemet/delta
	name = "Marine Status Display (Delta)"
	network = list("Delta")



/obj/item/weapon/circuitboard/marine_hlemet
	name = "circuit board (Marine Status Display (All))"
	build_path = /obj/machinery/computer/security/marine_hlemet

	var/build_type = 1
	var/max_build_type = 5

/obj/item/weapon/circuitboard/marine_hlemet/attackby(obj/item/W, mob/user, params)
	if(!istype(W, /obj/item/device/multitool))
		..()

	build_type++
	if(build_type > max_build_type)
		build_type = 1

	switch(build_type)
		if(1)
			name = "circuit board (Marine Status Display (All))"
			build_path = /obj/machinery/computer/security/marine_hlemet
			user << "<span class='notice'>You switch camera chanel to All</span>"
		if(2)
			name = "circuit board (Marine Status Display (Alpha))"
			build_path = /obj/machinery/computer/security/marine_hlemet/alpha
			user << "<span class='notice'>You switch camera chanel to Alpha</span>"
		if(3)
			name = "circuit board (Marine Status Display (Bravo))"
			build_path = /obj/machinery/computer/security/marine_hlemet/bravo
			user << "<span class='notice'>You switch camera chanel to Bravo</span>"
		if(4)
			name = "circuit board (Marine Status Display (Charlie))"
			build_path = /obj/machinery/computer/security/marine_hlemet/charlie
			user << "<span class='notice'>You switch camera chanel to Charlie</span>"
		if(5)
			name = "circuit board (Marine Status Display (Delta))"
			build_path = /obj/machinery/computer/security/marine_hlemet/delta
			user << "<span class='notice'>You switch camera chanel to Delta</span>"


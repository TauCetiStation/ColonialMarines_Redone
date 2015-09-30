/turf/simulated/floor/goonplaque
	name = "Commemorative Plaque"
	icon_state = "plaque"
	desc = "\"This is a plaque in honour of our comrades on the G4407 Stations. Hopefully TG4407 model can live up to your fame and fortune.\" Scratched in beneath that is a crude image of a meteor and a spaceman. The spaceman is laughing. The meteor is exploding."
	floor_tile = /obj/item/stack/tile/plasteel

/turf/simulated/floor/vault
	icon_state = "rockvault"
	floor_tile = /obj/item/stack/tile/plasteel

/turf/simulated/floor/bluegrid
	icon = 'icons/turf/floors.dmi'
	icon_state = "bcircuit"
	floor_tile = /obj/item/stack/tile/plasteel

/turf/simulated/floor/greengrid
	icon = 'icons/turf/floors.dmi'
	icon_state = "gcircuit"
	floor_tile = /obj/item/stack/tile/plasteel

/turf/simulated/floor/plating/shuttle
	luminosity = 3

/turf/simulated/floor/plating/beach
	name = "Beach"
	icon = 'icons/misc/beach.dmi'
	ignoredirt = 1

/turf/simulated/floor/plating/beach/ex_act(severity, target)
	contents_explosion(severity, target)

/turf/simulated/floor/plating/beach/sand
	name = "Sand"
	icon_state = "sand"

/turf/simulated/floor/plating/beach/coastline
	name = "Coastline"
	icon = 'icons/misc/beach2.dmi'
	icon_state = "sandwater"

/turf/simulated/floor/plating/beach/water
	name = "Water"
	icon_state = "water"

/turf/simulated/floor/plating/ironsand/New()
	..()
	name = "Iron Sand"
	icon_state = "ironsand[rand(1,15)]"
	ignoredirt = 1

/turf/simulated/floor/plating/snow
	name = "snow"
	icon = 'icons/turf/snow.dmi'
	icon_state = "snow"
	ignoredirt = 1

/turf/simulated/floor/plating/snow/ex_act(severity, target)
	contents_explosion(severity, target)

/turf/simulated/floor/plating/snow/gravsnow
	icon_state = "gravsnow"

/turf/simulated/floor/plating/snow/gravsnow/corner
	icon_state = "gravsnow_corner"

/turf/simulated/floor/plating/snow/gravsnow/surround
	icon_state = "gravsnow_surround"

/turf/simulated/floor/noslip
	name = "high-traction floor"
	icon_state = "noslip"
	floor_tile = /obj/item/stack/tile/noslip
	broken_states = list("noslip-damaged1","noslip-damaged2","noslip-damaged3")
	burnt_states = list("noslip-scorched1","noslip-scorched2")

/turf/simulated/floor/noslip/MakeSlippery()
	return

/turf/simulated/floor/plating/desert
	name = "Desert"
	baseturf = /turf/simulated/floor/plating/desert
	icon = 'icons/turf/desert.dmi'
	icon_state = "desert"
	icon_plating = "desert"
	broken_states = list("desert")
	burnt_states = list("desert")
	ignoredirt = 1

/turf/simulated/floor/plating/desert/New()
	..()
	if(prob(85))
		icon_state = "desert"
	else
		if(prob(99))
			icon_state = "desert[rand(1,5)]"
		else
			icon_state = "desert_dug"
	//if(prob(1))
	//	if(prob(50))
	//		new /obj/effect/overlay/palmtree_l(src)
	//	else
	//		new /obj/effect/overlay/palmtree_r(src)

/turf/simulated/floor/plating/grass
	name = "Grass"
	baseturf = /turf/simulated/floor/plating/desert
	icon = 'icons/turf/desert2.dmi'
	icon_state = "grass0"
	icon_plating = "grass0"
	ignoredirt = 1

/turf/simulated/floor/plating/grass/New()
	..()
	if(icon_state == "grass0")
		if(prob(50))
			icon_state = "grass1"

		if(prob(10))
			new /obj/structure/flora/tree/dead(src)
		else if(prob(2))
			var/choice = pick(typesof(/obj/structure/flora/ausbushes))
			new choice(src)
		else if(prob(4))
			var/choice = pick(/obj/structure/flora/rock,/obj/structure/flora/rock/pile)
			new choice(src)
		else if(prob(1))
			overlays += image('icons/turf/desert2.dmi', "misc1", pixel_x = rand(-8,8), pixel_y = rand(-8,8))

/turf/simulated/floor/plating/grass/grasscorners
	name = "Grass"
	baseturf = /turf/simulated/floor/plating/desert
	icon = 'icons/turf/desert2.dmi'
	icon_state = "grasscorners"
	icon_plating = "grass0"
	ignoredirt = 1

/turf/simulated/floor/plating/grass/grassdiag
	name = "Grass"
	baseturf = /turf/simulated/floor/plating/desert
	icon = 'icons/turf/desert2.dmi'
	icon_state = "grassdiag"
	icon_plating = "grass0"
	ignoredirt = 1

/*
var/prev_sand = 0
/turf/simulated/floor/plating/desert
	name = "Desert"
	baseturf = /turf/simulated/floor/plating/desert
	icon = 'icons/turf/desert2.dmi'
	icon_state = "sand0"
	icon_plating = "sand0"

/turf/simulated/floor/plating/desert/New()
	..()
	prev_sand = !prev_sand
	icon_state = "sand[prev_sand]"

	if(prob(1))
		if(prob(50))
			overlays += image('icons/turf/desert2.dmi', "misc[rand(1,2)]", pixel_x = rand(-8,8), pixel_y = rand(-8,8))
		else
			overlays += image('icons/turf/desert2.dmi', "plant1")*/

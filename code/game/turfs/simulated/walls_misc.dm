/turf/simulated/wall/cult
	name = "wall"
	desc = "The patterns engraved on the wall seem to shift as you try to focus on them. You feel sick."
	icon = 'icons/turf/walls/cult_wall.dmi'
	icon_state = "cult"
	walltype = "cult"
	builtin_sheet = null
	canSmoothWith = null

/turf/simulated/wall/cult/break_wall()
	new /obj/effect/decal/cleanable/blood(src)
	new /obj/structure/cultgirder(src)

/turf/simulated/wall/cult/devastate_wall()
	new /obj/effect/decal/cleanable/blood(src)
	new /obj/effect/decal/remains/human(src)

/turf/simulated/wall/cult/narsie_act()
	return

/turf/simulated/wall/vault
	icon = 'icons/turf/walls.dmi'
	icon_state = "rockvault"

/turf/simulated/wall/rust
	name = "rusted wall"
	desc = "A rusted metal wall."
	icon = 'icons/turf/walls/rusty_wall.dmi'
	icon_state = "arust"
	walltype = "arust"
	hardness = 45

/turf/simulated/wall/r_wall/rust
	name = "rusted reinforced wall"
	desc = "A huge chunk of rusted reinforced metal."
	icon = 'icons/turf/walls/rusty_reinforced_wall.dmi'
	icon_state = "rrust"
	walltype = "rrust"
	hardness = 15

/turf/simulated/wall/r_wall/m557_wheel
	name = "reinforced wall m557"
	desc = "A huge truck"
	icon = 'icons/turf/walls/reinforced_wall.dmi'
	icon_state = "m_wall_r1"
	walltype = "shuttle"
	smooth = 0

/turf/simulated/wall/r_wall/m557_wheel/m557_truck_r1
	icon_state = "m_wall_r1"

/turf/simulated/wall/r_wall/m557_wheel/m557_truck_r2
	icon_state = "m_wall_r2"

/turf/simulated/wall/r_wall/m557_wheel/m557_truck_l1
	icon_state = "m_wall_l1"

/turf/simulated/wall/r_wall/m557_wheel/m557_truck_l2
	icon_state = "m_wall_l2"

/turf/simulated/wall/r_wall/m557_gun
	name = "reinforced gun m557"
	desc = "A huge gun"
	icon = 'icons/turf/walls/reinforced_wall.dmi'
	icon_state = "gun1_wall"
	walltype = "shuttle"
	smooth = 0

/turf/simulated/wall/r_wall/m557_gun/m557_gpart1
	icon_state = "gun1_wall"

/turf/simulated/wall/r_wall/m557_gun/m557_gpart2
	icon_state = "gun2_wall"

/turf/simulated/wall/r_wall/m557_gun/m557_gpart3
	icon_state = "gun3_wall"

/turf/simulated/wall/r_wall/m557_gun/m557_gpart4
	icon_state = "gun4_wall"


/turf/simulated/wall/r_wall/m557_wall
	name = "reinforced wall m557"
	desc = "A huge armor"
	icon = 'icons/turf/walls/reinforced_wall.dmi'
	icon_state = "m_wall_m1"
	walltype = "shuttle"
	smooth = 0

/turf/simulated/wall/r_wall/m557_wall/m557_wpart1
	icon_state = "m_wall_m1"

/turf/simulated/wall/r_wall/m557_wall/m557_wpart2
	icon_state = "m_wall_m2"

/turf/simulated/wall/r_wall/m557_wall/m557_wpart3
	icon_state = "m_wall_m3"

/turf/simulated/wall/r_wall/m557_wall/m557_wpart4
	icon_state = "m_wall_m4"

/turf/simulated/wall/r_wall/m557_wall/m557_wpart5
	icon_state = "m_wall_m5"

/turf/simulated/wall/r_wall/m557_wall/m557_wpart6
	icon_state = "m_wall_m6"

/turf/simulated/wall/r_wall/m557_wall/m557_wpart7
	icon_state = "m_wall_m7"

/turf/simulated/wall/r_wall/m557_wall/m557_wpart8
	icon_state = "m_wall_m8"

/turf/simulated/wall/r_wall/m557_wall/m557_wpart9
	icon_state = "m_wall_m9"

/turf/simulated/wall/r_wall/m557_wall/m557_wpart10
	icon_state = "m_wall_m10"

/turf/simulated/wall/r_wall/m557_wall/m557_wpart11
	icon_state = "m_wall_m11"

/turf/simulated/wall/r_wall/m557_wall/m557_wpart12
	icon_state = "m_wall_m12"

/turf/simulated/wall/r_wall/m557_wall/m557_wpart13
	icon_state = "m_wall_m13"


/turf/simulated/wall/shuttle
	name = "wall"
	icon = 'icons/turf/shuttle.dmi'
	icon_state = "wall1"
	walltype = "shuttle"
	smooth = 0

//sub-type to be used for interior shuttle walls
//won't get an underlay of the destination turf on shuttle move
/turf/simulated/wall/shuttle/interior/copyTurf(turf/T)
	if(T.type != type)
		T = new type(T)
		if(underlays.len)
			T.underlays = underlays
	if(T.icon_state != icon_state)
		T.icon_state = icon_state
	if(T.icon != icon)
		T.icon = icon
	if(T.color != color)
		T.color = color
	if(T.dir != dir)
		T.dir = dir
	T.transform = transform
	return T

/turf/simulated/wall/shuttle/copyTurf(turf/T)
	. = ..()
	T.transform = transform

//why don't shuttle walls habe smoothwall? now i gotta do rotation the dirty way
/turf/simulated/wall/shuttle/shuttleRotate(rotation)
	var/matrix/M = transform
	M.Turn(rotation)
	transform = M
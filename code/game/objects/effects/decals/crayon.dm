/obj/effect/decal/cleanable/crayon
	name = "rune"
	desc = "A rune drawn in crayon."
	icon = 'icons/effects/crayondecal.dmi'
	icon_state = "rune1"
	layer = 2.1
	anchored = 1
	var/do_icon_rotate = TRUE

/obj/effect/decal/cleanable/crayon/examine()
	set src in view(2)
	..()
	return


/obj/effect/decal/cleanable/crayon/New(location, main = "#FFFFFF", var/type = "rune1", var/e_name = "rune", var/rotation = 0)
	..()
	loc = location

	name = e_name
	desc = "A [name] drawn in crayon."
	icon_state = type

	if(rotation && do_icon_rotate)
		var/matrix/M = matrix()
		M.Turn(rotation)
		src.transform = M

	color = main

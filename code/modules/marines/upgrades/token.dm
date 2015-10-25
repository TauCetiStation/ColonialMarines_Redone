/obj/item/token
	name = "token"
	icon = 'icons/obj/objects.dmi'
	icon_state = "token"
	w_class = 1
	throw_speed = 3
	throw_range = 7
	burn_state = -1

/obj/item/token/New()
	..()
	spawn()
		for(var/i=1, i <= 7, i++)
			pixel_y += 2
			sleep(0.5)
		for(var/i=1, i <= 7, i++)
			pixel_y -= 2
			sleep(0.5)

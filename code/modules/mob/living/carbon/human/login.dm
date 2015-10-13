/mob/living/carbon/human/Login()
	..()
	update_hud()

	if(istype(glasses, /obj/item/clothing/glasses/hms)) //Not sure if i want this to be somewhere else for now.
		client.mouse_pointer_icon = file("icons/marines/crosshair1.dmi")

	return

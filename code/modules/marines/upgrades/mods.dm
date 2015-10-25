/obj/item/device/mod
	name = "a mod"
	desc = ""
	icon_state = "flash"
	item_state = "flashtool"
	throwforce = 0
	w_class = 1
	throw_speed = 3
	throw_range = 7
	flags = CONDUCT

/obj/item/device/mod/scope4
	name = "Reflex Sight"
	desc = "Comes with 4x magnification power. Can fit: M39 SMG and M41A MK2."
	icon = 'icons/obj/guns/projectile.dmi'
	icon_state = "scope4"
	action_button_name = "Use Reflex Sight"
	action_button_internal = 1

	var/obj/item/weapon/gun/installed = null

/obj/item/device/mod/scope4/ui_action_click()
	if(!installed)
		usr << "Looks like it has no power, perhaps if it was installed on a weapon this might work better"
		return
	installed.zoom(tileoffset=4,viewsize=8)

/obj/item/device/mod/scope1224
	name = "Sniper Rifle Scope"
	desc = "Comes with 12x-24x magnification power. Has ability to detect treats. Can fit: M42C."
	icon = 'icons/obj/guns/projectile.dmi'
	icon_state = "m42c-scope-i"
	action_button_name = "Use Rifle Scope"
	action_button_internal = 1

	var/obj/item/weapon/gun/installed = null
	var/zoom_power = 0
	var/scope_active = 0

/obj/item/device/mod/scope1224/ui_action_click()
	if(!installed)
		usr << "Looks like it has no power, perhaps if it was installed on a weapon this might work better"
		return
	if(!installed.zoom)
		zoom_power = 0

	switch(zoom_power)
		if(0)
			zoom_power = 12
		if(12)
			installed.zoom = 0
			zoom_power = 24

	installed.zoom(tileoffset=zoom_power)

	if(!scope_active)
		scope_active = 1
		scope_marktreats(usr)

/obj/item/device/mod/scope1224/proc/reset_treats(mob/living/carbon/human/user)
	if(user.client)
		for(var/image/I in user.client.images)
			if(I.icon_state == "hms_treats")
				user.client.images.Remove(I)

/obj/item/device/mod/scope1224/proc/scope_marktreats(mob/living/user)
	while(user && user.client && user.client.view > 7)
		reset_treats(user)
		for(var/mob/living/L in living_mob_list)
			if(L == user)
				continue

			if(ishuman(L))
				var/mob/living/carbon/human/H = L
				if(H.wear_suit && istype(H.wear_suit, /obj/item/clothing/suit/storage/marine2))
					continue

			var/turf/location
			if(L.z == 0)
				var/turf/T = get_turf(L)
				if(T.z != user.z)
					continue
				else
					location = T
			else if(L.z != user.z)
				continue

			var/image/I
			if(isalienadult(L))
				var/mob/living/carbon/alien/humanoid/H = L
				var/pix_x = -H.custom_pixel_x_offset
				var/pix_y = -H.custom_pixel_y_offset
				I = image('icons/marines/cr_lock.dmi', loc = location ? location : L, icon_state = "hms_treats", layer = 16, pixel_x = pix_x, pixel_y = pix_y)
			else
				I = image('icons/marines/cr_lock.dmi', loc = location ? location : L, icon_state = "hms_treats", layer = 16)
			user.client.images += I
		sleep(10)

	scope_active = 0
	if(user)
		reset_treats(user)

//I'm too lazy to recode action buttons code and current TG code base has support of only 1 action button
//per item. So we simply spawn another item with an internal button setting and put that item in the item of choice.
//Result: weapon or whatever with multiple action buttons...
/obj/item/action_buttons
	action_button_name = "Rename me!"
	action_button_internal = 1

/obj/item/action_buttons/New()
	if(!isobj(loc))
		qdel(src) //There is no reason to spawn this outside of another item.
		return
	..()

//M-6B Rocket Launcher
/obj/item/action_buttons/weapons/m6b/unload_rocket
	icon = 'icons/obj/ammo.dmi'
	icon_state = "rocket-he"
	action_button_name = "Unload Rocket"

/obj/item/action_buttons/weapons/m6b/unload_rocket/ui_action_click()
	unload_shell()

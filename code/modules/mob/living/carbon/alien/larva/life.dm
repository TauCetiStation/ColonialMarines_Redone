//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:32

/mob/living/carbon/alien/larva/Life()
	set invisibility = 0
	set background = BACKGROUND_ENABLED

	if (notransform)
		return

	..()
	if(stat != DEAD)

		if(health > 0)
			if(!client)
				larva_afk_tick++
			else
				larva_afk_tick = 0

		// GROW!
		if(amount_grown < max_grown)
			amount_grown++

	//some kind of bug in canmove() isn't properly calling update_icons, so this is here as a placeholder
	update_icons()

/mob/living/carbon/alien/larva/handle_regular_status_updates()

	if(..()) //alive

		if(health <= -maxHealth)
			death()
			return

		return 1
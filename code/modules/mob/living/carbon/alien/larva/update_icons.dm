
/mob/living/carbon/alien/larva/regenerate_icons()
	overlays = list()
	update_icons()

/mob/living/carbon/alien/larva/update_icons()
	var/state = "Bloody"
	if(amount_grown > 150)
		state = "Normal"
	else if(amount_grown > 50)
		state = "Normal"

	if(stat == DEAD)
		icon_state = "[state] Larva Dead"
	else if (handcuffed || legcuffed) //This should be an overlay. Who made this an icon_state?
		icon_state = "[state] Larva Cuff"
	else if(stat == UNCONSCIOUS || lying || resting)
		icon_state = "[state] Larva Sleeping"
	else if (stunned)
		icon_state = "[state] Larva Stunned"
	else
		icon_state = "[state] Larva"

/mob/living/carbon/alien/larva/update_transform() //All this is handled in update_icons()
	return update_icons()

/mob/living/carbon/alien/larva/update_inv_handcuffed()
	return
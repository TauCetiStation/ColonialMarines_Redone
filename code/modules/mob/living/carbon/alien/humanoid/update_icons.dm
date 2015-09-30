
/mob/living/carbon/alien/humanoid/update_icons()
	update_hud()		//TODO: remove the need for this to be here
	overlays.Cut()
	for(var/image/I in overlays_standing)
		overlays += I

	if(stat == DEAD)
		//If we mostly took damage from fire
		if(fireloss > 125)
			icon_state = "[caste] Dead"
		else
			icon_state = "[caste] Dead"

	else if((stat == UNCONSCIOUS && !sleeping) || weakened)
		icon_state = "[caste] Knocked Down"
	else if(leap_on_click)
		icon_state = "[caste] Pounce"

	else if(lying || resting || sleeping)
		icon_state = "[caste] Sleeping"
	else if(istype(src, /mob/living/carbon/alien/humanoid/crusher) && src:in_defense)
		icon_state = "[caste] Charging"
	else if(m_intent == "run")
		icon_state = "[caste] Running"
	else
		icon_state = "[caste] Walking"

	if(leaping)
		if(alt_icon == initial(alt_icon))
			var/old_icon = icon
			icon = alt_icon
			alt_icon = old_icon
		icon_state = "[caste] Leap"
		pixel_x = -32
		pixel_y = -32
	else
		if(alt_icon != initial(alt_icon))
			var/old_icon = icon
			icon = alt_icon
			alt_icon = old_icon
		pixel_x = get_standard_pixel_x_offset(lying)
		pixel_y = get_standard_pixel_y_offset(lying)

/mob/living/carbon/alien/humanoid/regenerate_icons()
	if(!..())
		update_hud()
	//	update_icons() //Handled in update_transform(), leaving this here as a reminder
		update_transform()

/mob/living/carbon/alien/humanoid/update_transform() //The old method of updating lying/standing was update_icons(). Aliens still expect that.
	if(lying > 0)
		lying = 90 //Anything else looks retarded
	..()
	update_icons()
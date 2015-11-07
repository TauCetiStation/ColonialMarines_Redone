/obj/screen/zone_sel/alien/update_icon()
	overlays.Cut()
	overlays += selecting

/mob/living/carbon/alien/proc/updatePlasmaDisplay()
	if(hud_used) //clientless aliens
		hud_used.alien_plasma_display.maptext = "<div align='center' valign='middle' style='position:relative; top:0px; left:6px'><font color='magenta'>[round(getPlasma())]</font></div>"

/mob/living/carbon/alien/larva/updatePlasmaDisplay()
	return

/mob/living/carbon/alien/proc/updateTreatsDisplay()
	if(hud_used) //clientless aliens
		var/sense_range = x_stats.h_sixsense
		if(sense_range)
			var/treats = 0
			for(var/mob/living/carbon/human/H in living_mob_list)
				var/atom/target = H
				if(H.z == 0)
					target = get_turf(H)
				if(target.z == src.z && get_dist(target,src) <= sense_range)
					treats++
			hud_used.alien_treats_display.maptext = "<div align='center' valign='middle' style='position:relative; top:0px; left:6px'><font color='magenta'>[treats]</font></div>"


/mob/living/carbon/alien/check_breath(datum/gas_mixture/breath)
	if(status_flags & GODMODE)
		return

	if(!breath || (breath.total_moles() == 0))
		//Aliens breathe in vaccuum
		return 0

	var/toxins_used = 0
	var/breath_pressure = (breath.total_moles()*R_IDEAL_GAS_EQUATION*breath.temperature)/BREATH_VOLUME

	//Partial pressure of the toxins in our breath
	var/Toxins_pp = (breath.toxins/breath.total_moles())*breath_pressure

	if(Toxins_pp) // Detect toxins in air
		adjustPlasma(breath.toxins*250)
		throw_alert("alien_tox")

		toxins_used = breath.toxins

	else
		clear_alert("alien_tox")

	//Breathe in toxins and out oxygen
	breath.toxins -= toxins_used
	breath.oxygen += toxins_used

	//BREATH TEMPERATURE
	handle_breath_temperature(breath)

/mob/living/carbon/alien/handle_status_effects()
	..()
	//natural reduction of movement delay due to stun.
	if(move_delay_add > 0)
		move_delay_add = max(0, move_delay_add - rand(1, 2))

/mob/living/carbon/alien/update_sight()
	if(stat == DEAD)
		sight |= SEE_TURFS
		sight |= SEE_MOBS
		sight |= SEE_OBJS
		see_in_dark = 8
		see_invisible = SEE_INVISIBLE_LEVEL_TWO
	else
		sight |= SEE_MOBS
		sight &= ~SEE_TURFS
		sight &= ~SEE_OBJS
		if(nightvision)
			see_in_dark = 8
			see_invisible = SEE_INVISIBLE_MINIMUM
		else if(!nightvision)
			see_in_dark = 4
			see_invisible = 45
		if(see_override)
			see_invisible = see_override

/mob/living/carbon/alien/handle_hud_icons()

	handle_hud_icons_health()
	if(islarva(src) || (isalienadult(src) && !isqueen(src)))
		queen_locator()

	handle_aura_icons()

	return 1

var/aura_xeno = "XENO Purple Aura"
var/aura_safe = "SAFE Blue Aura"
var/aura_caution = "CAUTION Yellow Aura"
var/aura_danger = "DANGER Red Aura"
var/aura_xenhum = "XEDA Danger Aura"

/mob/living/carbon/alien/proc/handle_aura_icons()
	if(client)
		for(var/image/I in client.images)
			if(dd_hassuffix_case(I.icon_state, "Aura"))
				client.images.Remove(I)
		for(var/mob/living/L in living_mob_list)
			if((L.z == src.z) || (L.z == 0))
				var/image/I
				var/location = L
				if(L.z == 0)
					if(istype(L.loc, /obj/mecha) || isalien(L.loc) || istype(L.loc, /obj/structure/closet))
						location = L.loc
					else
						location = get_turf(L)
				if(isalien(L))
					if(isalienadult(L))
						var/mob/living/carbon/alien/humanoid/A = L
						var/pix_x = -A.custom_pixel_x_offset //Not sure why this must be inverted...
						var/pix_y = -A.custom_pixel_y_offset
						I = image('icons/Xeno/Auras.dmi', loc = location, icon_state = aura_xeno, layer = 16, pixel_x = pix_x, pixel_y = pix_y)
					else
						I = image('icons/Xeno/Auras.dmi', loc = location, icon_state = aura_xeno, layer = 16)
				else if(ishuman(L))
					var/mob/living/carbon/human/H = L
					if(H.getorgan(/obj/item/organ/internal/alien/hivenode))
						I = image('icons/Xeno/Auras.dmi', loc = location, icon_state = aura_xenhum, layer = 16)
					else if(H.getorgan(/obj/item/organ/internal/body_egg/alien_embryo))
						I = image('icons/Xeno/Auras.dmi', loc = location, icon_state = aura_xeno, layer = 16)
					else
						if((H.r_hand && istype(H.r_hand, /obj/item/weapon/gun)) || (H.l_hand && istype(H.l_hand, /obj/item/weapon/gun)))
							I = image('icons/Xeno/Auras.dmi', loc = location, icon_state = aura_danger, layer = 16)
						else if((H.r_hand && istype(H.r_hand, /obj/item/weapon)) || (H.l_hand && istype(H.l_hand, /obj/item/weapon)))
							I = image('icons/Xeno/Auras.dmi', loc = location, icon_state = aura_caution, layer = 16)
						else
							I = image('icons/Xeno/Auras.dmi', loc = location, icon_state = aura_safe, layer = 16)
				else if(ismonkey(L))
					var/mob/living/carbon/monkey/M = L
					if(M.getorgan(/obj/item/organ/internal/body_egg/alien_embryo))
						I = image('icons/Xeno/Auras.dmi', loc = location, icon_state = aura_xeno, layer = 16)
					else
						I = image('icons/Xeno/Auras.dmi', loc = location, icon_state = aura_safe, layer = 16)
				else
					I = image('icons/Xeno/Auras.dmi', loc = location, icon_state = aura_safe, layer = 16)
				client.images += I


/mob/living/carbon/alien/CheckStamina()
	setStaminaLoss(max((staminaloss - 2), 0))
	return

/mob/living/carbon/alien/proc/queen_locator()
	var/mob/living/carbon/alien/humanoid/queen/target = null
	if(hud_used.locate_queen)
		for(var/mob/living/carbon/alien/humanoid/queen/M in mob_list)
			if(M && M.stat != DEAD)
				target = M
			else
				target = null
	if(!target)
		hud_used.locate_queen.icon_state = "trackoff"
		return

	hud_used.locate_queen.dir = get_dir(src,target)
	if(target && target != src)
		if(get_dist(src, target) != 0)
			hud_used.locate_queen.icon_state = "trackon"
		else
			hud_used.locate_queen.icon_state = "trackondirect"

	//spawn(10) .()

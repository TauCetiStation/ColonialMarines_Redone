/mob/living/carbon/human/movement_delay()
	if(dna)
		. += dna.species.movement_delay(src)

	if(locate(/obj/structure/alien/weeds) in loc)
		. += 2
	if(istype(loc, /turf/simulated/floor/plating/beach/sea))
		. += 3
	if(l_hand && istype(l_hand, /obj/item/weapon/gun/projectile/Assault/m59b))
		. += 1
	if(r_hand && istype(r_hand, /obj/item/weapon/gun/projectile/Assault/m59b))
		. += 1
	. += ..()
	. += config.human_delay

/mob/living/carbon/human/Process_Spacemove(movement_dir = 0)

	if(..())
		return 1

	//Do we have a working jetpack
	if(istype(back, /obj/item/weapon/tank/jetpack) && isturf(loc)) //Second check is so you can't use a jetpack in a mech
		var/obj/item/weapon/tank/jetpack/J = back
		if((movement_dir || J.stabilization_on) && J.allow_thrust(0.01, src))
			return 1
	if(istype(wear_suit, /obj/item/clothing/suit/space/hardsuit) && isturf(loc)) //Second check is so you can't use a jetpack in a mech
		var/obj/item/clothing/suit/space/hardsuit/C = wear_suit
		if(C.jetpack)
			if((movement_dir || C.jetpack.stabilization_on) && C.jetpack.allow_thrust(0.01, src))
				return 1

	return 0


/mob/living/carbon/human/slip(s_amount, w_amount, obj/O, lube)
	if(isobj(shoes) && (shoes.flags&NOSLIP) && !(lube&GALOSHES_DONT_HELP))
		return 0
	.=..()

/mob/living/carbon/human/experience_pressure_difference()
	playsound(src, 'sound/effects/space_wind.ogg', 50, 1)
	if(shoes && shoes.flags&NOSLIP)
		return 0
	. = ..()

/mob/living/carbon/human/mob_has_gravity()
	. = ..()
	if(!.)
		if(mob_negates_gravity())
			. = 1

/mob/living/carbon/human/mob_negates_gravity()
	return shoes && shoes.negates_gravity()

/mob/living/carbon/human/Move(NewLoc, direct)
	. =	..()
	if(dna)
		for(var/datum/mutation/human/HM in dna.mutations)
			HM.on_move(src, NewLoc)
	if(shoes)
		if(!lying)
			if(loc == NewLoc)
				if(!has_gravity(loc))
					return
				var/obj/item/clothing/shoes/S = shoes
				S.step_action()

	if(flip && isturf(loc) && .)
		SpinAnimation(5, 1)
		visible_message("<span class='warning'>[src] has made a flip!</span>", "<span class='warning'>You made a flip!</span>")
		flip = FALSE
		flip_delay = world.time + 300
		sleep(2)
		step(src, direct)
		sleep(2)
		step(src, direct)

/mob/living/carbon/human/verb/flip()
	set name = "Flip"
	set category = "IC"
	set desc = "Prepare to make a Flip"
	if(flip_delay > world.time)
		src << "<span class='warning'>you need to rest first!</span>"
		return
	if(flip)
		flip = FALSE
		src << "<span class='warning'>You relax and ready to normal running!</span>"
	else
		flip = TRUE
		src << "<span class='warning'>You prepared to make a flip!</span>"



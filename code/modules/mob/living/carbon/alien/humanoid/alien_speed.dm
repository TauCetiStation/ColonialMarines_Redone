/mob/living/carbon/alien/humanoid/movement_delay()
	. = ..()
	if(istype(loc, /turf/simulated/floor/plating/beach/sea))
		. +=  move_delay_add + 3
	else
		. += move_delay_add + config.alien_delay	//move_delay_add is used to slow aliens with stuns
	var/slow = (staminaloss/(maxHealth*2))*100
	if(slow > 80)
		. += 3	 
	if((slow<=80)&&(slow > 60))
		. += 2
	if((slow<=60)&&(slow > 40))
		. += 1	

/mob/living/carbon/alien/humanoid/drone/movement_delay()
	. = ..()
	. += 1

/mob/living/carbon/alien/humanoid/queen/movement_delay()
	. = ..()
	. += 3 - x_stats.q_move_speed

/mob/living/carbon/alien/humanoid/hivelord/movement_delay()
	. = ..()
	. += 2

/mob/living/carbon/alien/humanoid/crusher/movement_delay()
	if(in_defense)
		. = ..()
		. += 2
	else
		. = ..()
		. += 0
/*
/mob/living/carbon/alien/humanoid/carrier/movement_delay()
	. = 
	. += */

/mob/living/carbon/alien/humanoid/runner/movement_delay()
	. = -2
	. += ..()

/mob/living/carbon/alien/humanoid/hunter/movement_delay()
	. = -1
	. += ..()

/*
/mob/living/carbon/alien/humanoid/praetorian/movement_delay()
	. = 
	. += */

/mob/living/carbon/alien/humanoid/ravager/movement_delay()
	. = -0.5 + speed_bonus
	. += ..()

/*/mob/living/carbon/alien/humanoid/sentinel/movement_delay()
	. = ..()
	. += 1*/
/*
/mob/living/carbon/alien/humanoid/spitter/movement_delay()
	. = 
	. += */
/*
/mob/living/carbon/alien/humanoid/corroder/movement_delay()
	. = 
	. += */

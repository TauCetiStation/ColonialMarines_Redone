/mob/living/carbon/alien/humanoid/movement_delay()
	. = ..()
	. += move_delay_add + config.alien_delay	//move_delay_add is used to slow aliens with stuns

/mob/living/carbon/alien/humanoid/drone/movement_delay()
	. = ..()
	. += 1

/mob/living/carbon/alien/humanoid/queen/movement_delay()
	. = ..()
	. += 2

/mob/living/carbon/alien/humanoid/hivelord/movement_delay()
	. = ..()
	. += 2
/*
/mob/living/carbon/alien/humanoid/carrier/movement_delay()
	. = 
	. += */

/mob/living/carbon/alien/humanoid/runner/movement_delay()
	. = -2.3
	. += ..()

/mob/living/carbon/alien/humanoid/hunter/movement_delay()
	. = -1.8
	. += ..()
/*
/mob/living/carbon/alien/humanoid/preatorian/movement_delay()
	. = 
	. += */

/mob/living/carbon/alien/humanoid/ravager/movement_delay()
	. = -1.0
	. += ..()

/mob/living/carbon/alien/humanoid/sentinel/movement_delay()
	. = ..()
	. += 0.5

/mob/living/carbon/alien/humanoid/spitter/movement_delay()
	. = -0.5
	. += ..()
/*
/mob/living/carbon/alien/humanoid/corroder/movement_delay()
	. = 
	. += */

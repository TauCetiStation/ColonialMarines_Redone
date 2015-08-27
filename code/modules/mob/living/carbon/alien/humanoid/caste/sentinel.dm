/mob/living/carbon/alien/humanoid/sentinel
	name = "alien sentinel"
	caste = "Sentinel"
	maxHealth = 200
	health = 200
	icon_state = "Sentinel Walking"

	var/hasJelly = 0
	var/jellyProgress = 0
	var/jellyProgressMax = 750
	psychiccost = 25

	Stat()
		..()
		stat(null, "Jelly Progress: [jellyProgress]/[jellyProgressMax]")

	proc/growJelly()
		spawn while(1)
			if(hasJelly)
				if(jellyProgress < jellyProgressMax)
					jellyProgress = min(jellyProgress + 1, jellyProgressMax)
			sleep(10)

	proc/canEvolve()
		if(!hasJelly)
			return 0
		if(jellyProgress < jellyProgressMax)
			return 0
		return 1

/mob/living/carbon/alien/humanoid/sentinel/New()
	src.frozen = 1
	spawn (25)
		src.frozen = 0
	growJelly()

	internal_organs += new /obj/item/organ/internal/alien/plasmavessel/sentinel
	internal_organs += new /obj/item/organ/internal/alien/acid_weak
	internal_organs += new /obj/item/organ/internal/alien/neurotoxin_weak
	..()

/mob/living/carbon/alien/humanoid/sentinel/handle_hud_icons_health()
	if (healths)
		if (stat != 2)
			switch(health)
				if(200 to INFINITY)
					healths.icon_state = "health0"
				if(160 to 200)
					healths.icon_state = "health1"
				if(120 to 160)
					healths.icon_state = "health2"
				if(80 to 120)
					healths.icon_state = "health3"
				if(40 to 80)
					healths.icon_state = "health4"
				if(0 to 40)
					healths.icon_state = "health5"
				else
					healths.icon_state = "health6"
		else
			healths.icon_state = "health7"

//Aimable Spit *********************************************************
/mob/living/carbon/alien/humanoid/sentinel/ClickOn(var/atom/A, params)

	var/list/modifiers = params2list(params)
	if(modifiers["shift"])
		spit_neuro_aim(A, 1)

		return
	..()

/mob/living/carbon/alien/humanoid/sentinel/verb/evolve2() // -- TLE
	set name = "Evolve (Jelly)"
	set desc = "Evolve into a Spitter"
	set category = "Alien"
	if(!hivemind_check(psychiccost))
		src << "\red Your queen's psychic strength is not powerful enough for you to evolve further."
		return
	if(!canEvolve())
		if(hasJelly)
			src << "You are not ready to evolve yet"
		else
			src << "You need a mature royal jelly to evolve"
		return
	if(src.stat != CONSCIOUS)
		src << "You are unable to do that now."
		return
	if(health<maxHealth)
		src << "\red You are too hurt to Evolve."
		return
	src << "\blue <b>You are growing into a Spitter!</b>"

	var/mob/living/carbon/alien/humanoid/new_xeno

	new_xeno = new /mob/living/carbon/alien/humanoid/spitter(loc)
	src << "\green You begin to evolve!"

	for(var/mob/O in viewers(src, null))
		O.show_message(text("\green <B>[src] begins to twist and contort!</B>"), 1)
	if(mind)	mind.transfer_to(new_xeno)

	del(src)


	return

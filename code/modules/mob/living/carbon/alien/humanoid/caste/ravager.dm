/mob/living/carbon/alien/humanoid/ravager
	name = "alien ravager"
	caste = "Ravager"
	maxHealth = 500
	health = 500
	icon_state = "Ravager Walking"
	icon = 'icons/Xeno/2x2_Xenos.dmi'
	var/usedcharge = 0
	var/CHARGESPEED = 1
	var/CHARGECOOLDOWN = 6 // in seconds
	var/CHARGESTRENGTH = 4
	var/CHARGEDISTANCE = 4
	var/ATTACKTIME = 1.3 // in seconds
	var/nextattack = 0
	damagemin = 50
	damagemax = 75
	tacklemin = 4
	tacklemax = 7
	tackle_chance = 90 //Should not be above 100%
	psychiccost = 32
	ventcrawler = 0
	mob_size = MOB_SIZE_LARGE
	custom_pixel_x_offset = -18
	//class = 3
	var/charging = 0

/mob/living/carbon/alien/humanoid/ravager/New()
	internal_organs += new /obj/item/organ/internal/alien/plasmavessel/ravager
	//var/datum/reagents/R = new/datum/reagents(100)
	//reagents = R
	//R.my_atom = src
	//if(name == "alien ravager")
	//	name = text("alien ravager ([rand(1, 1000)])")
	//real_name = name
	var/matrix/M = matrix()
	M.Scale(1.15,1.15)
	src.transform = M
	//verbs -= /mob/living/carbon/alien/verb/ventcrawl
	//verbs -= /mob/living/carbon/alien/humanoid/verb/plant
	//pixel_x = -18
	..()

/mob/living/carbon/alien/humanoid/ravager/handle_hud_icons_health()
	if (healths)
		if (stat != 2)
			switch(health)
				if(500 to INFINITY)
					healths.icon_state = "health0"
				if(400 to 500)
					healths.icon_state = "health1"
				if(300 to 400)
					healths.icon_state = "health2"
				if(200 to 300)
					healths.icon_state = "health3"
				if(100 to 200)
					healths.icon_state = "health4"
				if(0 to 100)
					healths.icon_state = "health5"
				else
					healths.icon_state = "health6"
		else
			healths.icon_state = "health7"

/*
/mob/living/carbon/alien/humanoid/ravager

	handle_environment()
		if(m_intent == "run" || resting)
			..()
		else
			adjustToxLoss(-heal_rate)*/

/proc/oppositedir(var/dir)
	var/newdir
	switch(dir)
		if(1)
			newdir = 2
		if(2)
			newdir = 1
		if(3)
			newdir = 4
		if(4)
			newdir = 3
		else
			newdir = 2
	return newdir

/mob/living/carbon/alien/humanoid/ravager/ClickOn(var/atom/A, params)



	var/list/modifiers = params2list(params)
	if(modifiers["middle"] || modifiers["shift"])
		charge(A)

		return

	// Give Ravagers 2x the reach (BUG: CAN ATTACK THROUGH WALLS)
	// var/mob/living/carbon/human/C = A
	// if(C)
		// if(src.nextattack <= world.time)
			// src.nextattack = world.time + ATTACKTIME * 10
			// if(get_dist(src, C) == 2)
				// face_atom(C)
				// C.attack_alien(src)
				// return

	..()

/mob/living/carbon/alien/humanoid/ravager/verb/charge(var/mob/living/carbon/human/T)
	set name = "Charge"
	set desc = "Charge towards something."
	set category = "Alien"

	if(health<0)
		src << "You can't charge while unconcious!"
		return
	if(stat == 2)
		src << "You can't charge while dead!"

	if(usedcharge <= world.time)
		if(!T)
			var/list/victims = list()
			for(var/mob/living/carbon/human/C in oview(7))
				victims += C
			T = input(src, "Who should we charge towards?") as null|anything in victims

		if(T)
			usedcharge = world.time + CHARGECOOLDOWN * 10
			src.throw_at(T, CHARGEDISTANCE, CHARGESPEED)
			src << "We charge at [T]"
			visible_message("\red <B>[src] charges towards [T]!</B>")
			charging = CHARGESTRENGTH
			spawn(25)
				charging = 0


		else
			src << "\blue You cannot charge at nothing!"
	else
		src << "\red You need to wait before charging!"

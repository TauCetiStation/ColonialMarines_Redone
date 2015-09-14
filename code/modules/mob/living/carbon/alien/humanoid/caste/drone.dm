/mob/living/carbon/alien/humanoid/drone
	name = "alien drone"
	caste = "Drone"
	maxHealth = 170
	health = 170
	icon_state = "Drone Walking"

	var/hasJelly = 0
	var/jellyProgress = 0
	var/jellyProgressMax = 1000
	damagemin = 12
	damagemax = 16
	tacklemin = 2
	tacklemax = 3 //old max 5
	tackle_chance = 40 //Should not be above 100% old chance 50
	psychiccost = 30

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

/mob/living/carbon/alien/humanoid/drone/New()
	src.frozen = 1
	spawn (25)
		src.frozen = 0
	growJelly()

	var/matrix/M = matrix()
	M.Scale(0.9,0.9)
	src.transform = M

	internal_organs += new /obj/item/organ/internal/alien/plasmavessel/drone
	internal_organs += new /obj/item/organ/internal/alien/resinspinner
	internal_organs += new /obj/item/organ/internal/alien/acid_weak
	internal_organs += new /obj/item/organ/internal/alien/carapace/small

	AddAbility(new/obj/effect/proc_holder/alien/evolve(null))
	..()

/mob/living/carbon/alien/humanoid/drone/handle_hud_icons_health()
	if (healths)
		if (stat != 2)
			switch(health)
				if(170 to INFINITY)
					healths.icon_state = "health0"
				if(136 to 170)
					healths.icon_state = "health1"
				if(102 to 136)
					healths.icon_state = "health2"
				if(68 to 102)
					healths.icon_state = "health3"
				if(34 to 68)
					healths.icon_state = "health4"
				if(0 to 34)
					healths.icon_state = "health5"
				else
					healths.icon_state = "health6"
		else
			healths.icon_state = "health7"

/obj/effect/proc_holder/alien/evolve
	name = "Evolve"
	desc = "Produce an interal egg sac capable of spawning children. Only one queen can exist at a time."
	plasma_cost = 500

	action_icon_state = "alien_evolve_drone"

/obj/effect/proc_holder/alien/evolve/fire(mob/living/carbon/alien/user)
	var/no_queen = 1
	for(var/mob/living/carbon/alien/humanoid/queen/Q in living_mob_list)
		if(!Q.key || !Q.getorgan(/obj/item/organ/internal/brain))
			continue
		no_queen = 0

	if(queen_died > 0 && world.timeofday <= queen_died)
		user << "A new queen can evolve in about [round((queen_died - world.timeofday)/600,1)] minutes."
		return

	if(no_queen)
		user << "<span class='noticealien'>You begin to evolve!</span>"
		user.visible_message("<span class='alertalien'>[user] begins to twist and contort!</span>")
		var/mob/living/carbon/alien/humanoid/queen/new_xeno = new (user.loc)
		user.mind.transfer_to(new_xeno)
		qdel(user)
		return 1
	else
		user << "<span class='notice'>We already have an alive queen.</span>"
		return 0

/mob/living/carbon/alien/humanoid/drone/verb/evolve2() // -- TLE
	set name = "Evolve (Jelly)"
	set desc = "Evolve into your next form"
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
	if(jellyProgress >= jellyProgressMax)
		//green is impossible to read, so i made these blue and changed the formatting slightly
		src << "<B>Hivelord</B> \blue The ULTIMATE hive construction alien.  Capable of building massive hives, that's to it's tremendous Plasma reserve.  However, it is very slow and weak."
		src << "<B>Carrier</B> \blue The latest advance in Alien Evolution.  Capable of holding upto 6 Facehugger, and throwing them a far distance, directly to someones face."
		var/alien_caste = alert(src, "Please choose which alien caste you shall belong to.",,"Hivelord","Carrier")

		var/mob/living/carbon/alien/humanoid/new_xeno
		switch(alien_caste)
			if("Hivelord")
				new_xeno = new /mob/living/carbon/alien/humanoid/hivelord(loc)
			if("Carrier")
				new_xeno = new /mob/living/carbon/alien/humanoid/carrier(loc)
		if(mind)	mind.transfer_to(new_xeno)
		del(src)
		return
	else
		src << "\red You are not ready to evolve."
		return

	qdel(src)

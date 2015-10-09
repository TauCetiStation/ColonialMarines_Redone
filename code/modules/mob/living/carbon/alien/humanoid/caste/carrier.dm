/mob/living/carbon/alien/humanoid/carrier
	name = "alien carrier"
	caste = "Carrier"
	maxHealth = 200
	health = 200
	icon_state = "Carrier Walking"
	var/facehuggers = 0
	var/usedthrow = 0
	var/THROWSPEED = 2
	damagemin = 20
	damagemax = 30
	tacklemin = 1
	tacklemax = 3
	tackle_chance = 60 //Should not be above 100%
	psychiccost = 32
	ventcrawler = 0
	//class = 2
	custom_pixel_y_offset = 3

/mob/living/carbon/alien/humanoid/carrier/New()
	internal_organs += new /obj/item/organ/internal/alien/plasmavessel/carrier
	internal_organs += new /obj/item/organ/internal/alien/carapace

	//var/datum/reagents/R = new/datum/reagents(100)
	//reagents = R
	//R.my_atom = src
	//if(name == "alien carrier")
	//	name = text("alien carrier ([rand(1, 1000)])")
	//real_name = name
	var/matrix/M = matrix()
	M.Scale(1.1,1.15)
	src.transform = M
	//pixel_y = 3
	//verbs -= /atom/movable/verb/pull
	..()

/mob/living/carbon/alien/humanoid/carrier/handle_hud_icons_health()
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

/mob/living/carbon/alien/humanoid/carrier/Stat()

	..()

	if (client.statpanel == "Status")
		stat(null, "Facehuggers Stored: [facehuggers]/6")

/mob/living/carbon/alien/humanoid/carrier/Life()
	..()

	if(usedthrow < 0)
		usedthrow = 0
	else if(usedthrow > 0)
		usedthrow--

/mob/living/carbon/alien/humanoid/carrier/ClickOn(var/atom/A, params)
	face_atom(A)
	var/list/modifiers = params2list(params)
	if(modifiers["middle"] || modifiers["shift"])
		if(facehuggers > 0)
			throw_hugger(A)
		else
			..()
		return
	..()

/mob/living/carbon/alien/humanoid/carrier/verb/throw_hugger(var/mob/living/carbon/human/T)
	set name = "Throw Facehugger"
	set desc = "Throw one of your facehuggers"
	set category = "Alien"

	if(!isturf(loc))
		src << "\red Can throw only from a turf!"
		return

	if(health < 0)
		src << "\red You can't throw huggers when unconcious."
		return
	if (stat == 2)
		src << "\red You can't throw huggers when dead."
		return
	if(facehuggers <= 0)
		src << "\red You don't have any facehuggers to throw!"
		return
	if(usedthrow <= 0)
		if(!T)
			var/list/victims = list()
			for(var/mob/living/carbon/human/C in oview(7))
				victims += C
			T = input(src, "Who should you throw at?") as null|anything in victims

		if(T)
			var/obj/item/clothing/mask/facehugger/th = new()
			facehuggers -= 1
			usedthrow = 1
			th.loc = src.loc
			th.throw_at(T, 5, THROWSPEED)
			src << "We throw a facehugger at [T]"
			visible_message("\red <B>[src] throws something towards [T]!</B>")

		else
			src << "\blue You cannot throw at nothing!"
	else
		src << "\red You need to wait before throwing again!"

/*
/mob/living/carbon/alien/humanoid/carrier/handle_environment()
	if(m_intent == "run" || resting)
		..()
	else
		adjustToxLoss(-heal_rate)*/
/*
Todo: Overlays for facehuggers.

//Update carrier icons
/mob/living/carbon/alien/humanoid/carrier/update_icons()
	lying_prev = lying	//so we don't update overlays for lying/standing unless our stance changes again
	update_hud()		//TODO: remove the need for this to be here
	overlays.Cut()
	if(stat == DEAD)
		//If we mostly took damage from fire
		if(fireloss > 125)
			icon_state = "[caste] Dead - [facehuggers]"
		else
			icon_state = "[caste] Dead - [facehuggers]"
		for(var/image/I in overlays_lying)
			overlays += I
	else if(lying)
		if(resting)
			icon_state = "[caste] Sleeping - [facehuggers]"
		else if(stat == UNCONSCIOUS)
			icon_state = "[caste] Knocked Down - [facehuggers]"
		else
			icon_state = "[caste] Knocked Down - [facehuggers]"
		for(var/image/I in overlays_lying)
			overlays += I
	else
		if(m_intent == "run")		icon_state = "[caste] Running - [facehuggers]"
		else						icon_state = "[caste] Walking - [facehuggers]"
		for(var/image/I in overlays_standing)
			overlays += I
			*/
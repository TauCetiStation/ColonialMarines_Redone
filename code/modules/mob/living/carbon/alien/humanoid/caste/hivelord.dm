/mob/living/carbon/alien/humanoid/hivelord
	name = "alien hivelord"
	caste = "Hivelord"
	maxHealth = 320
	health = 320
	icon = 'icons/Xeno/2x2_Xenos.dmi'
	icon_state = "Hivelord Walking"
	damagemin = 10
	damagemax = 15
	tacklemin = 2
	tacklemax = 4
	tackle_chance = 70 //Should not be above 100%
	psychiccost = 32
	ventcrawler = 0
	mob_size = MOB_SIZE_LARGE
	custom_pixel_x_offset = -16
	//class = 3

/mob/living/carbon/alien/humanoid/hivelord/New()
	internal_organs += new /obj/item/organ/internal/alien/plasmavessel/hivelord
	internal_organs += new /obj/item/organ/internal/alien/resinspinner
	internal_organs += new /obj/item/organ/internal/alien/acid

	//var/datum/reagents/R = new/datum/reagents(100)
	//reagents = R
	//R.my_atom = src
	//if(src.name == "alien hivelord")
	//	src.name = text("alien hivelord ([rand(1, 1000)])")
	//src.real_name = src.name
	//verbs -= /mob/living/carbon/alien/verb/ventcrawl

	//verbs.Add(/mob/living/carbon/alien/humanoid/proc/resin,/mob/living/carbon/alien/humanoid/proc/corrosive_acid)
	//var/matrix/M = matrix()
	//M.Scale(0.9,0.9)
	//src.transform = M
	//pixel_x = -16
	
	..()

/mob/living/carbon/alien/humanoid/hivelord/handle_hud_icons_health()
	if (healths)
		if (stat != 2)
			switch(health)
				if(320 to INFINITY)
					healths.icon_state = "health0"
				if(256 to 320)
					healths.icon_state = "health1"
				if(192 to 256)
					healths.icon_state = "health2"
				if(128 to 192)
					healths.icon_state = "health3"
				if(64 to 128)
					healths.icon_state = "health4"
				if(0 to 64)
					healths.icon_state = "health5"
				else
					healths.icon_state = "health6"
		else
			healths.icon_state = "health7"

//Why did i put resin doors in hivelord??? Need to move code below somewhere else later... ~Zve

/obj/structure/mineral_door/resin
	icon_state = "resin"
	layer = 3.2
	mineralType = "resin"
	hardness = 200
	close_delay = 100

	openSound = null //Moar stealth ~Zve
	closeSound = null

/obj/structure/mineral_door/resin/Dismantle(devastated = 0)
	qdel(src)

/obj/structure/mineral_door/resin/Bumped(atom/user)
	if(!state)
		return TryToSwitchState(user)

/obj/structure/mineral_door/resin/TryToSwitchState(mob/living/carbon/alien/A)
	if(isSwitchingStates) return
	if(istype(A))
		if(A.client)
			SwitchState()

/obj/structure/mineral_door/resin/attackby(obj/item/weapon/W, mob/user, params)
	user.changeNext_move(CLICK_CD_MELEE)
	if(istype(W))
		hardness -= W.force/2
		playsound(loc, 'sound/effects/attackblob.ogg', 100, 1)
		CheckHardness()
		user.do_attack_animation(src)
		if(W && !(W.flags&NOBLUDGEON))
			visible_message("<span class='danger'>[user] has hit [src] with [W]!</span>")
	else if(isalien(user))
		attack_alien(user)

/obj/structure/mineral_door/resin/attack_ai(mob/user)
	if(isAI(user))
		return
	else if(isrobot(user))
		return

/obj/structure/mineral_door/resin/attack_alien(mob/user)
	if(user.a_intent == "harm")
		user.changeNext_move(CLICK_CD_MELEE)
		user.do_attack_animation(src)
		if(islarva(user))//Safety check for larva. /N
			return
		user.visible_message("<span class='danger'>[user] claws at the resin!</span>")
		playsound(loc, 'sound/effects/attackblob.ogg', 100, 1)
		hardness -= rand(40, 60)
		if(hardness <= 0)
			user.visible_message("<span class='danger'>[user] slices the [name] to pieces!</span>")
		CheckHardness()
	else
		return TryToSwitchState(user)

/obj/structure/mineral_door/ex_act(severity = 1)
	switch(severity)
		if(1)
			Dismantle()
		if(2)
			if(prob(20))
				Dismantle()
			else
				hardness -= rand(100,200)
				CheckHardness()
		if(3)
			hardness -= rand(50,125)
			CheckHardness()
	return

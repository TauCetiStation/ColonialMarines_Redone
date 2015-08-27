/mob/living/carbon/alien/humanoid/hivelord
	name = "alien hivelord"
	caste = "Hivelord"
	maxHealth = 320
	health = 320
	icon = 'icons/Xeno/2x2_Xenos.dmi'
	icon_state = "Hivelord Walking"
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

//hivelords use the same base as generic humanoids.
//hivelord verbs

/obj/structure/mineral_door/resin
	icon_state = "resin"
	mineralType = "resin"
	hardness = 200
	close_delay = 100

	openSound = 'sound/effects/attackblob.ogg'
	closeSound = 'sound/effects/attackblob.ogg'

/obj/structure/mineral_door/resin/Dismantle(devastated = 0)
	qdel(src)

/obj/structure/mineral_door/resin/Bumped(atom/user)
	..()
	if(isalien(user))
		if(!state)
			return TryToSwitchState(user)
	return

/obj/structure/mineral_door/resin/attackby(obj/item/weapon/W, mob/user, params)
	if(istype(W,/obj/item/weapon)) //not sure, can't not just weapons get passed to this proc?
		hardness -= W.force/2
		user << "<span class='danger'>You hit the [name] with your [W.name]!</span>"
		CheckHardness()
	else
		attack_hand(user)
	return

/obj/structure/mineral_door/resin/bullet_act(obj/item/projectile/Proj)
	hardness -= Proj.damage
	..()
	CheckHardness()
	return

/obj/structure/mineral_door/resin/attack_ai(mob/user) //those aren't machinery, they're just big fucking slabs of a mineral
	if(isAI(user)) //so the AI can't open it
		return
	else if(isrobot(user)) //but cyborgs can
		return

/obj/structure/mineral_door/resin/attack_paw(mob/user)
	if(!isalien(user)) return
	return TryToSwitchState(user)

/obj/structure/mineral_door/resin/attack_hand(mob/user)
	if(!isalien(user)) return
	return TryToSwitchState(user)

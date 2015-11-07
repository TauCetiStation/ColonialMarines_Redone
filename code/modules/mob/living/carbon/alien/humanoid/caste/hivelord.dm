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
	ventcrawler = 0
	mob_size = MOB_SIZE_LARGE
	custom_pixel_x_offset = -16

/mob/living/carbon/alien/humanoid/hivelord/New()
	internal_organs += new /obj/item/organ/internal/alien/plasmavessel/hivelord
	internal_organs += new /obj/item/organ/internal/alien/resinspinner
	internal_organs += new /obj/item/organ/internal/alien/acid_weak
	internal_organs += new /obj/item/organ/internal/alien/carapace

	..()

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

/obj/structure/mineral_door/resin/ex_act(severity = 1)
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

/mob/living/carbon/alien/humanoid/hivelord/ClickOn(var/atom/A, params)
	face_atom(A)
	var/list/modifiers = params2list(params)
	if(modifiers["alt"])
		if(isobj(A) && !src.stat && A.Adjacent(src))
			if(istype(A, /obj/structure/alien/resin/wall) || istype(A, /obj/structure/alien/resin/membrane))
				if(x_stats.d_hivelord_reinf)
					var/obj/structure/alien/resin/W = A
					if(W.can_reinforce())
						if(getPlasma() >= 750)
							if(do_after(src, 150, target = W))
								if(getPlasma() >= 750)
									src.adjustPlasma(-750)
									new /obj/structure/alien/weeds(W.loc)
									if(istype(W, /obj/structure/alien/resin/wall))
										new /obj/structure/alien/resin/wall/reinforced(W.loc)
									else if(istype(W, /obj/structure/alien/resin/membrane))
										new /obj/structure/alien/resin/membrane/reinforced(W.loc)
									qdel(W)
						else
							src << {"<span class='noticealien'>We need 750 plasma to reinforce [W.name].</span>"}
						return
	..()

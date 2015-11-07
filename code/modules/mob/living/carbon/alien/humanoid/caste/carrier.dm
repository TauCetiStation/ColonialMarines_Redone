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
	ventcrawler = 0
	custom_pixel_y_offset = 3

/mob/living/carbon/alien/humanoid/carrier/New()
	internal_organs += new /obj/item/organ/internal/alien/plasmavessel/carrier
	internal_organs += new /obj/item/organ/internal/alien/carapace

	AddAbility(new/obj/effect/proc_holder/alien/evolve_next(null))

	var/matrix/M = matrix()
	M.Scale(1.1,1.15)
	src.transform = M
	..()

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

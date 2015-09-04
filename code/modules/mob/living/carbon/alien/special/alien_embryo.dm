// This is to replace the previous datum/disease/alien_embryo for slightly improved handling and maintainability
// It functions almost identically (see code/datums/diseases/alien_embryo.dm)
var/const/ALIEN_AFK_BRACKET = 450 // 45 seconds

/obj/item/organ/internal/body_egg/alien_embryo
	name = "alien embryo"
	icon = 'icons/mob/alien.dmi'
	icon_state = "larva0_dead"
	var/stage = 0
	var/stage_age = 0

/obj/item/organ/internal/body_egg/alien_embryo/on_find(mob/living/finder)
	..()
	if(stage < 4)
		finder << "It's small and weak, barely the size of a foetus."
	else
		finder << "It's grown quite large, and writhes slightly as you look at it."
		if(prob(10))
			AttemptGrow()

/obj/item/organ/internal/body_egg/alien_embryo/prepare_eat()
	var/obj/S = ..()
	S.reagents.add_reagent("sacid", 10)
	return S

/obj/item/organ/internal/body_egg/alien_embryo/on_life()
	stage_age++
	if(stage < 5 && stage_age > 60)
		stage++
		stage_age = 0
		spawn(0)
			RefreshInfectionImage()

	switch(stage)
		if(2, 3)
			if(prob(2))
				owner.emote("sneeze")
			if(prob(2))
				owner.emote("cough")
			if(prob(2))
				owner << "<span class='danger'>Your throat feels sore.</span>"
			if(prob(2))
				owner << "<span class='danger'>Mucous runs down the back of your throat.</span>"
		if(4)
			if(prob(2))
				owner.emote("sneeze")
			if(prob(2))
				owner.emote("cough")
			if(prob(4))
				owner << "<span class='danger'>Your muscles ache.</span>"
				if(prob(20))
					owner.take_organ_damage(1)
			if(prob(4))
				owner << "<span class='danger'>Your stomach hurts.</span>"
				if(prob(20))
					owner.adjustToxLoss(1)
		if(5)
			owner << "<span class='danger'>You feel something tearing its way out of your stomach...</span>"
			owner.adjustToxLoss(2)
			AttemptGrow()
			stage = 6
			if(prob(70))
				owner.adjustBruteLoss(5)
		if(6)
			stage = 4
			stage_age = 57

/obj/item/organ/internal/body_egg/alien_embryo/proc/AttemptGrow()
	if(!owner) return
	var/list/candidates = get_candidates(BE_ALIEN, ALIEN_AFK_BRACKET)
	var/client/C = null

	// To stop clientless larva, we will check that our host has a client
	// if we find no ghosts to become the alien. If the host has a client
	// he will become the alien but if he doesn't then we will set the stage
	// to 4, so we don't do a process heavy check everytime.

	if(candidates.len)
		C = pick(candidates)
	else if(owner.client)
		C = owner.client
	else
		stage = 4 // Let's try again later.
		stage_age = 35
		return

	spawn(6)
		owner.death()
		owner.birth = 1

		var/atom/xeno_loc = owner
		xeno_loc = get_turf(xeno_loc)

		var/mob/living/carbon/alien/larva/new_xeno = new(xeno_loc)
		new_xeno.key = C.key
		new_xeno << sound('sound/voice/hiss5.ogg',0,0,0,100)	//To get the player's attention

		if(ishuman(owner))
			score_marines_chestbursted++

		owner.visible_message("<span class='userdanger'>[new_xeno] crawls out of [owner]!</span>")
		owner.overlays += image('icons/mob/alien.dmi', loc = owner, icon_state = "bursted_lie")

		qdel(src)


/*----------------------------------------
Proc: AddInfectionImages(C)
Des: Adds the infection image to all aliens for this embryo
----------------------------------------*/
/obj/item/organ/internal/body_egg/alien_embryo/AddInfectionImages()
	for(var/mob/living/carbon/alien/alien in player_list)
		if(alien.client)
			var/I = image('icons/mob/alien.dmi', loc = owner, icon_state = "infected[stage]")
			alien.client.images += I

/*----------------------------------------
Proc: RemoveInfectionImage(C)
Des: Removes all images from the mob infected by this embryo
----------------------------------------*/
/obj/item/organ/internal/body_egg/alien_embryo/RemoveInfectionImages()
	for(var/mob/living/carbon/alien/alien in player_list)
		if(alien.client)
			for(var/image/I in alien.client.images)
				if(dd_hasprefix_case(I.icon_state, "infected") && I.loc == owner)
					qdel(I)

/mob/living/carbon/alien/humanoid/drone
	name = "alien drone"
	caste = "Drone"
	maxHealth = 170
	health = 170
	icon_state = "Drone Walking"

	damagemin = 12
	damagemax = 16
	tacklemin = 2
	tacklemax = 3 //old max 5
	tackle_chance = 40 //Should not be above 100% old chance 50

/mob/living/carbon/alien/humanoid/drone/New()
	src.frozen = 1
	spawn (25)
		src.frozen = 0

	var/matrix/M = matrix()
	M.Scale(0.9,0.9)
	src.transform = M

	internal_organs += new /obj/item/organ/internal/alien/plasmavessel/drone
	internal_organs += new /obj/item/organ/internal/alien/resinspinner
	internal_organs += new /obj/item/organ/internal/alien/acid_weak
	internal_organs += new /obj/item/organ/internal/alien/carapace

	AddAbility(new/obj/effect/proc_holder/alien/evolve(null))
	AddAbility(new/obj/effect/proc_holder/alien/evolve_next(null))
	..()

/obj/effect/proc_holder/alien/evolve
	name = "Evolve (Queen)"
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

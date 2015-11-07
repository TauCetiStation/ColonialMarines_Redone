/mob/living/carbon/alien/humanoid/digger
	name = "alien digger"
	caste = "Digger"
	maxHealth = 200
	health = 200
	icon_state = "Digger Walking"

	damagemin = 25
	damagemax = 35
	tacklemin = 3
	tacklemax = 4
	tackle_chance = 60 //Should not be above 100% old chance 50

/mob/living/carbon/alien/humanoid/digger/New()
	src.frozen = 1
	spawn (25)
		src.frozen = 0

	internal_organs += new /obj/item/organ/internal/alien/plasmavessel/drone
	internal_organs += new /obj/item/organ/internal/alien/resinspinner
	internal_organs += new /obj/item/organ/internal/alien/acid_weak
	internal_organs += new /obj/item/organ/internal/alien/carapace
	internal_organs += new /obj/item/organ/internal/alien/digger

	AddAbility(new/obj/effect/proc_holder/alien/evolve_next(null))

	..()

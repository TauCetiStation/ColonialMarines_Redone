/mob/living/carbon/alien/humanoid/sentinel
	name = "alien sentinel"
	caste = "Sentinel"
	maxHealth = 200
	health = 200
	icon_state = "Sentinel Walking"

	damagemin = 18
	damagemax = 24
	tacklemin = 2
	tacklemax = 4
	tackle_chance = 50 //Should not be above 100%

/mob/living/carbon/alien/humanoid/sentinel/New()
	src.frozen = 1
	spawn (25)
		src.frozen = 0

	internal_organs += new /obj/item/organ/internal/alien/plasmavessel/sentinel
	internal_organs += new /obj/item/organ/internal/alien/acid
	internal_organs += new /obj/item/organ/internal/alien/carapace

	AddAbility(new/obj/effect/proc_holder/alien/unweld_vent(null))
	AddAbility(new/obj/effect/proc_holder/alien/evolve_next(null))
	..()

//Aimable Spit *********************************************************
/mob/living/carbon/alien/humanoid/sentinel/ClickOn(var/atom/A, params)
	face_atom(A)
	var/list/modifiers = params2list(params)
	if(modifiers["shift"])
		spit_neuro_aim(A, 1)
		return
	..()

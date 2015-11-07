//ALIEN PRAETORIAN - UPDATED 30MAY2015 - APOPHIS
/mob/living/carbon/alien/humanoid/praetorian
	name = "alien praetorian"
	caste = "Praetorian"
	maxHealth = 400
	health = 400
	icon_state = "Praetorian Walking"
	icon = 'icons/Xeno/2x2_Xenos.dmi'
	damagemin = 40
	damagemax = 45
	tacklemin = 3
	tacklemax = 5
	tackle_chance = 70 //Should not be above 100%
	ventcrawler = 0
	mob_size = MOB_SIZE_LARGE
	custom_pixel_x_offset = -16

/mob/living/carbon/alien/humanoid/praetorian/New()
	internal_organs += new /obj/item/organ/internal/alien/plasmavessel/praetorian
	internal_organs += new /obj/item/organ/internal/alien/acid_strong
	internal_organs += new /obj/item/organ/internal/alien/carapace
	AddAbility(new/obj/effect/proc_holder/alien/unweld_vent(null))
	..()

//Aimable Spit *********************************************************
/mob/living/carbon/alien/humanoid/praetorian/ClickOn(var/atom/A, params)
	face_atom(A)
	var/list/modifiers = params2list(params)
	if(modifiers["shift"])
		spit_neuro_aim(A, 2)
		return
	..()

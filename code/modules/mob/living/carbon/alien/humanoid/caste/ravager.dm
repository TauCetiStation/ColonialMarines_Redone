/mob/living/carbon/alien/humanoid/ravager
	name = "alien ravager"
	caste = "Ravager"
	maxHealth = 500
	health = 500
	icon_state = "Ravager Walking"
	icon = 'icons/Xeno/2x2_Xenos.dmi'

	damagemin = 50
	damagemax = 75
	tacklemin = 4
	tacklemax = 7
	tackle_chance = 90 //Should not be above 100%
	ventcrawler = 0
	mob_size = MOB_SIZE_LARGE
	custom_pixel_x_offset = -18

	var/speed_bonus = 0

/mob/living/carbon/alien/humanoid/ravager/New()
	internal_organs += new /obj/item/organ/internal/alien/plasmavessel/ravager
	internal_organs += new /obj/item/organ/internal/alien/carapace
	AddAbility(new/obj/effect/proc_holder/alien/rav_roar(null))

	var/matrix/M = matrix()
	M.Scale(1.15,1.15)
	src.transform = M
	..()

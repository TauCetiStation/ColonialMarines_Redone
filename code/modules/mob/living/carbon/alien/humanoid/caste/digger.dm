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
	psychiccost = 30

/mob/living/carbon/alien/humanoid/digger/New()
	src.frozen = 1
	spawn (25)
		src.frozen = 0

	internal_organs += new /obj/item/organ/internal/alien/plasmavessel/drone
	internal_organs += new /obj/item/organ/internal/alien/resinspinner
	internal_organs += new /obj/item/organ/internal/alien/acid
	internal_organs += new /obj/item/organ/internal/alien/carapace/small
	internal_organs += new /obj/item/organ/internal/alien/digger

	..()

/mob/living/carbon/alien/humanoid/digger/handle_hud_icons_health()
	if (healths)
		if (stat != 2)
			switch(health)
				if(200 to INFINITY)
					healths.icon_state = "health0"
				if(160 to 200)
					healths.icon_state = "health1"
				if(120 to 160)
					healths.icon_state = "health2"
				if(80 to 120)
					healths.icon_state = "health3"
				if(40 to 80)
					healths.icon_state = "health4"
				if(0 to 40)
					healths.icon_state = "health5"
				else
					healths.icon_state = "health6"
		else
			healths.icon_state = "health7"

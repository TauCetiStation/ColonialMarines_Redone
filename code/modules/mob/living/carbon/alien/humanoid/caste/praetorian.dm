//ALIEN PRAETORIAN - UPDATED 30MAY2015 - APOPHIS
/mob/living/carbon/alien/humanoid/praetorian
	name = "alien praetorian"
	caste = "Accurate Praetorian"
	maxHealth = 400
	health = 400
	icon_state = "Praetorian Walking"
	icon = 'icons/Xeno/2x2_Xenos.dmi'
	var/progress = 0
	var/progressmax = 500
	damagemin = 40
	damagemax = 45
	tacklemin = 3
	tacklemax = 5
	tackle_chance = 70 //Should not be above 100%
	psychiccost = 16
	ventcrawler = 0
	mob_size = MOB_SIZE_LARGE
	custom_pixel_x_offset = -16
	//class = 3

/*
/mob/living/carbon/alien/humanoid/praetorian/Stat()
	..()
	stat(null, "Progress: [progress]/[progressmax]")

/mob/living/carbon/alien/humanoid/praetorian/adjustToxLoss(amount)
	if(stat != DEAD)
		progress = min(progress + 1, progressmax)
	..(amount)
*/


/mob/living/carbon/alien/humanoid/praetorian/New()
	internal_organs += new /obj/item/organ/internal/alien/plasmavessel/preatorian
	internal_organs += new /obj/item/organ/internal/alien/acid
	internal_organs += new /obj/item/organ/internal/alien/acid_strong
	internal_organs += new /obj/item/organ/internal/alien/neurotoxin
	//var/datum/reagents/R = new/datum/reagents(100)
	//reagents = R
	//R.my_atom = src
	//if(name == "alien praetorian")
	//	name = text("alien praetorian ([rand(1, 1000)])")
	//real_name = name
	//verbs.Add(/mob/living/carbon/alien/humanoid/proc/corrosive_acid_super,
	///mob/living/carbon/alien/humanoid/proc/corrosive_acid,
	///mob/living/carbon/alien/humanoid/proc/neurotoxin,
	///mob/living/carbon/alien/humanoid/proc/super_neurotoxin,
	///mob/living/carbon/alien/humanoid/proc/quickspit)

	//verbs -= /mob/living/carbon/alien/verb/ventcrawl
	//verbs -= /mob/living/carbon/alien/humanoid/verb/plant
	//var/matrix/M = matrix()
	//M.Scale(1.2,1.3)
	//src.transform = M
	//pixel_x = -16
	..()

/mob/living/carbon/alien/humanoid/preatorian/handle_hud_icons_health()
	if (healths)
		if (stat != 2)
			switch(health)
				if(400 to INFINITY)
					healths.icon_state = "health0"
				if(320 to 400)
					healths.icon_state = "health1"
				if(240 to 320)
					healths.icon_state = "health2"
				if(160 to 240)
					healths.icon_state = "health3"
				if(80 to 160)
					healths.icon_state = "health4"
				if(0 to 80)
					healths.icon_state = "health5"
				else
					healths.icon_state = "health6"
		else
			healths.icon_state = "health7"

//Aimable Spit *********************************************************
/mob/living/carbon/alien/humanoid/praetorian/ClickOn(var/atom/A, params)

	var/list/modifiers = params2list(params)
	if(modifiers["shift"])
		spit_neuro_aim(A, 2)

		return
	..()

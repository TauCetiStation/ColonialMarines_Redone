/obj/item/organ/internal/alien
	origin_tech = "biotech=5"
	icon = 'icons/effects/blood.dmi'
	icon_state = "xgibmid2"
	var/list/alien_powers = list()

/obj/item/organ/internal/alien/New()
	for(var/A in alien_powers)
		if(ispath(A))
			alien_powers -= A
			alien_powers += new A(src)
	..()

/obj/item/organ/internal/alien/Insert(mob/living/carbon/M, special = 0)
	..()
	for(var/obj/effect/proc_holder/alien/P in alien_powers)
		M.AddAbility(P)


/obj/item/organ/internal/alien/Remove(mob/living/carbon/M, special = 0)
	for(var/obj/effect/proc_holder/alien/P in alien_powers)
		M.RemoveAbility(P)
	..()

/obj/item/organ/internal/alien/prepare_eat()
	var/obj/S = ..()
	S.reagents.add_reagent("sacid", 10)
	return S


/obj/item/organ/internal/alien/plasmavessel
	name = "plasma vessel"
	origin_tech = "biotech=5;plasma=2"
	w_class = 3
	zone = "chest"
	slot = "plasmavessel"
	alien_powers = list(/obj/effect/proc_holder/alien/plant, /obj/effect/proc_holder/alien/transfer)

	var/storedPlasma = 0
	var/max_plasma = 250
	var/heal_rate = 5
	var/plasma_rate = 10

	var/transfer_plasma_amount = 0

	var/delay = 0

/obj/item/organ/internal/alien/plasmavessel/prepare_eat()
	var/obj/S = ..()
	S.reagents.add_reagent("plasma", storedPlasma/10)
	return S

/obj/item/organ/internal/alien/plasmavessel/larva
	max_plasma = 5
	plasma_rate = 1
	w_class = 1
	alien_powers = list(/obj/effect/proc_holder/alien/transfer)

/obj/item/organ/internal/alien/plasmavessel/carrier
	w_class = 2

/obj/item/organ/internal/alien/plasmavessel/corroder
	w_class = 2
	alien_powers = list(/obj/effect/proc_holder/alien/transfer)

/obj/item/organ/internal/alien/plasmavessel/drone
	w_class = 2

/obj/item/organ/internal/alien/plasmavessel/hivelord
	name = "large plasma vessel"
	w_class = 4

/obj/item/organ/internal/alien/plasmavessel/hunter
	w_class = 2
	alien_powers = list(/obj/effect/proc_holder/alien/transfer)

/obj/item/organ/internal/alien/plasmavessel/praetorian
	w_class = 3
	alien_powers = list(/obj/effect/proc_holder/alien/transfer)

/obj/item/organ/internal/alien/plasmavessel/ravager
	w_class = 3
	alien_powers = list(/obj/effect/proc_holder/alien/transfer)

/obj/item/organ/internal/alien/plasmavessel/crusher
	w_class = 3
	alien_powers = list(/obj/effect/proc_holder/alien/transfer)

/obj/item/organ/internal/alien/plasmavessel/runner
	w_class = 2
	alien_powers = list(/obj/effect/proc_holder/alien/transfer)

/obj/item/organ/internal/alien/plasmavessel/sentinel
	w_class = 2
	alien_powers = list(/obj/effect/proc_holder/alien/transfer)

/obj/item/organ/internal/alien/plasmavessel/spitter
	w_class = 2
	alien_powers = list(/obj/effect/proc_holder/alien/transfer)

/obj/item/organ/internal/alien/plasmavessel/queen
	name = "large plasma vessel"
	w_class = 4
	max_plasma = 700
	plasma_rate = 20

/obj/item/organ/internal/alien/plasmavessel/on_life()
	//If there are alien weeds on the ground then heal if needed or give some plasma
	if(locate(/obj/structure/alien/weeds) in owner.loc)
		if(istype(src, /obj/item/organ/internal/alien/plasmavessel/crusher))
			owner.adjustPlasma(plasma_rate)
			regenerate_health()
		else
			if(owner.health >= owner.maxHealth - owner.getCloneLoss())
				owner.adjustPlasma(plasma_rate)
			else
				var/mod = 1
				if(!isalien(owner))
					mod = 0.2
				regenerate_health(mod)
	else if(isalien(owner) && x_stats.h_acc_regen > 0)
		regenerate_health(x_stats.h_acc_regen)

/obj/item/organ/internal/alien/plasmavessel/proc/regenerate_health(mod = 1)
	delay--
	if(delay <= 0)
		delay = x_stats.h_regen
		owner.adjustBruteLoss(-(heal_rate+x_stats.h_adv_regen)*mod)
		owner.adjustFireLoss(-(heal_rate+x_stats.h_adv_regen)*mod)
		owner.adjustOxyLoss(-(heal_rate+x_stats.h_adv_regen)*mod)

/obj/item/organ/internal/alien/plasmavessel/Insert(mob/living/carbon/M, special = 0)
	..()
	if(isalien(M))
		var/mob/living/carbon/alien/A = M
		A.updatePlasmaDisplay()

/obj/item/organ/internal/alien/plasmavessel/Remove(mob/living/carbon/M, special = 0)
	..()
	if(isalien(M))
		var/mob/living/carbon/alien/A = M
		A.updatePlasmaDisplay()


/obj/item/organ/internal/alien/hivenode
	name = "hive node"
	zone = "head"
	slot = "hivenode"
	origin_tech = "biotech=5;magnets=4;bluespace=3"
	w_class = 1
	alien_powers = list(/obj/effect/proc_holder/alien/whisper)
	var/toxin_power = 0

/obj/item/organ/internal/alien/hivenode/Insert(mob/living/carbon/M, special = 0)
	..()
	M.faction |= "alien"

/obj/item/organ/internal/alien/hivenode/Remove(mob/living/carbon/M, special = 0)
	M.faction -= "alien"
	..()

/obj/item/organ/internal/alien/hivenode/on_life()
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		toxin_power++
		var/tox_dmg = 2 + (toxin_power/100)
		H.adjustToxLoss(tox_dmg)


/obj/item/organ/internal/alien/resinspinner
	name = "resin spinner"
	zone = "mouth"
	slot = "resinspinner"
	origin_tech = "biotech=5;materials=4"
	alien_powers = list(/obj/effect/proc_holder/alien/resin)

/obj/item/organ/internal/alien/acid
	name = "acid gland"
	zone = "mouth"
	slot = "acidgland"
	origin_tech = "biotech=5;materials=2;combat=2"
	alien_powers = list(/obj/effect/proc_holder/alien/acid)

/obj/item/organ/internal/alien/acid_strong
	name = "weird acid gland"
	zone = "mouth"
	slot = "acidgland"
	origin_tech = "biotech=5;materials=2;combat=2"
	alien_powers = list(/obj/effect/proc_holder/alien/acid_strong)

/obj/item/organ/internal/alien/acid_weak
	name = "strange acid gland"
	zone = "mouth"
	slot = "acidgland"
	origin_tech = "biotech=5;materials=2;combat=2"
	alien_powers = list(/obj/effect/proc_holder/alien/acid_weak)

/obj/item/organ/internal/alien/eggsac
	name = "egg sac"
	zone = "groin"
	slot = "eggsac"
	w_class = 4
	origin_tech = "biotech=8"
	alien_powers = list(/obj/effect/proc_holder/alien/lay_egg)

/*/obj/item/organ/internal/alien/royalsac
	name = "egg sac"
	zone = "groin"
	slot = "royalsac"
	w_class = 4
	origin_tech = "biotech=8"
	alien_powers = list(/obj/effect/proc_holder/alien/lay_jelly)*/

/obj/item/organ/internal/alien/screechcord
	name = "vocal cord"
	zone = "mouth"
	slot = "gland"
	origin_tech = "biotech=5;materials=4"
	alien_powers = list(/obj/effect/proc_holder/alien/screech)

/obj/item/organ/internal/alien/carapace
	name = "carapace"
	zone = "chest"
	slot = "armor"
	var/reduction = 20
	var/maxHealth = 200
	var/health = 200

/obj/item/organ/internal/alien/carapace/New()
	maxHealth = x_stats.h_carapace
	..()

/obj/item/organ/internal/alien/carapace/huge
	reduction = 70

/obj/item/organ/internal/alien/carapace/crusher
	zone = "head"
	reduction = 0
	maxHealth = 0
	health = 0
	alien_powers = list(/obj/effect/proc_holder/alien/crusher_def)

/obj/item/organ/internal/alien/digger
	name = "armored claws"
	zone = "l_hand"
	slot = "claws"
	origin_tech = "biotech=5;materials=4"
	alien_powers = list(/obj/effect/proc_holder/alien/dig)

/obj/item/organ/internal/alien/crusher
	name = "armored claws"
	zone = "l_leg"
	slot = "claws"
	origin_tech = "biotech=5;materials=4"
	alien_powers = list(/obj/effect/proc_holder/alien/crush)

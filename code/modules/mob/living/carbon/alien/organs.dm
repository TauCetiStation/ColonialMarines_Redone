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

	var/storedPlasma = 100
	var/max_plasma = 250
	var/heal_rate = 5
	var/plasma_rate = 10

/obj/item/organ/internal/alien/plasmavessel/prepare_eat()
	var/obj/S = ..()
	S.reagents.add_reagent("plasma", storedPlasma/10)
	return S

/obj/item/organ/internal/alien/plasmavessel/larva
	name = "tiny plasma vessel"
	w_class = 1
	storedPlasma = 50
	max_plasma = 50
	alien_powers = list(/obj/effect/proc_holder/alien/transfer)

/obj/item/organ/internal/alien/plasmavessel/carrier
	name = "plasma vessel"
	w_class = 2
	storedPlasma = 50
	max_plasma = 250
	heal_rate = 2
	plasma_rate = 5

/obj/item/organ/internal/alien/plasmavessel/corroder
	name = "plasma vessel"
	w_class = 2
	storedPlasma = 80
	max_plasma = 150
	heal_rate = 2
	plasma_rate = 18

/obj/item/organ/internal/alien/plasmavessel/drone
	name = "plasma vessel"
	w_class = 2
	storedPlasma = 350
	max_plasma = 750
	heal_rate = 8
	plasma_rate = 13

/obj/item/organ/internal/alien/plasmavessel/hivelord
	name = "large plasma vessel"
	w_class = 4
	storedPlasma = 100
	max_plasma = 1000
	heal_rate = 6
	plasma_rate = 50

/obj/item/organ/internal/alien/plasmavessel/hunter
	name = "plasma vessel"
	w_class = 2
	storedPlasma = 100
	max_plasma = 150
	heal_rate = 4
	plasma_rate = 8
	alien_powers = list(/obj/effect/proc_holder/alien/transfer)

/obj/item/organ/internal/alien/plasmavessel/preatorian
	name = "plasma vessel"
	w_class = 3
	storedPlasma = 0
	max_plasma = 600
	heal_rate = 5
	plasma_rate = 10
	alien_powers = list(/obj/effect/proc_holder/alien/transfer)

/obj/item/organ/internal/alien/plasmavessel/ravager
	name = "plasma vessel"
	w_class = 3
	storedPlasma = 50
	max_plasma = 50
	heal_rate = 5
	plasma_rate = 6
	alien_powers = list(/obj/effect/proc_holder/alien/transfer)

/obj/item/organ/internal/alien/plasmavessel/runner
	name = "plasma vessel"
	w_class = 2
	storedPlasma = 50
	max_plasma = 100
	heal_rate = 4
	plasma_rate = 5
	alien_powers = list(/obj/effect/proc_holder/alien/transfer)

/obj/item/organ/internal/alien/plasmavessel/sentinel
	name = "plasma vessel"
	w_class = 2
	storedPlasma = 75
	max_plasma = 300
	heal_rate = 6
	plasma_rate = 7
	alien_powers = list(/obj/effect/proc_holder/alien/transfer)

/obj/item/organ/internal/alien/plasmavessel/spitter
	name = "plasma vessel"
	w_class = 2
	storedPlasma = 150
	max_plasma = 600
	heal_rate = 3
	plasma_rate = 30
	alien_powers = list(/obj/effect/proc_holder/alien/transfer)

/obj/item/organ/internal/alien/plasmavessel/queen
	name = "large plasma vessel"
	w_class = 4
	storedPlasma = 300
	max_plasma = 700
	plasma_rate = 20

/obj/item/organ/internal/alien/plasmavessel/on_life()
	//If there are alien weeds on the ground then heal if needed or give some plasma
	if(locate(/obj/structure/alien/weeds) in owner.loc)
		if(owner.health >= owner.maxHealth - owner.getCloneLoss())
			owner.adjustPlasma(plasma_rate)
		else
			var/mod = 1
			if(!isalien(owner))
				mod = 0.2
			owner.adjustBruteLoss(-heal_rate*mod)
			owner.adjustFireLoss(-heal_rate*mod)
			owner.adjustOxyLoss(-heal_rate*mod)

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

/obj/item/organ/internal/alien/hivenode/Insert(mob/living/carbon/M, special = 0)
	..()
	M.faction |= "alien"

/obj/item/organ/internal/alien/hivenode/Remove(mob/living/carbon/M, special = 0)
	M.faction -= "alien"
	..()


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

/obj/item/organ/internal/alien/acid_launcher
	name = "large acid gland"
	zone = "mouth"
	slot = "acidgland"
	origin_tech = "biotech=5;materials=2;combat=2"
	alien_powers = list(/obj/effect/proc_holder/alien/acid_launcher)

/obj/item/organ/internal/alien/neurotoxin
	name = "neurotoxin gland"
	zone = "mouth"
	slot = "neurotoxingland"
	origin_tech = "biotech=5;combat=5"
	alien_powers = list(/obj/effect/proc_holder/alien/neurotoxin)

/obj/item/organ/internal/alien/neurotoxin_weak
	name = "small neurotoxin gland"
	zone = "mouth"
	slot = "smallneurotoxingland"
	origin_tech = "biotech=5;combat=5"
	alien_powers = list(/obj/effect/proc_holder/alien/neurotoxin_weak)

/obj/item/organ/internal/alien/eggsac
	name = "egg sac"
	zone = "groin"
	slot = "eggsac"
	w_class = 4
	origin_tech = "biotech=8"
	alien_powers = list(/obj/effect/proc_holder/alien/lay_egg)

/obj/item/organ/internal/alien/royalsac
	name = "egg sac"
	zone = "groin"
	slot = "royalsac"
	w_class = 4
	origin_tech = "biotech=8"
	alien_powers = list(/obj/effect/proc_holder/alien/lay_jelly)
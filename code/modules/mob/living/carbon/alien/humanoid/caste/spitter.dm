/mob/living/carbon/alien/humanoid/spitter
	name = "alien spitter"
	caste = "Spitter"
	maxHealth = 300
	health = 300
	icon_state = "Spitter Walking"
	damagemin = 20
	damagemax = 26
	tacklemin = 2
	tacklemax = 3
	tackle_chance = 75 //Should not be above 100%

/mob/living/carbon/alien/humanoid/spitter/New()
	internal_organs += new /obj/item/organ/internal/alien/plasmavessel/spitter
	internal_organs += new /obj/item/organ/internal/alien/acid
	internal_organs += new /obj/item/organ/internal/alien/carapace
	AddAbility(new/obj/effect/proc_holder/alien/unweld_vent(null))
	AddAbility(new/obj/effect/proc_holder/alien/evolve_next(null))

	src.frozen = 1
	spawn (50)
		src.frozen = 0
	..()

//Aimable Spit *********************************************************

/mob/living/carbon/alien/humanoid/spitter/ClickOn(var/atom/A, params)
	face_atom(A)
	var/list/modifiers = params2list(params)
	if(modifiers["shift"])
		spit_neuro_aim(A, 1)
		return
	..()

/mob/living/carbon/alien/humanoid/proc/spit_neuro_aim(var/atom/T, var/power = 1)
	if(!T) return

	if(!isturf(loc))
		src << "\red Can spit only from a turf!"
		return

	if(src.getPlasma() > 75)
		if(usedspit <= world.time)
			usedspit = world.time + SPITCOOLDOWN * 15

			src.adjustPlasma(-75)
			var/turf/curloc = get_turf(get_step(src, dir))
			var/turf/targloc = get_turf(T)

			var/obj/item/projectile/bullet/A
			switch(power)
				if(1)
					A = new /obj/item/projectile/bullet/neurotoxin_weak(curloc)
				if(2)
					A = new /obj/item/projectile/bullet/neurotoxin(curloc)
			A.original = targloc
			A.current = curloc
			A.starting = curloc
			A.yo = targloc.y - curloc.y
			A.xo = targloc.x - curloc.x
			A.fire()
		else
			src << "\red You need to wait before spitting!"
	else
		src << "\red You need more plasma."

//END AIMABLE SPIT *****************************************
//ALIEN RUNNER - UPDATED 11APR2015 - APOPHIS
/mob/living/carbon/alien/humanoid/runner
	name = "alien scout"
	caste = "Runner"
	maxHealth = 100
	health = 100
	icon_state = "Runner Walking"

	damagemin = 23
	damagemax = 28
	tacklemin = 1
	tacklemax = 3
	tackle_chance = 70 //Should not be above 100%
	var/usedparasite = 0

/mob/living/carbon/alien/humanoid/runner/New()
	internal_organs += new /obj/item/organ/internal/alien/plasmavessel/runner
	AddAbility(new/obj/effect/proc_holder/alien/evolve_next(null))

	src.frozen = 1
	spawn (25)
		src.frozen = 0

	..()

//Parasite Spit *********************************************************
/mob/living/carbon/alien/humanoid/runner/ClickOn(var/atom/A, params)
	face_atom(A)
	if(x_stats.w_parasite)
		var/list/modifiers = params2list(params)
		if(modifiers["shift"])
			spit_parasite(A)
			return
	..()

/mob/living/carbon/alien/humanoid/runner/proc/spit_parasite(var/atom/T)
	if(!T) return

	if(usedparasite > world.time)
		src << "<span class='noticealien'>We must wait a bit.. New parasite not ready..</span>"
		return

	if(!isturf(loc))
		src << "\red Can spit only from a turf!"
		return

	usedparasite = world.time + 100

	var/turf/curloc = get_turf(get_step(src, dir))
	var/turf/targloc = get_turf(T)

	var/obj/item/projectile/bullet/A
	A = new /obj/item/projectile/bullet/parasite(curloc)
	A.original = targloc
	A.current = curloc
	A.starting = curloc
	A.yo = targloc.y - curloc.y
	A.xo = targloc.x - curloc.x
	A.fire()

//Stops runners from pulling APOPHIS775 03JAN2015
//mob/living/carbon/alien/humanoid/runner/start_pulling(var/atom/movable/AM)
//	src << "<span class='warning'>You don't have the dexterity to pull anything.</span>"
//	return

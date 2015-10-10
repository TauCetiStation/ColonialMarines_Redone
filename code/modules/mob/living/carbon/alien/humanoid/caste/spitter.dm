//ALIEN SPITTER - UPDATED 30MAY2015 - APOPHIS
/mob/living/carbon/alien/humanoid/spitter
	name = "alien spitter"
	caste = "Spitter"
	maxHealth = 300
	health = 300
	icon_state = "Spitter Walking"
	var/progress = 0
	var/hasJelly = 1
	var/progressmax = 900
	damagemin = 20
	damagemax = 26
	tacklemin = 2
	tacklemax = 3
	tackle_chance = 75 //Should not be above 100% old was 65
	psychiccost = 25
	//class = 2

	Stat()
		..()
		stat(null, "Jelly Progress: [progress]/[progressmax]")
	proc/growJelly()
		spawn while(1)
			if(hasJelly)
				if(progress < progressmax)
					progress = min(progress + 1, progressmax)
			sleep(10)
	proc/canEvolve()
		if(!hasJelly)
			return 0
		if(progress < progressmax)
			return 0
		return 1


/mob/living/carbon/alien/humanoid/spitter/New()
	internal_organs += new /obj/item/organ/internal/alien/plasmavessel/spitter
	internal_organs += new /obj/item/organ/internal/alien/acid
	internal_organs += new /obj/item/organ/internal/alien/neurotoxin
	internal_organs += new /obj/item/organ/internal/alien/carapace/small
	//var/datum/reagents/R = new/datum/reagents(100)
	src.frozen = 1
	spawn (50)
		src.frozen = 0
	//reagents = R
	//R.my_atom = src
	//if(name == "alien spitter")
	//	name = text("alien spitter ([rand(1, 1000)])")
	//real_name = name
	//verbs.Add(/mob/living/carbon/alien/humanoid/proc/weak_neurotoxin,
	//mob/living/carbon/alien/humanoid/proc/neurotoxin,
	//mob/living/carbon/alien/humanoid/proc/weak_acid,
	//mob/living/carbon/alien/humanoid/proc/corrosive_acid,
	//mob/living/carbon/alien/humanoid/proc/quickspit)
	//verbs -= /mob/living/carbon/alien/humanoid/verb/plant
	//var/matrix/M = matrix()
	//M.Scale(1.15,1.1)
	//src.transform = M
	//pixel_y = 3
	growJelly()
	..()

/mob/living/carbon/alien/humanoid/spitter/handle_hud_icons_health()
	if (healths)
		if (stat != 2)
			switch(health)
				if(300 to INFINITY)
					healths.icon_state = "health0"
				if(240 to 300)
					healths.icon_state = "health1"
				if(180 to 240)
					healths.icon_state = "health2"
				if(120 to 180)
					healths.icon_state = "health3"
				if(60 to 120)
					healths.icon_state = "health4"
				if(0 to 60)
					healths.icon_state = "health5"
				else
					healths.icon_state = "health6"
		else
			healths.icon_state = "health7"

/mob/living/carbon/alien/humanoid/spitter/verb/evolve() // -- TLE
	set name = "Evolve (Jelly)"
	set desc = "Evolve into a Praetorian"
	set category = "Alien"
	if(!hivemind_check(psychiccost))
		src << "\red Your queen's psychic strength is not powerful enough for you to evolve further."
		return
	if(!canEvolve())
		if(hasJelly)
			src << "You are not ready to evolve yet"
		else
			src << "You need a mature royal jelly to evolve"
		return
	if(src.stat != CONSCIOUS)
		src << "You are unable to do that now."
		return
	src << "\blue <b>You are growing into a Praetorian!</b>"

	var/mob/living/carbon/alien/humanoid/new_xeno

	new_xeno = new /mob/living/carbon/alien/humanoid/praetorian(loc)
	src << "\green You begin to evolve!"

	for(var/mob/O in viewers(src, null))
		O.show_message(text("\green <B>[src] begins to twist and contort!</B>"), 1)
	if(mind)	mind.transfer_to(new_xeno)

	del(src)


	return



//Aimable Spit *********************************************************

/mob/living/carbon/alien/humanoid/spitter/ClickOn(var/atom/A, params)
	face_atom(A)
	var/list/modifiers = params2list(params)
	if(modifiers["shift"])
		spit_neuro_aim(A, 2)
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
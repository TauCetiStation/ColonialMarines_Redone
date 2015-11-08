/obj/effect/proc_holder/alien/hide
	name = "Hide"
	desc = "Allows to hide beneath tables or certain items. Toggled on or off."
	plasma_cost = 0

	action_icon_state = "alien_hide"

/obj/effect/proc_holder/alien/hide/fire(mob/living/carbon/alien/user)
	if(user.stat != CONSCIOUS)
		return

	if (user.layer != TURF_LAYER+0.46)
		user.layer = TURF_LAYER+0.46
		user.visible_message("<span class='name'>[user] scurries to the ground!</span>", \
						"<span class='noticealien'>You are now hiding.</span>")
	else
		user.layer = MOB_LAYER
		user.visible_message("[user.] slowly peaks up from the ground...", \
					"<span class='noticealien'>You stop hiding.</span>")
	return 1


/obj/effect/proc_holder/alien/larva_evolve
	name = "Evolve"
	desc = "Evolve into a fully grown Alien."
	plasma_cost = 0

	action_icon_state = "alien_evolve_larva"

/obj/effect/proc_holder/alien/larva_evolve/fire(mob/living/carbon/alien/user)
	if(!islarva(user))
		return
	var/mob/living/carbon/alien/larva/L = user

	if(L.stat != CONSCIOUS)
		return
	if(L.handcuffed || L.legcuffed) // Cuffing larvas ? Eh ?
		user << "<span class='danger'>You cannot evolve when you are cuffed.</span>"

	if(L.amount_grown >= L.max_grown)	//TODO ~Carn
		L << "<span class='name'>You are growing into a beautiful alien! It is time to choose a caste.</span>"
		L << "<span class='info'>There are three to choose from:"
		L << "<span class='name'>Runners</span> <span class='info'>are fast and agile, able to hunt away from the hive and rapidly move through ventilation shafts as well as pounce of their prey.  The Evolve into Warriors, then Ravagers.</span>"
		L << "<span class='name'>Sentinels</span> <span class='info'>are tasked with protecting the hive and are deadly up close and at a range. They are not as physically imposing nor fast as the warriors.  They Evolve into Spitters, then Praetorians.</span>"
		L << "<span class='name'>Drones</span> <span class='info'>are the working class, offering the largest plasma storage and generation. They evolve into either the Queen, a Hivelord which specializes in building, or a Carrier, which specializes in support.</span>"
		var/alien_caste = alert(L, "Please choose which alien caste you shall belong to.",,"Runner","Sentinel","Drone")

		var/fail = 1
		var/mob/living/carbon/alien/humanoid/new_xeno
		switch(alien_caste)
			if("Runner")
				for(var/mob/living/carbon/alien/humanoid/drone/D in living_mob_list)
					if(D && D.client)
						fail = 0
						break
				if(fail)
					user << "<span class='danger'>We need a potential queeen first. Become a drone or ask someone else to take that role.</span>"
					return 0
				new_xeno = new /mob/living/carbon/alien/humanoid/runner(L.loc)
			if("Sentinel")
				for(var/mob/living/carbon/alien/humanoid/drone/D in living_mob_list)
					if(D && D.client)
						fail = 0
						break
				if(fail)
					user << "<span class='danger'>We need a potential queeen first. Become a drone or ask someone else to take that role.</span>"
					return 0
				new_xeno = new /mob/living/carbon/alien/humanoid/sentinel(L.loc)
			if("Drone")
				new_xeno = new /mob/living/carbon/alien/humanoid/drone(L.loc)
		if(L.mind)	L.mind.transfer_to(new_xeno)
		qdel(L)
		return 0
	else
		user << "<span class='danger'>You are not fully grown.</span>"
		return 0

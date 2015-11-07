/mob/living/carbon/alien/humanoid
	name = "alien"
	icon_state = "Sentinal Walking"
	var/obj/item/r_store = null
	var/obj/item/l_store = null
	var/caste = ""
	var/alt_icon = 'icons/mob/alienleap.dmi' //used to switch between the two alien icon files.
	var/leap_on_click = 0
	var/pounce_cooldown = 0
	var/pounce_cooldown_time = 100
	var/custom_pixel_x_offset = 0 //for admin fuckery.
	var/custom_pixel_y_offset = 0
	var/evolving = 0

	var/damagemin = 10
	var/damagemax = 19

	var/tacklemin = 3
	var/tacklemax = 5
	var/tackle_chance = 100 //Should not be above 100%

	var/SPITCOOLDOWN = 10
	var/usedspit = 0

//This is fine right now, if we're adding organ specific damage this needs to be updated
/mob/living/carbon/alien/humanoid/New()
	update_stats()

	//AddAbility(new/obj/effect/proc_holder/alien/regurgitate(null))
	..()

/mob/living/carbon/alien/humanoid/proc/update_stats(alive=0)
	var/datum/xeno_stats/XS = x_stats.FindCaste(caste)
	if(XS)
		maxHealth = XS.max_health["base"]
		if(!alive)
			health = XS.max_health["base"]
		var/obj/item/organ/internal/alien/carapace/Armor = getorgan(/obj/item/organ/internal/alien/carapace)
		if(Armor)
			Armor.reduction = XS.armor["base"]
		var/obj/item/organ/internal/alien/plasmavessel/PV = getorgan(/obj/item/organ/internal/alien/plasmavessel)
		if(PV)
			PV.heal_rate = XS.heal_rate["base"]
			PV.max_plasma = XS.max_plasma["base"]
			PV.plasma_rate = XS.plasma_rate["base"]
		damagemin = XS.damage_min["base"]
		damagemax = XS.damage_max["base"]
		tacklemin = XS.tackle_min["base"]
		tacklemax = XS.tackle_max["base"]
		tackle_chance = XS.tackle_chance["base"]

/mob/living/carbon/alien/humanoid/getarmor(def_zone, type)
	var/obj/item/organ/internal/alien/carapace/armor = getorgan(/obj/item/organ/internal/alien/carapace)
	if(armor && armor.health > 0)
		return armor.reduction

	return 0

/mob/living/carbon/alien/humanoid/bullet_act(var/obj/item/projectile/Proj, def_zone)
	var/obj/item/organ/internal/alien/carapace/armor = getorgan(/obj/item/organ/internal/alien/carapace)
	if(armor && Proj.damage)
		armor.health = max(0, armor.health - (Proj.damage/3))
	..()

/mob/living/carbon/alien/humanoid/emp_act(severity)
	if(r_store) r_store.emp_act(severity)
	if(l_store) l_store.emp_act(severity)
	..()

/mob/living/carbon/alien/humanoid/attack_hulk(mob/living/carbon/human/user)
	if(user.a_intent == "harm")
		..(user, 1)
		adjustBruteLoss(14 + rand(1,9))
		Paralyse(1)
		step_away(src,user,15)
		sleep(1)
		step_away(src,user,15)
		return 1

/mob/living/carbon/alien/humanoid/attack_hand(mob/living/carbon/human/M)
	if(..())
		switch(M.a_intent)
			if ("harm")
				var/damage = rand(1, 9)
				if (prob(90))
					playsound(loc, "punch", 25, 1, -1)
					visible_message("<span class='danger'>[M] has punched [src]!</span>", \
							"<span class='userdanger'>[M] has punched [src]!</span>")
					if ((stat != DEAD) && (damage > 9 || prob(5)))//Regular humans have a very small chance of weakening an alien.
						Paralyse(2)
						visible_message("<span class='danger'>[M] has weakened [src]!</span>", \
								"<span class='userdanger'>[M] has weakened [src]!</span>")
					adjustBruteLoss(damage)
					add_logs(M, src, "attacked")
					updatehealth()
				else
					playsound(loc, 'sound/weapons/punchmiss.ogg', 25, 1, -1)
					visible_message("<span class='danger'>[M] has attempted to punch [src]!</span>")

			if ("disarm")
				if (!lying)
					if (prob(5))
						Paralyse(2)
						playsound(loc, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)
						add_logs(M, src, "pushed")
						visible_message("<span class='danger'>[M] has pushed down [src]!</span>", \
							"<span class='userdanger'>[M] has pushed down [src]!</span>")
					else
						if (prob(50))
							drop_item()
							playsound(loc, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)
							visible_message("<span class='danger'>[M] has disarmed [src]!</span>", \
							"<span class='userdanger'>[M] has disarmed [src]!</span>")
						else
							playsound(loc, 'sound/weapons/punchmiss.ogg', 25, 1, -1)
							visible_message("<span class='danger'>[M] has attempted to disarm [src]!</span>")

/mob/living/carbon/alien/humanoid/restrained()
	if (handcuffed)
		return 1
	return 0


/mob/living/carbon/alien/humanoid/show_inv(mob/user)
	user.set_machine(src)
	var/dat = {"
	<HR>
	<B><FONT size=3>[name]</FONT></B>
	<HR>
	<BR><B>Left Hand:</B> <A href='?src=\ref[src];item=[slot_l_hand]'>		[l_hand		? l_hand	: "Nothing"]</A>
	<BR><B>Right Hand:</B> <A href='?src=\ref[src];item=[slot_r_hand]'>		[r_hand		? r_hand	: "Nothing"]</A>
	<BR><A href='?src=\ref[src];pouches=1'>Empty Pouches</A>"}

	if(handcuffed)
		dat += "<BR><A href='?src=\ref[src];item=[slot_handcuffed]'>Handcuffed</A>"
	if(legcuffed)
		dat += "<BR><A href='?src=\ref[src];item=[slot_legcuffed]'>Legcuffed</A>"

	dat += {"
	<BR>
	<BR><A href='?src=\ref[user];mach_close=mob\ref[src]'>Close</A>
	"}
	user << browse(dat, "window=mob\ref[src];size=325x500")
	onclose(user, "mob\ref[src]")


/mob/living/carbon/alien/humanoid/Topic(href, href_list)
	..()
	//strip panel
	if(usr.canUseTopic(src, BE_CLOSE, NO_DEXTERY))
		if(href_list["pouches"])
			visible_message("<span class='danger'>[usr] tries to empty [src]'s pouches.</span>", \
							"<span class='userdanger'>[usr] tries to empty [src]'s pouches.</span>")
			if(do_mob(usr, src, POCKET_STRIP_DELAY * 0.5))
				unEquip(r_store)
				unEquip(l_store)

/mob/living/carbon/alien/humanoid/cuff_resist(obj/item/I)
	playsound(src, 'sound/voice/hiss5.ogg', 40, 1, 1)  //Alien roars when starting to break free
	..(I, cuff_break = 1)

/mob/living/carbon/alien/humanoid/get_standard_pixel_y_offset(lying = 0)
	if(leaping)
		return -32
	else if(custom_pixel_y_offset)
		return custom_pixel_y_offset
	else
		return initial(pixel_y)

/mob/living/carbon/alien/humanoid/get_standard_pixel_x_offset(lying = 0)
	if(leaping)
		return -32
	else if(custom_pixel_x_offset)
		return custom_pixel_x_offset
	else
		return initial(pixel_x)

/mob/living/carbon/alien/humanoid/check_ear_prot()
	return 1

/mob/living/carbon/alien/humanoid/get_permeability_protection()
	return 0.8

/mob/living/carbon/alien/humanoid/proc/get_evolve_choices()
	switch(caste)
		if("Drone")
			return list("Digger")
		if("Digger")
			return list("Carrier","Hivelord")
		if("Sentinel")
			return list("Spitter")
		if("Spitter")
			return list("Corroder","Praetorian")
		if("Runner")
			return list("Hunter")
		if("Hunter")
			return list("Crusher","Ravager")
		else
			return list("No choice")

/mob/living/carbon/alien/humanoid/proc/get_evolve_cost(caste)
	switch(caste)
		if("Digger","Spitter","Hunter")
			return 20
		if("Carrier","Corroder","Crusher")
			return 40
		if("Hivelord","Praetorian","Ravager")
			return 50

/mob/living/carbon/alien/humanoid/proc/check_current_caste(caste, chosen_caste)
	switch(chosen_caste)
		if("Carrier","Hivelord")
			if(caste == "Digger")
				return 1
		if("Digger")
			if(caste == "Drone")
				return 1
		if("Spitter")
			if(caste == "Sentinel")
				return 1
		if("Corroder","Praetorian")
			if(caste == "Spitter")
				return 1
		if("Hunter")
			if(caste == "Runner")
				return 1
		if("Crusher","Ravager")
			if(caste == "Hunter")
				return 1
	return 0

/mob/living/carbon/alien/humanoid/proc/is_lifeform_avail(mob/user, caste)
	switch(caste)
		if("Digger")
			if(x_stats.d_digger)
				return 1
		if("Carrier")
			if(x_stats.d_carrier)
				return 1
		if("Hivelord")
			if(x_stats.d_hivelord)
				return 1
		if("Spitter")
			if(x_stats.s_spitter)
				return 1
		if("Corroder")
			if(x_stats.s_corroder)
				return 1
		if("Praetorian")
			if(x_stats.s_praetorian)
				return 1
		if("Hunter")
			if(x_stats.w_hunter)
				return 1
		if("Crusher")
			if(x_stats.w_crusher)
				return 1
		if("Ravager")
			if(x_stats.w_ravager)
				return 1
	user << "<span class='noticealien'>[caste] lifeform is unavailable. Queen may open it.</span>"
	return 0

/mob/living/carbon/alien/humanoid/proc/do_evolve(new_caste)
	if(evolving) return
	anchored = 1
	evolving = 1

	src << "\green You begin to evolve!"
	visible_message("<span class='noticealien'>[src] begins to twist and contort!</span>")

	var/timer = 1200

	if(we_inside_hive(src))
		switch(x_stats.q_declare_hive_level)
			if(1)
				timer -= 600
			if(2)
				timer -= 900
		src << "<span class='noticealien'><b>This is our home</b> evolution in effect. (Process shortened to [timer/10] seconds!)</span>"
	timer += world.time
	spawn()
		while(src && evolving && stat != DEAD && timer > world.time)
			sleeping = 999
			sleep(10)

		if(stat == DEAD)
			return

		var/mob/living/carbon/alien/humanoid/new_xeno
		switch(new_caste)
			if("Digger")
				new_xeno = new /mob/living/carbon/alien/humanoid/digger(loc)
			if("Carrier")
				new_xeno = new /mob/living/carbon/alien/humanoid/carrier(loc)
			if("Hivelord")
				new_xeno = new /mob/living/carbon/alien/humanoid/hivelord(loc)
			if("Spitter")
				new_xeno = new /mob/living/carbon/alien/humanoid/spitter(loc)
			if("Corroder")
				new_xeno = new /mob/living/carbon/alien/humanoid/corroder(loc)
			if("Praetorian")
				new_xeno = new /mob/living/carbon/alien/humanoid/praetorian(loc)
			if("Hunter")
				new_xeno = new /mob/living/carbon/alien/humanoid/hunter(loc)
			if("Crusher")
				new_xeno = new /mob/living/carbon/alien/humanoid/crusher(loc)
			if("Ravager")
				new_xeno = new /mob/living/carbon/alien/humanoid/ravager(loc)
		if(new_xeno)
			if(mind)
				mind.transfer_to(new_xeno)
			new_xeno << sound('sound/voice/hiss5.ogg',0,0,0,100)
			qdel(src)

/proc/we_inside_hive(mob/user)
	if(x_stats.hive_1)
		var/turf/T = x_stats.hive_1
		if(T.z == user.z && get_dist(user, T) <= 10)
			return 1

	if(x_stats.hive_2)
		var/turf/T = x_stats.hive_2
		if(T.z == user.z && get_dist(user, T) <= 10)
			return 1
	return 0

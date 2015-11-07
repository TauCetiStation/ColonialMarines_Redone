/mob/living/carbon/alien/humanoid/queen
	name = "alien queen"
	caste = "Queen"
	maxHealth = 700
	health = 700
	icon = 'icons/Xeno/2x2_Xenos.dmi'
	icon_state = "Queen Running"
	status_flags = CANPARALYSE
	ventcrawler = 0 //pull over that ass too fat
	unique_name = 0
	custom_pixel_x_offset = -16
	mob_size = MOB_SIZE_LARGE
	damagemin = 30
	damagemax = 35
	tacklemin = 3
	tacklemax = 7
	tackle_chance = 90 //Should not be above 100%


/mob/living/carbon/alien/humanoid/queen/New()
	//there should only be one queen
	for(var/mob/living/carbon/alien/humanoid/queen/Q in living_mob_list)
		if(Q == src)		continue
		if(Q.stat == DEAD)	continue
		if(Q.client)
			name = "alien princess ([rand(1, 999)])"	//if this is too cutesy feel free to change it/remove it.
			break

	real_name = src.name

	internal_organs += new /obj/item/organ/internal/alien/plasmavessel/queen
	internal_organs += new /obj/item/organ/internal/alien/resinspinner
	internal_organs += new /obj/item/organ/internal/alien/acid_weak
	//internal_organs += new /obj/item/organ/internal/alien/neurotoxin
	internal_organs += new /obj/item/organ/internal/alien/eggsac
	//internal_organs += new /obj/item/organ/internal/alien/royalsac
	if(x_stats.q_screech)
		internal_organs += new /obj/item/organ/internal/alien/screechcord
	if(x_stats.q_xeno_canharm_ability)
		AddAbility(new/obj/effect/proc_holder/alien/order_to_harm(null))
	if(x_stats.q_declare_hive_level)
		AddAbility(new/obj/effect/proc_holder/alien/declare_hive(null))
	internal_organs += new /obj/item/organ/internal/alien/carapace/huge

	hive_controller.active_queen = src

	..()

//Queen verbs
/obj/effect/proc_holder/alien/lay_egg
	name = "Lay Egg"
	desc = "Lay an egg to produce huggers to impregnate prey with."
	plasma_cost = 100
	check_turf = 1
	action_icon_state = "alien_egg"

/obj/effect/proc_holder/alien/lay_egg/fire(mob/living/carbon/user)
	if(build_lay_fail(user))
		return 0
	if(!x_stats.hive_1)
		user << "<span class='noticealien'>We need a hive first.</span>"
		return 0
	if(locate(/obj/structure/alien/weeds) in get_turf(user))
		var/fail = 1

		if(x_stats.hive_1)
			var/turf/T = x_stats.hive_1
			if(T.z == user.z && get_dist(user, T) <= 10)
				fail = 0

		if(x_stats.hive_2)
			var/turf/T = x_stats.hive_2
			if(T.z == user.z && get_dist(user, T) <= 10)
				fail = 0

		if(!fail)
			user.visible_message("<span class='alertalien'>[user] has laid an egg!</span>")
			score_eggs_made++
			new /obj/structure/alien/egg(user.loc)
			return 1
		else
			user << "<span class='noticealien'>We are too far away from a hive.</span>"
			return 0
	else
		user << "<span class='noticealien'>We can only lay eggs on the weed.</span>"
		return 0

/*
/mob/living/carbon/alien/humanoid/queen/large
	icon = 'icons/Xeno/3x3 Xenos.dmi'
	icon_state = "Accurate Empress"
	mob_size = MOB_SIZE_LARGE

/mob/living/carbon/alien/humanoid/queen/large/update_icons()
	update_hud()		//TODO: remove the need for this to be here
	overlays.Cut()
	if(stat == DEAD)
		icon_state = "queen_dead"
	else if((stat == UNCONSCIOUS && !sleeping) || weakened)
		icon_state = "queen_l"
	else if(sleeping || lying || resting)
		icon_state = "queen_sleep"
	else
		icon_state = "queen_s"
	for(var/image/I in overlays_standing)
		overlays += I*/

/*
/obj/effect/proc_holder/alien/lay_jelly
	name = "Produce Royal Jelly"
	desc = "Produce a sac of fluid which furthers the evolution of the hive."
	plasma_cost = 350
	check_turf = 1
	action_icon_state = "jelly"

/obj/effect/proc_holder/alien/lay_jelly/fire(mob/living/carbon/user)
	if(build_lay_fail(user))
		return 0
	user.visible_message("<span class='alertalien'>[user] has shaped a sac and filled it with a greenish fluid!</span>")
	new /obj/royaljelly(user.loc)
	return 1*/

mob/living/carbon/alien/humanoid/queen/death(gibbed)
	..()

	queen_died = world.timeofday + 6000

/mob/living/carbon/alien/Stat()
	..()
	stat(null, "Hivemind Strength: [hive_controller.psychicstrengthused]/[hive_controller.psychicstrength]")

/datum/hive_controller
	var/mob/living/carbon/alien/humanoid/queen/active_queen
	var/psychicstrength = 5
	var/psychicstrengthmax = 500
	var/psychicstrengthused = 0
	var/list/mob/living/carbon/alien/xenos = list()
	var/count = 0

	New()
		process_controller()

	proc/process_controller()
		spawn while(1)
			count += 1
			if(count >= 3 && active_queen && psychicstrength < psychicstrengthmax)
				psychicstrength += 1
				count = 0
			if(istype(active_queen))
				if(active_queen.stat == DEAD)
					psychicstrength = round(psychicstrength / 2)
					active_queen = null
			sleep(40)

/var/global/datum/hive_controller/hive_controller = new()


/*
/mob/living/carbon/alien/New()
	..()
	if(hive_controller)
		hive_controller.psychicstrengthused += src.psychiccost / 2

/mob/living/carbon/alien/Destroy()
	if(hive_controller)
		hive_controller.psychicstrengthused -= src.psychiccost / 2
	..()*/


/mob/living/carbon/alien/death(gibbed)
	..(gibbed)
	//if(hive_controller)
	//	hive_controller.psychicstrengthused -= src.psychiccost / 4

	for(var/mob/living/carbon/alien/A in living_mob_list)
		//A << "\red <font size=3><b>[name] has died! You feel the strength of your hivemind decrease.</b></font>"
		A << "\red <font size=3><b>[name] has died!</b></font>"

var/respawn_count[0]

/obj/machinery/respawn_pod
	name = "Respawn Pod"
	icon = 'icons/obj/cloning.dmi'
	icon_state = "pod_0"
	density = 1
	anchored = 1
	var/timer = 0
	var/client_timer = 180
	var/mob/dead/observer/who_spawn
	use_power = 0
	var/hardness = 100

/obj/machinery/respawn_pod/Destroy()
	if(who_spawn)
		who_spawn << "<span class='boldnotice'>Respawn process has been interrupted!</span>"
		who_spawn.loc = get_turf(loc)
		who_spawn.respawn_point = null
	..()

/obj/machinery/respawn_pod/update_icon()
	if(who_spawn)
		icon_state = "pod_1"
	else
		icon_state = "pod_0"

/obj/machinery/respawn_pod/process()
	update_icon()

	if(!who_spawn)
		src.reset()
		return

	if(!who_spawn.client)
		client_timer--
		if(client_timer <= 0)
			src.reset()
		return

	if(timer)
		if(world.time > timer)
			if(who_spawn)
				finish(who_spawn)
			src.reset()

/obj/machinery/respawn_pod/proc/reset()
	who_spawn = null
	timer = 0
	client_timer = 180

/obj/machinery/respawn_pod/proc/start(mob/dead/observer/O, penalty = 1)
	who_spawn = O

	penalty = penalty * 3000
	timer = world.time + penalty

/obj/machinery/respawn_pod/proc/finish(mob/dead/observer/O)
	var/mob/living/carbon/human/H = new /mob/living/carbon/human(get_turf(src))

	create_dna(H)

	O.client.prefs.random_character()
	O.client.prefs.real_name = O.client.prefs.pref_species.random_name(gender,1)
	O.client.prefs.copy_to(H)

	H.name = O.real_name

	ready_dna(H, O.client.prefs.blood_type)

	H.key = O.key

	SSjob.AssignRole(H, "Marine", 1)
	SSjob.EquipRank(H, "Marine", 1)

/obj/machinery/respawn_pod/ex_act(severity, target)
	return

/obj/machinery/respawn_pod/attack_alien(mob/living/carbon/alien/humanoid/M)
	if(M.a_intent == "harm")
		M.changeNext_move(CLICK_CD_MELEE)
		M.do_attack_animation(src)

		var/damage = rand(M.damagemin, M.damagemax)
		if(!damage)
			playsound(loc, 'sound/weapons/slashmiss.ogg', 50, 1, -1)
			return
		playsound(src, 'sound/weapons/smash.ogg', 50, 1)
		visible_message("<span class='danger'>[M] has slashed at [src]!</span>", \
			"<span class='userdanger'>[M] has slashed at [src]!</span>")
		hardness -= damage
		CheckHardness()

/obj/machinery/respawn_pod/proc/CheckHardness()
	if(hardness < 0)
		qdel(src)

/mob/dead/observer
	var/obj/machinery/respawn_pod/respawn_point = null

/mob/dead/observer/verb/respawn_as_marine()
	set name = "Respawn as Marine"
	set category = "Ghost"

	if(respawn_point)
		usr << "<span class='boldnotice'>Respawn in process... [round((respawn_point.timer - world.time)/10)] seconds left.</span>"
		return

	if ((stat != 2 || !( ticker )))
		usr << "<span class='boldnotice'>You must be dead to use this!</span>"
		return

	var/penalty = 1
	if(mind && mind.current)
		if(isalien(mind.current))
			usr << "<span class='noticealien'>Nope.avi</span>"
			return
		else if(!ishuman(mind.current))
			usr << "<span class='boldnotice'>Your previous body must be human type.</span>"
			return
		else if(ishuman(mind.current))
			for(var/X in respawn_count)
				if(X == "[ckey]")
					penalty = respawn_count[X]
					break
			var/response = alert(src, "Start respawn process?\n(It will take [penalty*5] minutes).","Start?","O","X")
			if(response != "O")	return
	else
		usr << "<span class='boldnotice'>There is no record about your previous body.</span>"
		return

	if(respawn_point)
		usr << "<span class='boldnotice'>Respawn in process...</span>"
		return

	log_game("[usr.name]/[usr.key] used respawn as marine.")

	if(!client)
		log_game("[usr.key] AM failed due to disconnect.")
		return

	var/found_spawn_point = 0
	for(var/obj/machinery/respawn_pod/RP in world)
		if(!RP.who_spawn)
			can_reenter_corpse = 0
			respawn_point = RP
			loc = get_turf(RP.loc)
			RP.start(usr, penalty)
			penalty++
			respawn_count["[ckey]"] = penalty
			found_spawn_point = 1
			break

	if(!found_spawn_point)
		usr << "<span class='boldnotice'>No spawn points available!</span>"

	return

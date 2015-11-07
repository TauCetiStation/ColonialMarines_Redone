/*NOTES:
These are general powers. Specific powers are stored under the appropriate alien creature type.
*/

/*Alien spit now works like a taser shot. It won't home in on the target but will act the same once it does hit.
Doesn't work on other aliens/AI.*/

/datum/action/spell_action/alien

/datum/action/spell_action/alien/UpdateName()
	var/obj/effect/proc_holder/alien/ab = target
	return ab.name

/datum/action/spell_action/alien/IsAvailable()
	if(!target)
		return 0
	var/obj/effect/proc_holder/alien/ab = target

	if(usr)
		return ab.cost_check(ab.check_turf,usr,1)
	else
		if(owner)
			return ab.cost_check(ab.check_turf,owner,1)
	return 1

/datum/action/spell_action/alien/CheckRemoval()
	if(!iscarbon(owner))
		return 1

	var/mob/living/carbon/C = owner
	if(target.loc && !(target.loc in C.internal_organs))
		return 1

	return 0


/obj/effect/proc_holder/alien
	name = "Alien Power"
	panel = "Alien"
	var/plasma_cost = 0
	var/check_turf = 0

	var/has_action = 1
	var/datum/action/spell_action/alien/action = null
	var/action_icon = 'icons/mob/actions.dmi'
	var/action_icon_state = "spell_default"
	var/action_background_icon_state = "bg_alien"

/obj/effect/proc_holder/alien/Click()
	if(!istype(usr,/mob/living/carbon))
		return 1
	var/mob/living/carbon/user = usr
	if(cost_check(check_turf,user))
		if(fire(user) && user) // Second check to prevent runtimes when evolving
			user.adjustPlasma(-plasma_cost)
	return 1

/obj/effect/proc_holder/alien/proc/on_gain(mob/living/carbon/user)
	return

/obj/effect/proc_holder/alien/proc/on_lose(mob/living/carbon/user)
	return

/obj/effect/proc_holder/alien/proc/fire(mob/living/carbon/user)
	return 1

/obj/effect/proc_holder/alien/proc/cost_check(check_turf=0,mob/living/carbon/user,silent = 0)
	if(user.stat)
		if(!silent)
			user << "<span class='noticealien'>You must be conscious to do this.</span>"
		return 0
	if(user.getPlasma() < plasma_cost)
		if(!silent)
			user << "<span class='noticealien'>Not enough plasma stored.</span>"
		return 0
	if(check_turf && (!isturf(user.loc) || istype(user.loc, /turf/space)))
		if(!silent)
			user << "<span class='noticealien'>Bad place for a garden!</span>"
		return 0
	return 1

/obj/effect/proc_holder/alien/proc/build_lay_fail(mob/living/carbon/user)
	if((locate(/obj/item/clothing/mask/facehugger) in get_turf(user)) || (locate(/obj/structure/alien/egg) in get_turf(user)) || (locate(/obj/structure/mineral_door/resin) in get_turf(user)) || (locate(/obj/structure/alien/resin/wall) in get_turf(user)) || (locate(/obj/structure/alien/resin/membrane) in get_turf(user)) || (locate(/obj/structure/stool/bed/nest) in get_turf(user)))
		user << "<span class='danger'>There is already a resin structure there.</span>"
		return 1
	else
		return 0

/obj/effect/proc_holder/alien/plant
	name = "Plant Weeds"
	desc = "Plants some alien weeds"
	plasma_cost = 0
	check_turf = 1
	action_icon_state = "alien_plant"
	var/cooldown = 0

/obj/effect/proc_holder/alien/plant/fire(mob/living/carbon/user)
	if(cooldown > world.time)
		user << "Can't plant weeds so often."
		return 0

	if(locate(/obj/structure/alien/weeds/node) in range(4,user))
		user << "There's already a weed node nearby."
		return 0

	cooldown = world.time + 150

	for(var/mob/O in viewers(user, null))
		O.show_message(text("<span class='alertalien'>[user] has planted some alien weeds!</span>"), 1)
	new/obj/structure/alien/weeds/node(user.loc)
	return 1

/obj/effect/proc_holder/alien/whisper
	name = "Whisper"
	desc = "Whisper to someone"
	plasma_cost = 10
	action_icon_state = "alien_whisper"

/obj/effect/proc_holder/alien/whisper/fire(mob/living/carbon/user)
	var/mob/living/M = input("Select who to whisper to:","Whisper to?",null) as mob in oview(user)
	if(!M)
		return 0
	var/msg = sanitize(input("Message:", "Alien Whisper") as text|null)
	if(msg)
		log_say("AlienWhisper: [key_name(user)]->[M.key] : [msg]")
		M << "<span class='noticealien'>You hear a strange, alien voice in your head...</span>[msg]"
		user << {"<span class='noticealien'>You said: "[msg]" to [M]</span>"}
	else
		return 0
	return 1

/obj/effect/proc_holder/alien/transfer
	name = "Adjust Amount of Transfered Plasma"
	desc = "Transfer Plasma to another xenomorph."
	plasma_cost = 0
	action_icon_state = "alien_transfer"

/obj/effect/proc_holder/alien/transfer/fire(mob/living/carbon/user)
	var/obj/item/organ/internal/alien/plasmavessel/PV = user.getorgan(/obj/item/organ/internal/alien/plasmavessel)
	if(PV)
		var/amount = input("Amount:", "Adjust amount of transfered plasma", "[PV.transfer_plasma_amount]") as num
		PV.transfer_plasma_amount = min(abs(round(amount)), 999)
		if(action && action.button)
			var/obj/screen/movable/action_button/AB = action.button
			AB.maptext = "<div align='center' valign='middle' style='position:relative; top:0px; left:6px'><font color='magenta'>[PV.transfer_plasma_amount]</font></div>"
		return

/obj/effect/proc_holder/alien/evo_menu
	name = "Evolution Menu"
	desc = "Open Evolution Menu."
	plasma_cost = 0
	action_icon_state = "evo_menu"

/obj/effect/proc_holder/alien/evo_menu/fire(mob/living/carbon/user)
	evolution_tree.show_tree(user)
	return

/obj/screen/movable/action_button/New()
	..()
	spawn(10)
		if(name == "Evolution Menu")
			update_evo_progress()

/obj/screen/movable/action_button/proc/update_evo_progress()
	spawn()
		while(src)
			maptext = "<div align='center' valign='middle' style='position:relative; top:0px; left:6px'><font color='magenta'>[evolution_tree.progress]</font></div>"
			sleep(20)

/obj/effect/proc_holder/alien/acid
	name = "Corrossive Acid"
	desc = "Drench an object in acid, destroying it over time."
	plasma_cost = 200
	action_icon_state = "alien_acid"

/obj/effect/proc_holder/alien/acid/on_gain(mob/living/carbon/user)
	user.verbs.Add(/mob/living/carbon/proc/corrosive_acid)

/obj/effect/proc_holder/alien/acid/on_lose(mob/living/carbon/user)
	user.verbs.Remove(/mob/living/carbon/proc/corrosive_acid)

/obj/effect/proc_holder/alien/acid/proc/corrode(target,mob/living/carbon/user = usr)
	if(target in oview(1,user))
		// OBJ CHECK
		if(isobj(target))
			var/obj/I = target
			if(I.unacidable)	//So the aliens don't destroy energy fields/singularies/other aliens/etc with their acid.
				user << "<span class='noticealien'>You cannot dissolve this object.</span>"
				return 0
		// TURF CHECK
		else if(istype(target, /turf/simulated))
			var/turf/T = target
			// R WALL
			if(istype(T, /turf/simulated/wall/r_wall))
				user << "<span class='noticealien'>You cannot dissolve this object.</span>"
				return 0
			// R FLOOR
			if(istype(T, /turf/simulated/floor/engine))
				user << "<span class='noticealien'>You cannot dissolve this object.</span>"
				return 0
		else// Not a type we can acid.
			return 0
		new /obj/effect/acid(get_turf(target), target)
		user.visible_message("<span class='alertalien'>[user] vomits globs of vile stuff all over [target]. It begins to sizzle and melt under the bubbling mess of acid!</span>")
		return 1
	else
		src << "<span class='noticealien'>Target is too far away.</span>"
		return 0


/obj/effect/proc_holder/alien/acid/fire(mob/living/carbon/alien/user)
	var/O = input("Select what to dissolve:","Dissolve",null) as obj|turf in oview(1,user)
	if(!O) return 0
	return corrode(O,user)

/mob/living/carbon/proc/corrosive_acid(O as obj|turf in oview(1)) // right click menu verb ugh
	set name = "Corrossive Acid"

	if(!iscarbon(usr))
		return
	var/mob/living/carbon/user = usr
	var/obj/effect/proc_holder/alien/acid/A = locate() in user.abilities
	if(!A) return
	if(user.getPlasma() > A.plasma_cost && A.corrode(O))
		user.adjustPlasma(-A.plasma_cost)

/obj/effect/proc_holder/alien/acid_strong
	name = "Strong Corrossive Acid"
	desc = "Drench an object in acid, destroying it over time."
	plasma_cost = 100
	action_icon_state = "alien_acid"

/obj/effect/proc_holder/alien/acid_strong/on_gain(mob/living/carbon/user)
	user.verbs.Add(/mob/living/carbon/proc/corrosive_acid_strong)

/obj/effect/proc_holder/alien/acid_strong/on_lose(mob/living/carbon/user)
	user.verbs.Remove(/mob/living/carbon/proc/corrosive_acid_strong)

/obj/effect/proc_holder/alien/acid_strong/proc/corrode(target,mob/living/carbon/user = usr)
	if(target in oview(1,user))
		// OBJ CHECK
		if(isobj(target))
			var/obj/I = target
			if(I.unacidable)	//So the aliens don't destroy energy fields/singularies/other aliens/etc with their acid.
				user << "<span class='noticealien'>You cannot dissolve this object.</span>"
				return 0
		// TURF CHECK
		else if(istype(target, /turf/simulated))
			var/turf/T = target
			// R FLOOR
			if(istype(T, /turf/simulated/floor/engine))
				user << "<span class='noticealien'>You cannot dissolve this object.</span>"
				return 0
		else// Not a type we can acid.
			return 0
		new /obj/effect/acid/strong(get_turf(target), target)
		user.visible_message("<span class='alertalien'>[user] vomits globs of vile stuff all over [target]. It begins to sizzle and melt under the bubbling mess of acid!</span>")
		return 1
	else
		src << "<span class='noticealien'>Target is too far away.</span>"
		return 0

/obj/effect/proc_holder/alien/acid_strong/fire(mob/living/carbon/alien/user)
	var/O = input("Select what to dissolve:","Dissolve",null) as obj|turf in oview(1,user)
	if(!O) return 0
	return corrode(O,user)

/mob/living/carbon/proc/corrosive_acid_strong(O as obj|turf in oview(1)) // right click menu verb ugh
	set name = "Strong Corrossive Acid"

	if(!iscarbon(usr))
		return
	var/mob/living/carbon/user = usr
	var/obj/effect/proc_holder/alien/acid_strong/A = locate() in user.abilities
	if(!A) return
	if(user.getPlasma() > A.plasma_cost && A.corrode(O))
		user.adjustPlasma(-A.plasma_cost)

/obj/effect/proc_holder/alien/acid_weak
	name = "Weak Corrossive Acid"
	desc = "Drench an object in acid, destroying it over time."
	plasma_cost = 500
	action_icon_state = "alien_acid"

/obj/effect/proc_holder/alien/acid_weak/on_gain(mob/living/carbon/user)
	user.verbs.Add(/mob/living/carbon/proc/corrosive_acid_weak)

/obj/effect/proc_holder/alien/acid_weak/on_lose(mob/living/carbon/user)
	user.verbs.Remove(/mob/living/carbon/proc/corrosive_acid_weak)

/obj/effect/proc_holder/alien/acid_weak/proc/corrode(target,mob/living/carbon/user = usr)
	if(target in oview(1,user))
		// OBJ CHECK
		if(isobj(target))
			var/obj/I = target
			if(I.unacidable)	//So the aliens don't destroy energy fields/singularies/other aliens/etc with their acid.
				user << "<span class='noticealien'>We cannot dissolve this object.</span>"
				return 0
		// TURF CHECK
		else if(istype(target, /turf/simulated))
			var/turf/T = target
			// R WALL
			if(istype(T, /turf/simulated/wall/r_wall))
				user << "<span class='noticealien'>We cannot dissolve this object.</span>"
				return 0
			// R FLOOR
			if(istype(T, /turf/simulated/floor/engine))
				user << "<span class='noticealien'>We cannot dissolve this object.</span>"
				return 0
		else// Not a type we can acid.
			return 0
		new /obj/effect/acid/weak(get_turf(target), target)
		user.visible_message("<span class='alertalien'>[user] vomits globs of vile stuff all over [target]. It begins to sizzle and melt under the bubbling mess of acid!</span>")
		return 1
	else
		src << "<span class='noticealien'>Target is too far away.</span>"
		return 0

/obj/effect/proc_holder/alien/acid_weak/fire(mob/living/carbon/alien/user)
	var/O = input("Select what to dissolve:","Dissolve",null) as obj|turf in oview(1,user)
	if(!O) return 0
	return corrode(O,user)

/mob/living/carbon/proc/corrosive_acid_weak(O as obj|turf in oview(1)) // right click menu verb ugh
	set name = "Weak Corrossive Acid"

	if(!iscarbon(usr))
		return
	var/mob/living/carbon/user = usr
	var/obj/effect/proc_holder/alien/acid_weak/A = locate() in user.abilities
	if(!A) return
	if(user.getPlasma() > A.plasma_cost && A.corrode(O))
		user.adjustPlasma(-A.plasma_cost)

/obj/effect/proc_holder/alien/resin
	name = "Secrete Resin"
	desc = "Secrete tough malleable resin."
	plasma_cost = 55
	check_turf = 1
	var/list/structures = list(
		"resin door" = /obj/structure/mineral_door/resin,
		"resin wall" = /obj/structure/alien/resin/wall,
		"resin membrane" = /obj/structure/alien/resin/membrane,
		"resin nest" = /obj/structure/stool/bed/nest)

	action_icon_state = "alien_resin"

/obj/effect/proc_holder/alien/resin/fire(mob/living/carbon/user)
	if(build_lay_fail(user))
		return 0
	var/choice = input("Choose what you wish to shape.","Resin building") as null|anything in structures
	if(!choice) return 0

	if(build_lay_fail(user))
		return 0

	if(!cost_check(check_turf,user))
		return 0

	user << "<span class='notice'>You shape a [choice].</span>"
	user.visible_message("<span class='notice'>[user] vomits up a thick purple substance and begins to shape it.</span>")

	choice = structures[choice]
	new choice(user.loc)
	return 1

/obj/effect/proc_holder/alien/regurgitate
	name = "Regurgitate"
	desc = "Empties the contents of your stomach"
	plasma_cost = 0
	action_icon_state = "alien_barf"

/obj/effect/proc_holder/alien/regurgitate/fire(mob/living/carbon/user)
	if(user.stomach_contents.len)
		for(var/atom/movable/A in user.stomach_contents)
			user.stomach_contents.Remove(A)
			A.loc = user.loc
			A.update_pipe_vision()
		user.visible_message("<span class='alertealien'>[user] hurls out the contents of their stomach!</span>")
	return

/obj/effect/proc_holder/alien/screech
	name = "Screech"
	desc = "Emit a screech that stuns prey."
	plasma_cost = 250
	action_icon_state = "alien_screech"
	var/usedscreech = 0

/obj/effect/proc_holder/alien/screech/fire(mob/living/carbon/user)
	if(usedscreech)
		user << "\red Our screech is not ready.."
		return 0
	usedscreech = 1
	for(var/mob/O in view())
		playsound(user.loc, 'sound/effects/screech2.ogg', 25, 1, -1)
		O << "\red [user] emits a paralyzing screech!"

	for (var/mob/living/carbon/human/M in oview())
		if(istype(M.ears, /obj/item/clothing/ears/earmuffs))
			continue
		if (get_dist(user.loc, M.loc) <= 4)
			M.stunned += 3
			M.drop_l_hand()
			M.drop_r_hand()
		else if(get_dist(user.loc, M.loc) >= 5)
			M.stunned += 2

	spawn(300)
		usedscreech = 0
	return 1

/obj/effect/proc_holder/alien/order_to_harm
	name = "Allow to harm"
	desc = "Allow or dissalow your xenos to harm hosts."
	plasma_cost = 0
	action_icon_state = "gib"
	var/usedorder = 0

/obj/effect/proc_holder/alien/order_to_harm/fire(mob/living/carbon/user)
	if(isqueen(user) && x_stats.q_xeno_canharm_ability)
		if(usedorder)
			user << "\red You may not use this ability so often.."
			return 0
		usedorder = 1
		spawn(100)
			usedorder = 0
		x_stats.q_xeno_canharm = !x_stats.q_xeno_canharm
		user << "\red Xenomorphs [x_stats.q_xeno_canharm ? "" : "no longer"] can harm any host."
	return 0

/obj/effect/proc_holder/alien/declare_hive
	name = "Declare Hive"
	desc = "Mark location around you as a hive location."
	plasma_cost = 0
	action_icon_state = "alien_hive"
	var/usedability = 0

/obj/effect/proc_holder/alien/declare_hive/fire(mob/living/carbon/user)
	if(isqueen(user))
		if(!x_stats.q_declare_hive_charge)
			user << "\red No charges left.."
			return 0

		if(usedability)
			user << "\red You may not use this ability so often.."
			return 0
		usedability = 1
		spawn(200)
			usedability = 0

		if(x_stats.hive_1 == null)
			if(do_mob(user, user, 100))
				x_stats.hive_1 = get_turf(user)

				x_stats.q_declare_hive_charge--
				return 1
		else if(x_stats.hive_2 == null)
			if(do_mob(user, user, 100))
				x_stats.hive_2 = get_turf(user)

				x_stats.q_declare_hive_charge--
				return 1
		else
			user << "\red You may not declare more hives. Limit has been reached."
			return 0

	return 0

/obj/effect/proc_holder/alien/unweld_vent
	name = "Corrode vent"
	desc = "Corrode vent"
	plasma_cost = 120
	action_icon_state = "alien_acidvent"

/obj/effect/proc_holder/alien/unweld_vent/fire(mob/living/carbon/user)
	var/list/unary_objects = list()
	for(var/obj/machinery/atmospherics/components/unary/U in oview(1, user))
		if(U.welded)
			if(istype(U, /obj/machinery/atmospherics/components/unary/vent_pump))
				unary_objects += U
			else if(istype(U, /obj/machinery/atmospherics/components/unary/vent_scrubber))
				unary_objects += U

	if(!unary_objects)
		return 0

	var/target = input("Select what to dissolve:","Dissolve",null) as obj in unary_objects
	if(!target)
		return 0

	if(!(target in oview(1)))
		return 0

	var/obj/machinery/atmospherics/components/V = target
	if(do_mob(user, V, 20))
		playsound(V.loc, 'sound/items/Welder2.ogg', 50, 1)
		V.welded = 0
		V.update_icon()
		user.visible_message("<span class='danger'>[user] spits acid at [V].</span>", \
			"<span class='noticealien'>You corrode [V] with your acid.</span>", \
			"You hear a loud hissing sound.")
		return 1
	return 0

/obj/effect/proc_holder/alien/nightvisiontoggle
	name = "Toggle Night Vision"
	desc = "Toggles Night Vision"
	plasma_cost = 0
	has_action = 0 // Has dedicated GUI button already

/obj/effect/proc_holder/alien/nightvisiontoggle/fire(mob/living/carbon/alien/user)
	if(!user.nightvision)
		user.see_in_dark = 8
		user.see_invisible = SEE_INVISIBLE_MINIMUM
		user.nightvision = 1
		user.hud_used.nightvisionicon.icon_state = "nightvision1"
	else if(user.nightvision == 1)
		user.see_in_dark = 4
		user.see_invisible = 45
		user.nightvision = 0
		user.hud_used.nightvisionicon.icon_state = "nightvision0"

	return 1

/mob/living/carbon/proc/getPlasma()
	var/obj/item/organ/internal/alien/plasmavessel/vessel = getorgan(/obj/item/organ/internal/alien/plasmavessel)
	if(!vessel) return 0
	return vessel.storedPlasma


/mob/living/carbon/proc/adjustPlasma(amount)
	var/obj/item/organ/internal/alien/plasmavessel/vessel = getorgan(/obj/item/organ/internal/alien/plasmavessel)
	if(!vessel) return 0
	vessel.storedPlasma = max(vessel.storedPlasma + amount,0)
	vessel.storedPlasma = min(vessel.storedPlasma, vessel.max_plasma) //upper limit of max_plasma, lower limit of 0
	return 1

/mob/living/carbon/alien/adjustPlasma(amount)
	. = ..()
	updatePlasmaDisplay()

/mob/living/carbon/proc/usePlasma(amount)
	if(getPlasma() >= amount)
		adjustPlasma(-amount)
		return 1

	return 0


/proc/cmp_abilities_cost(obj/effect/proc_holder/alien/a, obj/effect/proc_holder/alien/b)
	return b.plasma_cost - a.plasma_cost

/mob/living/carbon/alien/verb/hive_status()
	set name = "Hive Status"
	set desc = "Check the status of your current hive."
	set category = "Alien"

	var/dat = "<html><head><title>Hive Status</title></head><body><h1><B>Hive Status</B></h1>"
	
	if(ticker.mode.aliens.len > 0)
		dat += "<table cellspacing=5><tr><td><b>Name</b></td><td><b>Location</b></td></tr>"
		for(var/mob/living/L in mob_list)
			var/turf/pos = get_turf(L)
			if(L.mind && L.mind.assigned_role)
				if(L.mind.assigned_role == "Alien")
					var/mob/M = L.mind.current
					var/area/player_area = get_area(L)
					if((M) && (pos) && (pos.z == 1 || pos.z == 3))
						dat += "<tr><td>[M.real_name][M.client ? "" : " <i>(mindless)</i>"][M.stat == 2 ? " <b><font color=red>(DEAD)</font></b>" : ""]</td>"
						dat += "<td>[player_area.name] ([pos.x], [pos.y])</td></tr>"
		dat += "</table>"
	dat += "</body></html>"
	usr << browse(dat, "window=roundstatus;size=600x400")
	return


//Digger ability
/mob/living/proc/update_tunnel_vision()
	remove_tunnel_vision()

	if(istype(src.loc, /obj/tunnel))
		for(var/obj/tunnel/A in world)
			if(!A.tunnel_vision_img)
				A.tunnel_vision_img = image(A, A.loc, layer = 20, dir = A.dir)
				//20 for being above darkness
			tunnel_shown += A.tunnel_vision_img
			if(client)
				client.images += A.tunnel_vision_img

/mob/living/proc/remove_tunnel_vision()
	if(client)
		for(var/image/current_image in tunnel_shown)
			client.images -= current_image
		client.eye = src
	tunnel_shown.len = 0

/obj/effect/proc_holder/alien/dig
	name = "Dig"
	desc = "Dig tunnel"
	plasma_cost = 0
	action_icon_state = "alien_dig"

	var/digging = 0

/obj/effect/proc_holder/alien/dig/fire(mob/living/carbon/user)
	if(user.z == 0)
		if(!istype(user.loc, /obj/tunnel))
			user << "<span class='noticealien'>You can't dig here.</span>"
			return 0
	else if(user.z != 1)
		user << "<span class='noticealien'>You can't dig here.</span>"
		return 0

	//this is shuttle landing pad below, not sure how i want check that in other way.
	if(((user.x >= 139 && user.x <= 156) && (user.y >= 171 && user.y <= 177)) || ((user.x >= 218 && user.x <= 235) && (user.y >= 206 && user.y <= 212)))
		user << "<span class='noticealien'>You can't dig here.</span>"
		return 0

	if(digging)
		return 0

	var/turf/T = get_turf(user)

	if(T.density)
		user << "<span class='noticealien'>You can't dig here.</span>"
		return 0
	else
		for(var/atom/A in T.contents)
			if((A != user) && A.density)
				user << "<span class='noticealien'>You can't dig here.</span>"
				return 0

	var/obj/tunnel/hole/Hole = locate(/obj/tunnel/hole) in T
	if(Hole)
		user << "<span class='noticealien'>You can't dig here.</span>"
		return 0

	var/obj/tunnel/Tunnel = locate(/obj/tunnel) in T
	if(Tunnel)
		digging = 1
		if(!do_after(user, 100, target = T))
			digging = 0
			return 0

		digging = 0
		Hole = new /obj/tunnel/hole(T)

		for(var/mob/living/L in Tunnel.contents)
			L.loc = Hole
			L.client.eye = Hole

		qdel(Tunnel)
	else
		digging = 1
		if(!do_after(user, 100, target = T))
			digging = 0
			return 0

		digging = 0
		new /obj/tunnel/hole(T)

	return 1

/mob/living/carbon
	var/tunnel_delay_move = 0

/obj/tunnel
	name = "tunnel"
	icon = 'icons/Xeno/effects.dmi'
	icon_state = "tunnel"
	var/image/tunnel_vision_img = null
	anchored = 1
	unacidable = 1
	invisibility = 101

/obj/tunnel/New()
	..()

	playsound(src.loc, 'sound/effects/shovel_dig.ogg', 50, 1, -3)

	for(var/mob/living/carbon/C in living_mob_list)
		if(istype(C.loc, /obj/tunnel))
			if(!src.tunnel_vision_img)
				src.tunnel_vision_img = image(src, src.loc, layer = 20)
			C.tunnel_shown += src.tunnel_vision_img
			if(C.client)
				C.client.images += src.tunnel_vision_img

/obj/tunnel/hole
	name = "hole"
	icon_state = "hole"
	invisibility = 0

/obj/tunnel/Destroy()
	for(var/mob/living/L in contents)
		L.forceMove(get_turf(src))

	if(tunnel_vision_img)
		qdel(tunnel_vision_img)
	..()

/obj/tunnel/hole/attackby(obj/item/weapon/W, mob/user, params)
	if(istype(W, /obj/item/weapon/grenade/explosive) || istype(W, /obj/item/weapon/grenade/frag) || istype(W, /obj/item/weapon/c4))
		var/answer = alert(user, "Do you want to throw explosive grenade in?",,"Yes","No")
		if(answer == "No")
			return
		if(answer == "Yes")
			if(!do_after(user, 20, target = src))
				return

			if(W && W == user.get_active_hand())
				playsound(user.loc, 'sound/weapons/armbomb.ogg', 60, 1)
				qdel(W)
				
				grenade_act()

/obj/tunnel/hole/Crossed(AM as obj)
	if(istype(AM, /obj/item/weapon/grenade/explosive) || istype(AM, /obj/item/weapon/grenade/frag))
		var/obj/item/weapon/grenade/G = AM
		if(G.active)
			qdel(G)
			grenade_act()

/obj/tunnel/hole/proc/grenade_act()
	spawn(30)
		explosion(loc,0,0,3)
		for(var/turf/T in range(10))
			for(var/obj/tunnel/Tunnel in T.contents)
				Tunnel.explode_act()
				sleep(1)

/obj/tunnel/proc/explode_act()
	for(var/mob/living/L in contents)
		L.adjustBruteLoss(1000)
	if(prob(25))
		var/turf/T = get_turf(src)
		var/datum/effect/effect/system/smoke_spread/smoke = new
		smoke.set_up(1, 0, T) // if more than one smoke, spread it around
		smoke.start()
	qdel(src)

/obj/tunnel/relaymove(mob/living/carbon/user, direction)
	if(user.tunnel_delay_move >= world.time)
		return
	if(istype(user, /mob/living/carbon/alien/humanoid/digger))
		user.tunnel_delay_move = world.time + 2
	else
		user.tunnel_delay_move = world.time + 5

	if(istype(get_step(user, direction), /turf/indestructible))
		return

	//this is shuttle landing pad below, not sure how i want check that in other way.
	var/turf/check = get_step(user, direction)
	if(((check.x >= 139 && check.x <= 156) && (check.y >= 171 && check.y <= 177)) || ((check.x >= 218 && check.x <= 235) && (check.y >= 206 && check.y <= 212)))
		user << "<span class='noticealien'>You can't dig here.</span>"
		return 0

	var/obj/tunnel/target_move = locate(/obj/tunnel) in get_step(user, direction)

	if(buckled_mob == user) // fixes buckle crawl edgecase fuck bug
		return

	if(user.stunned)
		return

	if(!target_move)
		if(user.getorgan(/obj/item/organ/internal/alien/digger))
			if(user.next_move >= world.time)
				return
			user.changeNext_move(20)
			var/turf/T = get_turf(get_step(user, direction))
			if(!do_after(user, 20, target = T))
				return
			new /obj/tunnel(T)
		return
	else
		if(istype(target_move, /obj/tunnel/hole))
			user.remove_tunnel_vision()
			user.forceMove(target_move.loc) //handle entering and so on.
			user.visible_message("<span class='notice'>You hear something squeezing through the tunnel...</span>","<span class='notice'>You climb out the tunnel system.")
			user.stunned = 1
			user.canmove = 0
		else
			//if(returnPipenet() != target_move.returnPipenet())
			//	user.update_pipe_vision(target_move)
			user.loc = target_move
			user.client.eye = target_move  //Byond only updates the eye every tick, This smooths out the movement
			//if(world.time - user.last_played_vent > VENT_SOUND_DELAY)
			//	user.last_played_vent = world.time
			//	playsound(src, 'sound/machines/ventcrawl.ogg', 50, 1, -3)

	user.canmove = 0
	spawn(1)
		user.canmove = 1

/obj/tunnel/hole/AltClick(mob/living/L)
	if(istype(src, /obj/tunnel/hole))
		L.handle_tunnelcrawl(src)
		return
	..()

/mob/living/proc/handle_tunnelcrawl(atom/A)
	if(!ventcrawler || !Adjacent(A))
		return
	if(stat)
		src << "You must be conscious to do this!"
		return
	if(lying)
		src << "You can't vent crawl while you're stunned!"
		return
	if(restrained())
		src << "You can't vent crawl while you're restrained!"
		return

	var/obj/tunnel/hole/hole_found

	if(A)
		hole_found = A
		if(!istype(hole_found))
			hole_found = null

	if(hole_found)
		if(!istype(src, /mob/living/carbon/alien/humanoid/digger))
			var/check_passed = 0
			for(var/direction_check in cardinal)
				var/turf/Turf_check = get_turf(get_step(src, direction_check))
				for(var/obj/tunnel/tunnel_check in Turf_check.contents)
					if(tunnel_check)
						check_passed = 1
						break
				if(check_passed)
					break
			if(!check_passed)
				src << "<span class='warning'>This hole is not connected to anything!</span>"
				return

		visible_message("<span class='notice'>[src] begins climbing into the tunnel system...</span>" ,"<span class='notice'>You begin climbing into the tunnel system...</span>")

		if(!do_after(src, 25, target = hole_found))
			return

		if(!client)
			return

		if(isalien(src) && ventcrawler)//It must have atleast been 1 to get this far
			visible_message("<span class='notice'>[src] scrambles into the tunnel system!</span>","<span class='notice'>You climb into the tunnel system.</span>")
			loc = hole_found
			update_tunnel_vision()
	else
		src << "<span class='warning'>This tunnel system is not connected to anything!</span>"

/obj/effect/proc_holder/alien/evolve_next
	name = "Evolve (Next Tier)"
	desc = "Evolve into next tier."
	plasma_cost = 0

	action_icon_state = "evolve_tier"

	var/cooldown = 0

/obj/effect/proc_holder/alien/evolve_next/fire(mob/living/carbon/alien/humanoid/user)
	if(!istype(user)) return 0
	if(cooldown > world.time)
		user << "<span class='warning'>Cannot use this menu so often!</span>"
		return 0
	cooldown = world.time + 100

	var/choice = input("Choose next evolution lifeform", "Choose a lifeform",null) in user.get_evolve_choices()
	if(!choice) return 0

	if(!user.is_lifeform_avail(user,choice)) return 0

	if(!user.check_current_caste(user.caste,choice)) return 0
	if(user.evolving) return 0
	if(user.stat == DEAD) return 0
	if(user.stat)
		user << "<span class='noticealien'>We must be conscious.</span>"
		return 0

	if(!(locate(/obj/structure/alien/weeds) in get_turf(user)))
		user << "<span class='noticealien'>We can evolve only on the weed.</span>"
		return 0

	var/answer = alert(user, "Our next lifeform is [choice]",,"Proceed","Cancel")
	if(answer == "Cancel") return 0

	if(!we_inside_hive(user))
		answer = alert(user, "There is no hive nearby. Evolve process will take 2 minutes",,"Proceed","Cancel")
		if(answer == "Cancel") return 0

	if(!isturf(user.loc))
		user << "<span class='noticealien'>We need more room.</span>"
		return 0

	var/evolve_cost = user.get_evolve_cost(choice)

	if(x_points_controller.use_points(user.client, evolve_cost))
		user.do_evolve(choice)
		return 1
	else
		user << "<span class='noticealien'>[evolve_cost] evolution points required.</span>"

	return 0

/obj/effect/proc_holder/alien/rav_roar
	name = "Rooaaar"
	desc = "Increase your movement speed in a short period of time."
	plasma_cost = 0
	action_icon_state = "rav_roar"
	var/cooldown = 0

/obj/effect/proc_holder/alien/rav_roar/fire(mob/living/carbon/alien/humanoid/ravager/user)
	if(!istype(user)) return
	if(cooldown > world.time)
		user << "<span class='noticealien'>Ability is in cooldown state..</span>"
		return

	playsound(user, 'sound/voice/hiss5.ogg', 100, 1, -3)
	cooldown = world.time + 600
	user.speed_bonus = -1.5
	spawn(50)
		user.speed_bonus = 0

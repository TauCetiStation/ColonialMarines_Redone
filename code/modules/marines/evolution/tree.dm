/* For Debug use only
/mob/verb/debug_controller(xeno_evolution in list("Evolution Tree","X Stats","Xeno Controller"))
	set category = "Test"
	set name = "Debug Evolution"
	set desc = "Debug the evolutions."

	var/mob/user = usr
	if(!user.client.holder)	return
	switch(xeno_evolution)
		if("Evolution Tree")
			user.client.debug_variables(evolution_tree)

		if("X Stats")
			user.client.debug_variables(x_stats)

		if("Xeno Controller")
			user.client.debug_variables(x_points_controller)
	return*/

/datum/evo_tree
	var/list/known_evolutions = list()

	var/datum/evolution/being_researched

	var/busy = 0
	var/progress = 0
	var/list/tree_progress = list(
								"Queen"		= 0,
								"Hive"		= 0,
								"Drone"		= 0,
								"Sentinel"	= 0,
								"Warrior"	= 0,
								"Total"		= 0,
								"MaxTier"	= 0
								)

/datum/evo_tree/New()
	for(var/path in typesof(/datum/evolution) - /datum/evolution)
		var/datum/evolution/E = new path(src)
		if(E.id)
			known_evolutions += E

/datum/evo_tree/proc/FindEvolutionByID(id)
	for(var/datum/evolution/E in known_evolutions)
		if(E.id == id)
			return E

var/datum/evo_tree/evolution_tree = new /datum/evo_tree()

/datum/evo_tree/proc/show_tree(mob/user)
	if(!isalien(user)) return
	if(user.stat) return
	var/dat

	if(isqueen(user))
		dat = main_win(user)
	else
		dat = viewer_win(user)

	var/datum/browser/popup = new(user, "evo_tree", "Evolution Menu", 600, 500)
	popup.set_content(dat)
	popup.open()

/datum/evo_tree/proc/hivemind_check(var/amt)
	if(hive_controller)
		if((hive_controller.psychicstrengthused + amt) <= hive_controller.psychicstrength)
			return 1
		else
			return 0

/datum/evo_tree/proc/can_level(datum/evolution/E)
	if(busy)
		return 0
	if(E.level < E.maxlevel)
		if(!hivemind_check(E.cost))
			return 0
		if(E.req_total_points.len)
			var/next_level = E.level + 1
			if(evolution_tree.tree_progress["Total"] < E.req_total_points[next_level])
				return 0
		if(E.tier && E.tier > tree_progress["MaxTier"])
			return 0
		if(E.req_evolution.len)
			for(var/X in E.req_evolution)
				var/datum/evolution/found_X = FindEvolutionByID(X)
				if(found_X.level < E.req_evolution[X])
					return 0
	else if(E.level >= E.maxlevel)
		return 2
	return 1

/datum/evo_tree/proc/main_win(mob/user)
	var/dat = "<div class='statusDisplay'><b>Researching:</b> [being_researched ? "[being_researched.name] ([progress]% done)" : "nothing"]</div>"
	dat += {"<div class='statusDisplayfixed'><b>Progress:</b> 
				Queen: <statp>[evolution_tree.tree_progress["Queen"]]</statp> | 
				Hive: <statp>[evolution_tree.tree_progress["Hive"]]</statp> | 
				Drone: <statp>[evolution_tree.tree_progress["Drone"]]</statp> | 
				Sentinel: <statp>[evolution_tree.tree_progress["Sentinel"]]</statp> | 
				Warrior: <statp>[evolution_tree.tree_progress["Warrior"]]</statp> | 
				Total: <statp>[evolution_tree.tree_progress["Total"]]</statp>
			</div>"}

	var/last_category
	for(var/datum/evolution/E in known_evolutions)
		if(!last_category)
			last_category = E.category
			dat += "<div class='statusDisplay'>"
			dat += "<div class='title'>[E.category]</div>"

		if(last_category != E.category)
			last_category = E.category
			dat += "</div>"
			dat += "<div class='statusDisplay'>"
			dat += "<div class='title'>[E.category]</div>"

		var/next_level = E.level + 1
		dat += "<div>"
		switch(can_level(E))
			if(0)
				dat += "<span class='linkOff'>[E.name] ([E.level] / [E.maxlevel]) (Price: [E.cost])"
				dat += "<span class='description'>"
				if(E.tier && E.tier > tree_progress["MaxTier"])
					var/ending
					switch(E.tier)
						if(1)
							ending = "st"
						if(2)
							ending = "nd"
						if(3)
							ending = "rd"
					dat += "<span class='bad'>[E.tier][ending] tier evolution.</span><br>"
				dat += "<span class='average'>[E.desc]</span>"
				if(E.desc_level.len && E.desc_level.len >= next_level)
					dat += "<br>[E.desc_level[next_level]]"
				if(E.req_total_points.len)
					var/required_points = E.req_total_points[next_level]
					if(evolution_tree.tree_progress["Total"] < required_points)
						dat += "<br><span class='bad'>[required_points]</span> points in tree required."
				if(E.req_evolution.len)
					for(var/X in E.req_evolution)
						var/datum/evolution/found_X = FindEvolutionByID(X)
						if(found_X.level < E.req_evolution[X])
							dat += "<br><span class='bad'><b>[uppertext(found_X.name)]</b></span><br>Level <span class='bad'>[E.req_evolution[X]]</span> required."
				dat += "</span>"
				dat += "</span>"
			if(1)
				dat += "<a href='?src=\ref[src];make=[E.id]'>[E.name] ([E.level] / [E.maxlevel]) (Price: [E.cost])"
				dat += "<span class='description'>"
				dat += "<span class='average'>[E.desc]</span>"
				if(E.desc_level.len && E.desc_level.len >= next_level)
					dat += "<br>[E.desc_level[next_level]]"
				dat += "</span>"
				dat += "</a>"
			if(2)
				dat += "<span class='linkMax'>[E.name] (Maxed)"
				dat += "<span class='description'><span class='average'>[E.desc]</span>"
				if(E.desc_level.len && E.desc_level.len >= next_level)
					dat += "<br>[E.desc_level[next_level]]"
				dat += "</span>"
				dat += "</span>"
		dat += "</div>"
	dat += "</div><br><br>"
	return dat

/datum/evo_tree/proc/viewer_win(mob/user)
	var/dat = {"<div class='statusDisplayfixed'><b>Progress:</b> 
				Queen: <statp>[evolution_tree.tree_progress["Queen"]]</statp> | 
				Hive: <statp>[evolution_tree.tree_progress["Hive"]]</statp> | 
				Drone: <statp>[evolution_tree.tree_progress["Drone"]]</statp> | 
				Sentinel: <statp>[evolution_tree.tree_progress["Sentinel"]]</statp> | 
				Warrior: <statp>[evolution_tree.tree_progress["Warrior"]]</statp> | 
				Total: <statp>[evolution_tree.tree_progress["Total"]]</statp>
			</div>"}

	var/last_category
	for(var/datum/evolution/E in known_evolutions)
		if(!last_category)
			last_category = E.category
			dat += "<div class='statusDisplay'>"
			dat += "<div class='title'>[E.category]</div>"

		if(last_category != E.category)
			last_category = E.category
			dat += "</div>"
			dat += "<div class='statusDisplay'>"
			dat += "<div class='title'>[E.category]</div>"

		var/next_level = E.level + 1
		dat += "<div>"
		switch(can_level(E))
			if(0 to 1)
				dat += "<span class='linkOff'>[E.name] ([E.level] / [E.maxlevel])"
				dat += "<span class='description'>"
				dat += "<span class='average'>[E.desc]</span>"
				if(E.desc_level.len && E.desc_level.len >= next_level)
					dat += "<br>[E.desc_level[next_level]]"
				dat += "</span>"
				dat += "</a>"
			if(2)
				dat += "<span class='linkMax'>[E.name] (Maxed)"
				dat += "<span class='description'><span class='average'>[E.desc]</span>"
				if(E.desc_level.len && E.desc_level.len >= next_level)
					dat += "<br>[E.desc_level[next_level]]"
				dat += "</span>"
				dat += "</span>"
		dat += "</div>"
	dat += "</div><br><br>"
	return dat

/datum/evo_tree/Topic(href, href_list)
	if(!isqueen(usr))
		return

	var/mob/living/carbon/alien/humanoid/queen/Q = usr
	if(Q.stat) return

	if(!busy)
		if(href_list["make"])

			being_researched = FindEvolutionByID(href_list["make"])
			if(!being_researched)
				return

			switch(can_level(being_researched))
				if(1)
					busy = 1
					start_research(being_researched)
				if(0,2)
					being_researched = null
					return
	else
		usr << "<span class=\"alert\">Busy. Please wait for completion of previous evolution.</span>"

	evolution_tree.show_tree(usr)

	return

/datum/evo_tree/proc/start_research(datum/evolution/E)
	var/time_started = world.time
	var/time_needed = E.research_time
	var/time_finished = world.time + time_needed

	spawn()
		while(src && world.time < time_finished)
			var/cur_progress = ((world.time-time_started) / time_needed) * 100
			progress = round(cur_progress)
			sleep(10)

		end_research(E)

/datum/evo_tree/proc/end_research(datum/evolution/E)
	being_researched = null
	progress = 0
	hive_controller.psychicstrengthused += E.cost
	E.increase_level()

	for(var/mob/living/carbon/alien/A in living_mob_list)
		A << "<span class='noticealien'><b>[E.name]</b> ([E.level] / [E.maxlevel]) evolution complete.</span>"

	for(var/mob/dead/observer/O in player_list)//Why not.
		if(O.started_as_observer)
			O << "<span class='noticealien'><b>[E.name]</b> ([E.level] / [E.maxlevel]) evolution complete.</span>"

	busy = 0

/datum/evolution
	var/name = "Name"
	var/desc = ""
	var/list/desc_level = list()
	var/desc_req = ""
	var/id = null

	var/category = null
	var/datum/xeno_stats/stat = null
	var/caste = null

	var/tier = 0
	var/research_time = 3600 //default - tier1 = 1200, tier2 = 2400, tier3 = 3600
	var/cost = 15 //tier1 = 5, tier2 = 10, tier3 = 15
	var/level = 0
	var/maxlevel = 0
	var/list/req_evolution = list()
	var/list/req_total_points = list()

/datum/evolution/proc/generate_stats_description(start_level=1,end_level = 4)//3 + maxed = 4
	if(stat)
		desc_level = new/list(end_level)

		var/max_health		= stat.max_health["base"]
		var/heal_rate		= stat.heal_rate["base"]
		var/armor			= stat.armor["base"]
		var/max_plasma		= stat.max_plasma["base"]
		var/plasma_rate		= stat.plasma_rate["base"]
		var/damage_min		= stat.damage_min["base"]
		var/damage_max		= stat.damage_max["base"]
		var/tackle_min		= stat.tackle_min["base"]
		var/tackle_max		= stat.tackle_max["base"]
		var/tackle_chance	= stat.tackle_chance["base"]

		for(var/i=start_level, i <= end_level, i++)
			var/level = i

			var/max_health_b	= 0
			var/heal_rate_b		= 0
			var/armor_b			= 0
			var/max_plasma_b	= 0
			var/plasma_rate_b	= 0
			var/damage_min_b	= 0
			var/damage_max_b	= 0
			var/tackle_min_b	= 0
			var/tackle_max_b	= 0
			var/tackle_chance_b	= 0

			if(level > start_level && level < end_level)
				max_health_b	= stat.max_health["bonus"]["[level]"]
				heal_rate_b		= stat.heal_rate["bonus"]["[level]"]
				armor_b			= stat.armor["bonus"]["[level]"]
				max_plasma_b	= stat.max_plasma["bonus"]["[level]"]
				plasma_rate_b	= stat.plasma_rate["bonus"]["[level]"]
				damage_min_b	= stat.damage_min["bonus"]["[level]"]
				damage_max_b	= stat.damage_max["bonus"]["[level]"]
				tackle_min_b	= stat.tackle_min["bonus"]["[level]"]
				tackle_max_b	= stat.tackle_max["bonus"]["[level]"]
				tackle_chance_b	= stat.tackle_chance["bonus"]["[level]"]

			if(level == start_level || level == end_level)
				desc_level[level] = {"<div class='description_table'>
							<div class='description_content'>
								Health:<br>
								Heal Rate:<br>
								Armor:<br>
								Plasma:<br>
								Plasma Rate:<br>
								Damage:<br>
								Tackle:<br>
								Tackle Chance:
							</div>
								<div class='description_content'>
								<statc>[max_health]</statc><br>
								<statc>[heal_rate]</statc><br>
								<statc>[armor]</statc>%<br>
								<statc>[max_plasma]</statc><br>
								<statc>[plasma_rate]</statc><br>
								<statc>[damage_min]</statc>-<statc>[damage_max]</statc><br>
								<statc>[tackle_min]</statc>-<statc>[tackle_max]</statc><br>
								<statc>[tackle_chance]</statc>
							</div>
						</div>"}
						
			else
				desc_level[level] = {"<div class='description_table'>
							<div class='description_content'>
								Health:<br>
								Heal Rate:<br>
								Armor:<br>
								Plasma:<br>
								Plasma Rate:<br>
								Damage:<br>
								Tackle:<br>
								Tackle Chance:
							</div>
							<div class='description_content'>
								<statc>[max_health]</statc>									(+<statp>[max_health_b]</statp>)<br>
								<statc>[heal_rate]</statc>									(+<statp>[heal_rate_b]</statp>)<br>
								<statc>[armor]</stat>%										(+<statp>[armor_b]</statp>%)<br>
								<statc>[max_plasma]</statc>									(+<statp>[max_plasma_b]</statp>)<br>
								<statc>[plasma_rate]</statc>								(+<statp>[plasma_rate_b]</statp>)<br>
								<statc>[damage_min]</statc>-<statc>[damage_max]</statc>		(+<statp>[damage_min_b]</statp>-<statp>[damage_max_b]</statp>)<br>
								<statc>[tackle_min]</statc>-<statc>[tackle_max]</statc>		(+<statp>[tackle_min_b]</statp>-<statp>[tackle_max_b]</statp>)<br>
								<statc>[tackle_chance]</statc>								(+<statp>[tackle_chance_b]</statp>)
							</div>
						</div>"}

			max_health += max_health_b
			heal_rate += heal_rate_b
			armor += armor_b
			max_plasma += max_plasma_b
			plasma_rate += plasma_rate_b
			damage_min += damage_min_b
			damage_max += damage_max_b
			tackle_min += tackle_min_b
			tackle_max += tackle_max_b
			tackle_chance += tackle_chance_b

/datum/evolution/proc/on_level()
	if(stat)
		if(level > 1)
			stat.max_health["base"] += stat.max_health["bonus"]["[level]"]
			stat.heal_rate["base"] += stat.heal_rate["bonus"]["[level]"]
			stat.armor["base"] += stat.armor["bonus"]["[level]"]
			stat.max_plasma["base"] += stat.max_plasma["bonus"]["[level]"]
			stat.plasma_rate["base"] += stat.plasma_rate["bonus"]["[level]"]
			stat.damage_min["base"] += stat.damage_min["bonus"]["[level]"]
			stat.damage_max["base"] += stat.damage_max["bonus"]["[level]"]
			stat.tackle_min["base"] += stat.tackle_min["bonus"]["[level]"]
			stat.tackle_max["base"] += stat.tackle_max["bonus"]["[level]"]
			stat.tackle_chance["base"] += stat.tackle_chance["bonus"]["[level]"]

		for(var/mob/living/carbon/alien/humanoid/H in living_mob_list)
			if(H.caste == caste)
				H.update_stats(1)
	if(category)
		if(id == "q_qhr")
			evolution_tree.tree_progress["MaxTier"] = level
		else
			switch(category)
				if("Queen")
					evolution_tree.tree_progress["Queen"]++
				if("Hive")
					evolution_tree.tree_progress["Hive"]++
				if("Drone")
					evolution_tree.tree_progress["Drone"]++
				if("Sentinel")
					evolution_tree.tree_progress["Sentinel"]++
				if("Warrior")
					evolution_tree.tree_progress["Warrior"]++

			evolution_tree.tree_progress["Total"]++
	return

/datum/evolution/proc/increase_level()
	level++
	on_level()

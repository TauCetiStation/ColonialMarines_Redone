/datum/researchable_upgrades
	var/list/known_upgrades = list()

/datum/researchable_upgrades/New()
	for(var/path in typesof(/datum/upgrade) - /datum/upgrade)
		var/datum/upgrade/U = new path(src)
		known_upgrades += U

/datum/researchable_upgrades/proc/FindUpgradeByID(id)
	for(var/datum/upgrade/U in known_upgrades)
		if(U.id == id)
			return U

/datum/upgrade
	var/name = "Name"
	var/desc = ""
	var/desc_req = ""
	var/id = "id"
	var/list/category = null

	var/research_time = 0
	var/cost = 1
	var/level = 0
	var/maxlevel = 0
	var/req_upgrade = null
	var/req_upgrade_level = null

/datum/upgrade/proc/on_level()
	return

/datum/upgrade/proc/increase_level()
	level++
	on_level()

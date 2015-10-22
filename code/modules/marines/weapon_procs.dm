proc/weapon_unload_check(mob/living/carbon/human/user,obj/item/weapon/gun/Gun,var/free_hand = 0)
	if(!user || !Gun)
		return 0

	if(!ishuman(user))
		return 0

	if(user.get_inactive_hand() != Gun)
		user << "<span class='warning'>[Gun] must be in inactive hand.</span>"
		return 0

	if(free_hand && user.get_active_hand())
		user << "<span class='warning'>Active hand must be free.</span>"
		return 0

	return 1

/proc/do_reload(mob/user , obj/item/weapon, obj/item/magazine, time = 30, numticks = 5)
	if(!user || !weapon || !magazine)
		return 0
	if(numticks == 0)
		return 0
	var/timefraction = round(time/numticks)
	var/image/progbar
	for(var/i = 1 to numticks)
		if(user.client)
			progbar = make_progress_bar(i, numticks, user)
			user.client.images |= progbar
		sleep(timefraction)
		if(!user || !weapon || !magazine)
			if(user && user.client)
				user.client.images -= progbar
			return 0
		if(user.get_inactive_hand() != weapon || user.get_active_hand() != magazine || user.incapacitated() || user.lying)
			if(user && user.client)
				user.client.images -= progbar
			return 0
		if(user && user.client)
			user.client.images -= progbar
	if(user && user.client)
		user.client.images -= progbar
	return 1

/proc/do_unload(mob/user , obj/item/weapon, time = 30, numticks = 5)
	if(!user || !weapon)
		return 0
	if(numticks == 0)
		return 0
	var/timefraction = round(time/numticks)
	var/image/progbar
	for(var/i = 1 to numticks)
		if(user.client)
			progbar = make_progress_bar(i, numticks, user)
			user.client.images |= progbar
		sleep(timefraction)
		if(!user || !weapon)
			if(user && user.client)
				user.client.images -= progbar
			return 0
		if(user.get_inactive_hand() != weapon || user.get_active_hand() || user.incapacitated() || user.lying)
			if(user && user.client)
				user.client.images -= progbar
			return 0
		if(user && user.client)
			user.client.images -= progbar
	if(user && user.client)
		user.client.images -= progbar
	return 1

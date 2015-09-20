/mob/new_player/Login()
	update_Login_details()	//handles setting lastKnownIP and computer_id for use by the ban systems as well as checking for multikeying
	if(join_motd)
		src << "<div class=\"motd\">[join_motd]</div>"

	world << "<b>Current winrate:</b>"
	world << "		<b>total wins	:	10+ players	:	major losses</b>"
	world << "<b>Aliens:</b>	[a_wins]		<b>:</b>	[a10_wins]		<b>:</b>	[a_loss]"
	world << "<b>Marines:</b>	[m_wins]		<b>:</b>	[m10_wins]		<b>:</b>	[m_loss]"

	if(admin_notice)
		src << "<span class='notice'><b>Admin Notice:</b>\n \t [admin_notice]</span>"

	if(config.soft_popcap && living_player_count() >= config.soft_popcap)
		src << "<span class='notice'><b>Server Notice:</b>\n \t [config.soft_popcap_message]</span>"

	if(!mind)
		mind = new /datum/mind(key)
		mind.active = 1
		mind.current = src

	if(length(newplayer_start))
		loc = pick(newplayer_start)
	else
		loc = locate(1,1,1)
	lastarea = loc

	sight |= SEE_TURFS
	player_list |= src

/*
	var/list/watch_locations = list()
	for(var/obj/effect/landmark/landmark in landmarks_list)
		if(landmark.tag == "landmark*new_player")
			watch_locations += landmark.loc

	if(watch_locations.len>0)
		loc = pick(watch_locations)
*/
	new_player_panel()
	if(ckey in deadmins)
		verbs += /client/proc/readmin
	spawn(40)
		if(client)
			client.playtitlemusic()

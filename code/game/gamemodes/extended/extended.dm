/datum/game_mode/extended
	name = "extended"
	config_tag = "extended"
	required_players = 0
	votable = 1
	//reroll_friendly = 1

/datum/game_mode/announce()
	world << "<B>The current game mode is - Extended Role-Playing!</B>"
	world << "<B>Just have fun and role-play!</B>"

/datum/game_mode/extended/pre_setup()
	config.vote_delay = 6000
	return 1

/datum/game_mode/extended/post_setup()
	..()

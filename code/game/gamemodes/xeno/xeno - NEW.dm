//COLONIAL MARINES GAME MODE REDUX -APOPHIS775 - CREATED: 07APR2015
/datum/game_mode
	var/list/datum/mind/aliens = list()
	var/list/datum/mind/survivors = list()

/datum/game_mode/infestation
	name = "infestation"
	config_tag = "infestation"
	required_players = 0
	required_enemies = 1
	recommended_enemies = 1

//Adjustable Variables
	var/min_aliens = 0
	var/max_aliens = 8
	var/min_survivors = 0
	var/max_survivors = 3

//Non-adjustable variables (as in, DON'T FUCK WITH THEM)
	var/humansurvivors = 0
	var/aliensurvivors = 0
	var/checkwin_counter = 0
	var/finished = 0

/datum/game_mode/infestation/proc/get_players_for_as(var/which)
	var/list/players = list()
	var/list/candidates = list()
	var/list/drafted = list()
	var/datum/mind/applicant = null

	// Ultimate randomizing code right here
	for(var/mob/new_player/player in player_list)
		if(player.client && player.ready)
			players += player

	// Shuffling, the players list is now ping-independent!!!
	// Goodbye antag dante
	players = shuffle(players)

	for(var/mob/new_player/player in players)
		if(player.client && player.ready)
			switch(which)
				if(1)
					if(player.client.prefs.be_special & BE_ALIEN)
						if(!jobban_isbanned(player, "Syndicate") && !jobban_isbanned(player, "Xenomorph")) //Nodrak/Carn: Antag Job-bans
							//if(age_check(player.client)) //Must be older than the minimum age
							candidates += player.mind				// Get a list of all the people who want to be the antagonist for this round
				if(2)
					if(player.client.prefs.be_special & BE_SURVIVOR)
						if(!jobban_isbanned(player, "Syndicate") && !jobban_isbanned(player, "Survivor")) //Nodrak/Carn: Antag Job-bans
							//if(age_check(player.client)) //Must be older than the minimum age
							candidates += player.mind				// Get a list of all the people who want to be the antagonist for this round

	drafted = shuffle(drafted) // Will hopefully increase randomness, Donkie

	while(candidates.len < recommended_enemies)				// Pick randomlly just the number of people we need and add them to our list of candidates
		if(drafted.len > 0)
			applicant = pick(drafted)
			if(applicant)
				candidates += applicant
				drafted.Remove(applicant)

		else												// Not enough scrubs, ABORT ABORT ABORT
			break

	drafted = shuffle(drafted) // Will hopefully increase randomness, Donkie

	while(candidates.len < recommended_enemies)				// Pick randomlly just the number of people we need and add them to our list of candidates
		if(drafted.len > 0)
			applicant = pick(drafted)
			if(applicant)
				candidates += applicant
				drafted.Remove(applicant)

		else												// Not enough scrubs, ABORT ABORT ABORT
			break

	return candidates


//Pre-game
/datum/game_mode/infestation/can_start()
	if(!..())
		return 0

	var/readyplayers = num_players() //Gets the number of players, to determine the number of aliens and survivors
	var/list/datum/mind/possible_aliens = get_players_for_as(1) //populate a list of people who want to be aliens

	// 1 Alien per 5 players
	if(!possible_aliens.len)
		world << "<span class='userdanger'>No alien players.</span>"
		return 0

	for(var/C = 0, C < readyplayers, C += 5)
		var/datum/mind/alien = pick(possible_aliens)
		aliens += alien
		alien.assigned_role = "MODE" //so it doesn't get picked for survivor or marine
		alien.special_role = "drone"

	var/list/datum/mind/possible_survivors = get_players_for_as(2) //populate a list of people who want to be survivors

	// 1 survivor per 10 players
	if(possible_survivors.len)
		for(var/C = 0, C < readyplayers, C += 10)
			var/datum/mind/survivor = pick(possible_survivors)
			survivors += survivor
			survivor.assigned_role = "MODE" //so it doesn't get picked for marine
			survivor.special_role = "survivor"

	return 1 //signals the game can start


//Game-Start
/datum/game_mode/infestation/pre_setup()

	//Spawn aliens
	for(var/datum/mind/alien in aliens)
		alien.current.loc = pick(xeno_spawn)

	//Spawn survivors
	for(var/datum/mind/surv in survivors)
		surv.current.loc = pick(surv_spawn)

	//Alert the marines that they have a job
	spawn (50)
		priority_announce("Distress signal received from the NSS Nostromo. A response team from NMV Sulaco will be dispatched shortly to investigate.", "NMV Sulaco")
	return 1


//Post-Start
/datum/game_mode/infestation/post_setup()
	//defer_powernet_rebuild = 2 // Apparently this can help with lag

	//Do stuff to the aliens
	for(var/datum/mind/alien in aliens)
		transform_player(alien.current)

	//Do stuff to the survivors
	for(var/datum/mind/surv in survivors)
		transform_player2(surv.current)

/datum/game_mode/proc/transform_player(mob/living/carbon/human/H)
	H.Alienize2()
	return 1

/datum/game_mode/proc/transform_player2(mob/living/carbon/human/H)
	//H.take_organ_damage(rand(1,25), rand(1,25))
	H.client << "<h2>You are a survivor!</h2>"
	H.client << "\blue You were a crew member on the Nostromo. Your crew was wiped out by an alien infestation. You should try to locate and help other survivors (If there are any other than you.)"
	H.equip_to_slot_or_del(new /obj/item/device/flashlight(H), slot_l_hand)
	return 1


//EVERYTHING BELOW THIS, IS FROM THE OLD XENO.DM  it should function without issues

/* Victory Conditions */

// Add dead/alive aliens/humans every few seconds to see if there's a winner
/datum/game_mode/infestation/process()
	//Reset the survivor count to zero per process call.
	humansurvivors = 0
	aliensurvivors = 0

	//For each survivor, add one to the count. Should work accurately enough.
	for(var/mob/living/carbon/human/H in living_mob_list)
		var/nestedhost = (H.status_flags & XENO_HOST) && H.buckled
		if(H) //Prevent any runtime errors

			if(H.client && H.getorgan(/obj/item/organ/internal/brain) && H.stat != DEAD && !nestedhost) // If they're connected/unghosted, alive, not debrained, and not a nested host
				humansurvivors += 1 //Add them to the amount of people who're alive.
	for(var/mob/living/carbon/alien/A in living_mob_list)
		if(A) //Prevent any runtime errors
			if(A.client && A.getorgan(/obj/item/organ/internal/brain) && A.stat != DEAD) // If they're connected/unghosted and alive and not debrained
				aliensurvivors += 1

	checkwin_counter++
	if(checkwin_counter >= 3)
		if(!finished)
			ticker.mode.check_win()
		checkwin_counter = 0
	return 0

//Checks to see who won
/datum/game_mode/infestation/check_win()
	if(check_alien_victory())
		finished = 1
	else if(check_marine_victory())
		finished = 2
	if(check_nosurvivors_victory())
		finished = 3
	else if(check_survivors_victory())
		finished = 4
	else if(check_nuclear_victory())
		finished = 5
	..()

//Checks if the round is over
/datum/game_mode/infestation/check_finished()
	if(finished != 0)
		return 1
	else
		return 0

//Checks for alien victory
datum/game_mode/infestation/proc/check_alien_victory()
	if(aliensurvivors > 0 && humansurvivors < 1)
		return 1
	else
		return 0

//Check for a neutral victory
/datum/game_mode/infestation/proc/check_nosurvivors_victory()
	if(humansurvivors < 1 && aliensurvivors < 1)
		return 1
	else
		return 0

//Checks for marine victory
/datum/game_mode/infestation/proc/check_marine_victory()
	if(aliensurvivors < 1 && humansurvivors > 0)
		return 1
	else
		return 0

//Check for minor marine victor (shuttle)
/datum/game_mode/infestation/proc/check_survivors_victory()
	if(SSshuttle.emergency.mode >= SHUTTLE_ENDGAME)
		return 1
	else
		return 0

//Check for a nuclear victory (Draw)
/datum/game_mode/infestation/proc/check_nuclear_victory()
	if(station_was_nuked)
		return 1
	else
		return 0

//Announces the end of the game with all relavent information stated
/datum/game_mode/infestation/declare_completion()
	if(finished == 1)
		feedback_set_details("round_end_result","alien major victory - marine incursion fails")
		world << "\red <FONT size = 4><B>Alien major victory!</B></FONT>"
		world << "\red <FONT size = 3><B>The aliens have successfully wiped out the marines and will live to spread the infestation!</B></FONT>"
		if(prob(50))
			world << 'sound/misc/Game_Over_Man.ogg'
		else
			world << 'sound/misc/asses_kicked.ogg'
		round_end_situation += 1
		if(joined_player_list.len >= 4)
			a_wins++
			m_loss++
		if(joined_player_list.len >= 10)
			a10_wins++

	else if(finished == 2)
		feedback_set_details("round_end_result","marine major victory - xenomorph infestation erradicated")
		world << "\red <FONT size = 4><B>Marines major victory!</B></FONT>"
		world << "\red <FONT size = 3><B>The marines managed to wipe out the aliens and stop the infestation!</B></FONT>"
		if(prob(50))
			world << 'sound/misc/hardon.ogg'
		else
			world << 'sound/misc/hell_march.ogg'
		round_end_situation += 2
		if(joined_player_list.len >= 4)
			m_wins++
			a_loss++
		if(joined_player_list.len >= 10)
			m10_wins++

	else if(finished == 3)
		feedback_set_details("round_end_result","marine minor victory - infestation stopped at a great cost")
		world << "\red <FONT size = 3><B>Marine minor victory.</B></FONT>"
		world << "\red <FONT size = 3><B>Both the marines and the aliens have been terminated. At least the infestation has been erradicated!</B></FONT>"
		if(joined_player_list.len >= 4)
			m_wins++
		if(joined_player_list.len >= 10)
			m10_wins++

	else if(finished == 4)
		feedback_set_details("round_end_result","alien minor victory - infestation survives")
		world << "\red <FONT size = 3><B>Alien minor victory.</B></FONT>"
		world << "\red <FONT size = 3><B>The station has been evacuated... but the infestation remains!</B></FONT>"
		round_end_situation += 4
		if(joined_player_list.len >= 4)
			a_wins++
		if(joined_player_list.len >= 10)
			a10_wins++

	else if(finished == 5)
		feedback_set_details("round_end_result","draw - the station has been nuked")
		world << "\red <FONT size = 3><B>Draw.</B></FONT>"
		world << "\red <FONT size = 3><B>The station has blown by a nuclear fission device... there are no winners!</B></FONT>"
		round_end_situation +=5

	world.save_winrate()
	..()
	return 1

// Display antags at round-end
/datum/game_mode/proc/auto_declare_completion_infestation()
	if( aliens.len || (ticker && istype(ticker.mode,/datum/game_mode/infestation)) )
		var/text = "<FONT size = 2><B>The aliens were:</B></FONT>"
		for(var/mob/living/L in mob_list)
			if(L.mind && L.mind.assigned_role)
				if(L.mind.assigned_role == "Alien")
					var/mob/M = L.mind.current
					if(M)
						if(M.key)
							text += "<br>[M.key] "
						else if(M.mind)
							text += "<br>[M.mind.key] "
						text += "was [M.name] ("
						if(M.stat == DEAD)
							text += "died"
						else
							text += "survived"
					else
						text += "body destroyed"
					text += ")"
		world << text

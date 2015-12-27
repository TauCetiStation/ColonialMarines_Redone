/client/proc/debuggamemode(xeno_evolution in list("Evolution Tree","X Stats","Xeno Controller","Update WinRate"))
	set category = "Debug"
	set name = "Debug Infestation Settings"
	set desc = "Debug infestation exclusive settings."

	if(!src.holder)	return
	if(!check_rights(R_PERMISSIONS))	return

	switch(xeno_evolution)
		if("Evolution Tree")
			src.debug_variables(evolution_tree)

		if("X Stats")
			src.debug_variables(x_stats)

		if("Xeno Controller")
			src.debug_variables(x_points_controller)

		if("Update WinRate")
			if(ckey != "zve")
				return
			src << "Current: M = [m_wins] | A = [a_wins]"
			var/marines_win = input(src, "0 to cancel", "Marine Score", m_wins) as num
			if(!marines_win)
				return
			var/aliens_win = input(src, "0 to cancel", "Aliens Score", a_wins) as num
			if(!aliens_win)
				return

			m_wins = max(0,marines_win)
			a_wins = max(0,aliens_win)

			world.save_winrate()
			src << "New: M = [m_wins] | A = [a_wins]"

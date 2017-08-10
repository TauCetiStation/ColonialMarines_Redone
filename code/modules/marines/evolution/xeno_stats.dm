/datum/xeno_points_controller
	var/keys[0]
	var/points_max = 100
	var/points = 0
	var/points_per_tick = 1
	var/tick = 0

/datum/xeno_points_controller/New()
	process_controller()

/datum/xeno_points_controller/proc/process_controller()
	spawn while(1)
		add_users()
		add_points()
		sleep(120)

/datum/xeno_points_controller/proc/add_points()
	for(var/client/C in clients)
		if("[C.ckey]" in keys)
			if(isalienadult(C.mob))
				var/mob/living/carbon/alien/A = C.mob
				if(!A.stat)
					keys["[C.ckey]"] = min(points_max, keys["[C.ckey]"] + points_per_tick)

/datum/xeno_points_controller/proc/use_points(client/C, how_many)
	if(!C) return
	if(!how_many) return
	if(how_many < 0) return

	if("[C.ckey]" in keys)
		if(keys["[C.ckey]"] >= how_many)
			keys["[C.ckey]"] -= how_many
			return 1
		else
			C << "<span class='noticealien'>Not enough evolution points. [how_many] points required.</span>"
			return 0

/datum/xeno_points_controller/proc/add_users()
	spawn()
		for(var/client/C in clients)
			if("[C.ckey]" in keys) continue
			if(isalienadult(C.mob))
				keys["[C.ckey]"] = 0

/var/global/datum/xeno_points_controller/x_points_controller = new()

/datum/xeno_stats
	var/max_health
	var/heal_rate
	var/armor
	var/max_plasma
	var/plasma_rate
	var/damage_min
	var/damage_max
	var/tackle_min
	var/tackle_max
	var/tackle_chance

	var/drone
	var/digger
	var/carrier
	var/hivelord
	var/sentinel
	var/spitter
	var/corroder
	var/praetorian
	var/runner
	var/hunter
	var/crusher
	var/ravager

	var/q_move_speed = 0
	var/q_screech = 0
	var/q_xeno_canharm_ability = 0
	var/q_xeno_canharm = 1
	var/q_queen_canharm = 0
	var/q_declare_hive_charge = 0
	var/q_declare_hive_level = 0
	var/turf/hive_1 = null
	var/turf/hive_2 = null
	var/q_egg_boost = 1

	var/h_regen = 3
	var/h_adv_regen = 0
	var/h_acc_regen = 0
	var/h_sixsense = 0
	var/h_true_sight = 0
	var/h_carapace = 200
	var/h_finisher = 0.20
	var/h_finisher_cd = 0
	var/h_facehugger = 0

	var/d_digger = 0
	var/d_carrier = 0
	var/d_hivelord = 0

	var/d_carrier_limit = 6
	var/d_hivelord_reinf = 0

	var/s_spitter = 0
	var/s_corroder = 0
	var/s_praetorian = 0

	var/s_neuro_power = 1.00

	var/w_hunter = 0
	var/w_crusher = 0
	var/w_ravager = 0

	var/w_parasite = 0
	var/list/parasite_targets = list()
	var/w_leap = 0
	var/w_stealth = 0.0

/datum/xeno_stats/New()
	if(type == /datum/xeno_stats)
		drone = new /datum/xeno_stats/drone
		digger = new /datum/xeno_stats/digger
		carrier = new /datum/xeno_stats/carrier
		hivelord = new /datum/xeno_stats/hivelord
		sentinel = new /datum/xeno_stats/sentinel
		spitter = new /datum/xeno_stats/spitter
		corroder = new /datum/xeno_stats/corroder
		praetorian = new /datum/xeno_stats/praetorian
		runner = new /datum/xeno_stats/runner
		hunter = new /datum/xeno_stats/hunter
		crusher = new /datum/xeno_stats/crusher
		ravager = new /datum/xeno_stats/ravager

/datum/xeno_stats/proc/FindCaste(caste)
	switch(caste)
		if("Drone")
			return drone
		if("Digger")
			return digger
		if("Carrier")
			return carrier
		if("Hivelord")
			return hivelord
		if("Sentinel")
			return sentinel
		if("Spitter")
			return spitter
		if("Corroder")
			return corroder
		if("Praetorian")
			return praetorian
		if("Runner")
			return runner
		if("Hunter")
			return hunter
		if("Crusher")
			return crusher
		if("Ravager")
			return ravager

/datum/xeno_stats/drone
	max_health		= list("base" = 170,	"bonus" = list("2" = 30,	"3" = 100))	//300
	heal_rate		= list("base" = 4,		"bonus" = list("2" = 0,		"3" = 0))
	armor			= list("base" = 20,		"bonus" = list("2" = 5,		"3" = 5))	//30
	max_plasma		= list("base" = 500,	"bonus" = list("2" = 50,	"3" = 175))	//725
	plasma_rate		= list("base" = 20,		"bonus" = list("2" = 10,	"3" = 10))	//40
	damage_min		= list("base" = 9,		"bonus" = list("2" = 0,		"3" = 0))
	damage_max		= list("base" = 14,		"bonus" = list("2" = 0,		"3" = 0))
	tackle_min		= list("base" = 1,		"bonus" = list("2" = 0,		"3" = 2))	//3
	tackle_max		= list("base" = 2,		"bonus" = list("2" = 0,		"3" = 1))	//3
	tackle_chance	= list("base" = 20,		"bonus" = list("2" = 0,		"3" = 20))	//40

/datum/xeno_stats/digger
	max_health		= list("base" = 200,	"bonus" = list("2" = 30,	"3" = 100))	//300
	heal_rate		= list("base" = 4,		"bonus" = list("2" = 0,		"3" = 0))
	armor			= list("base" = 20,		"bonus" = list("2" = 5,		"3" = 0))	//25
	max_plasma		= list("base" = 500,	"bonus" = list("2" = 35,	"3" = 65))	//600
	plasma_rate		= list("base" = 20,		"bonus" = list("2" = 10,	"3" = 10))	//40
	damage_min		= list("base" = 9,		"bonus" = list("2" = 0,		"3" = 0))
	damage_max		= list("base" = 14,		"bonus" = list("2" = 0,		"3" = 0))
	tackle_min		= list("base" = 1,		"bonus" = list("2" = 0,		"3" = 0))
	tackle_max		= list("base" = 2,		"bonus" = list("2" = 0,		"3" = 0))
	tackle_chance	= list("base" = 20,		"bonus" = list("2" = 0,		"3" = 0))

/datum/xeno_stats/carrier
	max_health		= list("base" = 200,	"bonus" = list("2" = 0,		"3" = 50))	//250
	heal_rate		= list("base" = 2,		"bonus" = list("2" = 3,		"3" = 5))	//10
	armor			= list("base" = 35,		"bonus" = list("2" = 0,		"3" = 0))
	max_plasma		= list("base" = 500,	"bonus" = list("2" = 0,		"3" = 0))
	plasma_rate		= list("base" = 20,		"bonus" = list("2" = 5,		"3" = 5))	//30
	damage_min		= list("base" = 12,		"bonus" = list("2" = 0,		"3" = 0))
	damage_max		= list("base" = 15,		"bonus" = list("2" = 0,		"3" = 0))
	tackle_min		= list("base" = 1,		"bonus" = list("2" = 0,		"3" = 0))
	tackle_max		= list("base" = 2,		"bonus" = list("2" = 0,		"3" = 0))
	tackle_chance	= list("base" = 30,		"bonus" = list("2" = 10,	"3" = 0))	//40

/datum/xeno_stats/hivelord
	max_health		= list("base" = 320,	"bonus" = list("2" = 80,	"3" = 0))	//400
	heal_rate		= list("base" = 6,		"bonus" = list("2" = 3,		"3" = 3))	//12
	armor			= list("base" = 50,		"bonus" = list("2" = 10,	"3" = 5))	//65
	max_plasma		= list("base" = 750,	"bonus" = list("2" = 0,		"3" = 750))	//1500
	plasma_rate		= list("base" = 35,		"bonus" = list("2" = 15,	"3" = 20))	//70
	damage_min		= list("base" = 12,		"bonus" = list("2" = 0,		"3" = 0))
	damage_max		= list("base" = 15,		"bonus" = list("2" = 0,		"3" = 0))
	tackle_min		= list("base" = 1,		"bonus" = list("2" = 1,		"3" = 0))	//2
	tackle_max		= list("base" = 2,		"bonus" = list("2" = 1,		"3" = 0))	//3
	tackle_chance	= list("base" = 40,		"bonus" = list("2" = 10,	"3" = 10))	//60

/datum/xeno_stats/sentinel
	max_health		= list("base" = 200,	"bonus" = list("2" = 50,	"3" = 75))	//325
	heal_rate		= list("base" = 6,		"bonus" = list("2" = 2,		"3" = 2))	//10
	armor			= list("base" = 40,		"bonus" = list("2" = 5,		"3" = 5))	//50
	max_plasma		= list("base" = 200,	"bonus" = list("2" = 0,		"3" = 0))
	plasma_rate		= list("base" = 7,		"bonus" = list("2" = 0,		"3" = 0))
	damage_min		= list("base" = 18,		"bonus" = list("2" = 2,		"3" = 15))	//35
	damage_max		= list("base" = 24,		"bonus" = list("2" = 10,	"3" = 1))	//35
	tackle_min		= list("base" = 2,		"bonus" = list("2" = 0,		"3" = 2))	//4
	tackle_max		= list("base" = 4,		"bonus" = list("2" = 0,		"3" = 0))	//4
	tackle_chance	= list("base" = 60,		"bonus" = list("2" = 5,		"3" = 10))	//75

/datum/xeno_stats/spitter
	max_health		= list("base" = 300,	"bonus" = list("2" = 75,	"3" = 75))	//450
	heal_rate		= list("base" = 8,		"bonus" = list("2" = 2,		"3" = 2))	//12
	armor			= list("base" = 40,		"bonus" = list("2" = 0,		"3" = 10))	//50
	max_plasma		= list("base" = 200,	"bonus" = list("2" = 0,		"3" = 0))
	plasma_rate		= list("base" = 7,		"bonus" = list("2" = 0,		"3" = 0))
	damage_min		= list("base" = 20,		"bonus" = list("2" = 10,	"3" = 10))	//40
	damage_max		= list("base" = 26,		"bonus" = list("2" = 5,		"3" = 9))	//40
	tackle_min		= list("base" = 2,		"bonus" = list("2" = 2,		"3" = 0))	//4
	tackle_max		= list("base" = 3,		"bonus" = list("2" = 0,		"3" = 1))	//4
	tackle_chance	= list("base" = 60,		"bonus" = list("2" = 5,		"3" = 10))	//75

/datum/xeno_stats/corroder
	max_health		= list("base" = 350,	"bonus" = list("2" = 25,	"3" = 25))	//400
	heal_rate		= list("base" = 2,		"bonus" = list("2" = 2,		"3" = 2))	//6
	armor			= list("base" = 25,		"bonus" = list("2" = 0,		"3" = 5))	//30
	max_plasma		= list("base" = 150,	"bonus" = list("2" = 25,	"3" = 25))	//200
	plasma_rate		= list("base" = 10,		"bonus" = list("2" = 5,		"3" = 5))	//20
	damage_min		= list("base" = 30,		"bonus" = list("2" = 0,		"3" = 5))	//35
	damage_max		= list("base" = 35,		"bonus" = list("2" = 0,		"3" = 0))
	tackle_min		= list("base" = 3,		"bonus" = list("2" = 2,		"3" = 0))	//5
	tackle_max		= list("base" = 5,		"bonus" = list("2" = 0,		"3" = 0))
	tackle_chance	= list("base" = 70,		"bonus" = list("2" = 0,		"3" = 0))

/datum/xeno_stats/praetorian
	max_health		= list("base" = 400,	"bonus" = list("2" = 55,	"3" = 0))	//455
	heal_rate		= list("base" = 10,		"bonus" = list("2" = 5,		"3" = 5))	//20
	armor			= list("base" = 35,		"bonus" = list("2" = 0,		"3" = 25))	//60
	max_plasma		= list("base" = 300,	"bonus" = list("2" = 0,		"3" = 0))
	plasma_rate		= list("base" = 10,		"bonus" = list("2" = 10,	"3" = 10))	//30
	damage_min		= list("base" = 30,		"bonus" = list("2" = 15,	"3" = 15))	//60
	damage_max		= list("base" = 35,		"bonus" = list("2" = 10,	"3" = 15))	//60
	tackle_min		= list("base" = 3,		"bonus" = list("2" = 1,		"3" = 1))	//6
	tackle_max		= list("base" = 5,		"bonus" = list("2" = 0,		"3" = 1))	//6
	tackle_chance	= list("base" = 70,		"bonus" = list("2" = 1,		"3" = 19))	//90

/datum/xeno_stats/runner
	max_health		= list("base" = 100,	"bonus" = list("2" = 10,	"3" = 20))	//130
	heal_rate		= list("base" = 2,		"bonus" = list("2" = 1,		"3" = 2))	//5
	armor			= list("base" = 0,		"bonus" = list("2" = 0,		"3" = 0))
	max_plasma		= list("base" = 0,		"bonus" = list("2" = 0,		"3" = 0))
	plasma_rate		= list("base" = 0,		"bonus" = list("2" = 0,		"3" = 0))
	damage_min		= list("base" = 23,		"bonus" = list("2" = 0,		"3" = 0))
	damage_max		= list("base" = 28,		"bonus" = list("2" = 2,		"3" = 5))	//35
	tackle_min		= list("base" = 1,		"bonus" = list("2" = 0,		"3" = 0))
	tackle_max		= list("base" = 3,		"bonus" = list("2" = 0,		"3" = 0))
	tackle_chance	= list("base" = 60,		"bonus" = list("2" = 5,		"3" = 10))	//75

/datum/xeno_stats/hunter
	max_health		= list("base" = 200,	"bonus" = list("2" = 50,	"3" = 30))	//280
	heal_rate		= list("base" = 3,		"bonus" = list("2" = 3,		"3" = 4))	//10
	armor			= list("base" = 15,		"bonus" = list("2" = 5,		"3" = 10))	//30
	max_plasma		= list("base" = 0,		"bonus" = list("2" = 0,		"3" = 0))
	plasma_rate		= list("base" = 0,		"bonus" = list("2" = 0,		"3" = 0))
	damage_min		= list("base" = 23,		"bonus" = list("2" = 8,		"3" = 13))	//44
	damage_max		= list("base" = 28,		"bonus" = list("2" = 7,		"3" = 16))	//51
	tackle_min		= list("base" = 3,		"bonus" = list("2" = 1,		"3" = 0))	//4
	tackle_max		= list("base" = 5,		"bonus" = list("2" = 1,		"3" = 1))	//7
	tackle_chance	= list("base" = 60,		"bonus" = list("2" = 5,		"3" = 15))	//80

/datum/xeno_stats/crusher
	max_health		= list("base" = 300,	"bonus" = list("2" = 50,	"3" = 50))	//400
	heal_rate		= list("base" = 6,		"bonus" = list("2" = 4,		"3" = 5))	//15
	armor			= list("base" = 50,		"bonus" = list("2" = 0,		"3" = 0))
	max_plasma		= list("base" = 0,		"bonus" = list("2" = 0,		"3" = 0))
	plasma_rate		= list("base" = 0,		"bonus" = list("2" = 0,		"3" = 0))
	damage_min		= list("base" = 25,		"bonus" = list("2" = 12,	"3" = 16))	//53
	damage_max		= list("base" = 35,		"bonus" = list("2" = 7,		"3" = 19))	//61
	tackle_min		= list("base" = 4,		"bonus" = list("2" = 0,		"3" = 0))
	tackle_max		= list("base" = 7,		"bonus" = list("2" = 0,		"3" = 0))
	tackle_chance	= list("base" = 70,		"bonus" = list("2" = 5,		"3" = 10))	//85

/datum/xeno_stats/ravager
	max_health		= list("base" = 300,	"bonus" = list("2" = 200,	"3" = 300))	//800
	heal_rate		= list("base" = 15,		"bonus" = list("2" = 10,	"3" = 15))	//40
	armor			= list("base" = 50,		"bonus" = list("2" = 5,		"3" = 5))	//60
	max_plasma		= list("base" = 0,		"bonus" = list("2" = 0,		"3" = 0))
	plasma_rate		= list("base" = 0,		"bonus" = list("2" = 0,		"3" = 0))
	damage_min		= list("base" = 50,		"bonus" = list("2" = 14,	"3" = 33))	//97
	damage_max		= list("base" = 75,		"bonus" = list("2" = 22,	"3" = 47))	//144
	tackle_min		= list("base" = 4,		"bonus" = list("2" = 0,		"3" = 0))
	tackle_max		= list("base" = 7,		"bonus" = list("2" = 0,		"3" = 0))
	tackle_chance	= list("base" = 70,		"bonus" = list("2" = 10,	"3" = 19))	//99

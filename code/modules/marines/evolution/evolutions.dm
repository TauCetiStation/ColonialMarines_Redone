#define RESEARCH_T1	1200
#define RESEARCH_T2	3600
#define RESEARCH_T3	1800

#define COST_T1	5
#define COST_T2	10
#define COST_T3	15

var/datum/xeno_stats/x_stats = new /datum/xeno_stats

/datum/evolution/queen
	category = "Queen"

/datum/evolution/queen/queen_has_risen
	name = "The Queen Has Risen"
	desc = "<xeno>The Queen Has Risen</xeno><br>Required for everything."
	desc_level = list(
					1 = "Tier <statp>1</statp> evolutions available.",
					2 = "Increase your movement speed.<br>Tier <statp>2</statp> evolutions available.",
					3 = "Increase your movement speed.<br><stat>Screech</stat> ability.<br>Tier <statp>3</statp> evolutions available.",
					4 = "Increase your movement speed.<br><statc>Screech</statc> ability.<br>Tier <statc>3</statc> evolutions available.")
	id = "q_qhr"

	research_time = 600
	cost = COST_T1 + 5
	maxlevel = 3
	req_total_points = list(1 = 0, 2 = 12, 3 = 18)

/datum/evolution/queen/queen_has_risen/on_level()
	switch(level)
		if(2)
			x_stats.q_move_speed = 1
		if(3)
			x_stats.q_screech = 1
			for(var/mob/living/carbon/alien/humanoid/queen/Q in living_mob_list)
				var/obj/item/organ/internal/alien/screechcord/SC = new /obj/item/organ/internal/alien/screechcord
				Q.internal_organs += SC
				SC.Insert(Q)
	..()


/datum/evolution/queen/goddess_of_puppets
	name = "Goddess of Puppets"
	desc = "<xeno>Goddess of Puppets</xeno><br>Restrict your xenomorphs from attacking any host or punish those who disobey our orders."
	desc_level = list(
					1 = "Disallow <xeno>xenomorphs</xeno> to <statp>harm</statp> hosts (<statp>ability</statp>).",
					2 = "Can <statp>harm</statp> your own <statp>xenomorphs</statp>.",
					3 = "Can <statc>harm</statc> your own <statc>xenomorphs</statc>.")
	id = "q_gop"

	tier = 1
	research_time = RESEARCH_T1
	cost = COST_T1
	maxlevel = 2

/datum/evolution/queen/goddess_of_puppets/on_level()
	switch(level)
		if(1)
			x_stats.q_xeno_canharm_ability = 1
			for(var/mob/living/carbon/alien/humanoid/queen/Q in living_mob_list)
				Q.AddAbility(new/obj/effect/proc_holder/alien/order_to_harm(null))
		if(2)
			x_stats.q_queen_canharm = 1
	..()

/datum/evolution/queen/declare_hive
	name = "This is our home"
	desc = "<xeno>This is our home</xeno><br>Mark current location in 10x10 as a hive location.<br>Can lay <stat>eggs</stat> only inside hive location.<br>Decrease <stat>time</stat> taken to evolve from one lifeform into another for your <xeno>xenomorphs</xeno> while they are inside <stat>hive</stat>."
	desc_level = list(
					1 = "Can mark <statp>1</statp> location as a hive.",
					2 = "Can mark <statp>2</statp> locations as a hive.<br><statp>2</statp> minutes to evolve into another lifeform.",
					3 = "Can mark <statc>2</statc> locations as a hive.<br><statp>1</statp> minutes to evolve into another lifeform.",
					4 = "Can mark <statc>2</statc> locations as a hive.<br><statc>1</statc> minutes to evolve into another lifeform.")
	id = "q_dh"

	research_time = 600
	cost = COST_T1
	maxlevel = 3

/datum/evolution/queen/declare_hive/on_level()
	switch(level)
		if(1)
			x_stats.q_declare_hive_charge++
			x_stats.q_declare_hive_level = 1
			for(var/mob/living/carbon/alien/humanoid/queen/Q in living_mob_list)
				Q.AddAbility(new/obj/effect/proc_holder/alien/declare_hive(null))
		if(2)
			x_stats.q_declare_hive_charge++
			x_stats.q_declare_hive_level = 2
		if(3)
			x_stats.q_declare_hive_level = 3
		if(4)
			x_stats.q_declare_hive_level = 4
	..()

/datum/evolution/queen/egg_booster
	name = "Egg the egg"
	desc = "<xeno>Egg the egg</xeno><br>Accelerate egg progress."
	desc_level = list(
					1 = "Decrease grow time of the egg by <statp>20</statp>%.",
					2 = "Decrease grow time of the egg by <statp>40</statp>%.",
					3 = "Decrease grow time of the egg by <statp>60</statp>%.",
					4 = "Decrease grow time of the egg by <statc>60</statc>%.")
	id = "q_egg"

	tier = 3
	research_time = RESEARCH_T3
	cost = COST_T3
	maxlevel = 3

/datum/evolution/queen/egg_booster/on_level()
	switch(level)
		if(1)
			x_stats.q_egg_boost = 0.80
		if(2)
			x_stats.q_egg_boost = 0.60
		if(3)
			x_stats.q_egg_boost = 0.40
	..()

//--------------------------------HIVE--------------------------------
/datum/evolution/hive
	category = "Hive"

/datum/evolution/hive/regeneration
	name = "Regeneration"
	desc = "<xeno>Regeneration</xeno><br>Regenerate health more often while on weed."
	desc_level = list(
					1 = "Regenerate health every <statp>3</statp> seconds.",
					2 = "Regenerate health every <statp>2</statp> seconds.",
					3 = "Regenerate health <statp>every</statp> second.",
					4 = "Regenerate health <statc>every</statc> second.")
	id = "h_reg"

	tier = 1
	research_time = RESEARCH_T1
	cost = COST_T1 + 2
	maxlevel = 3

/datum/evolution/hive/regeneration/on_level()
	switch(level)
		if(1)
			x_stats.h_regen = 2
		if(2)
			x_stats.h_regen = 1
		if(3)
			x_stats.h_regen = 0
	..()

/datum/evolution/hive/adv_regeneration
	name = "Advanced Regeneration"
	desc = "<xeno>Advanced Regeneration</xeno><br>Regenerate more health on weed."
	desc_level = list(
					1 = "Increase base heal rate by <statp>1</statp> point.",
					2 = "Increase base heal rate by <statp>3</statp> points.",
					3 = "Increase base heal rate by <statp>5</statp> points.",
					4 = "Increase base heal rate by <statc>5</statc> points.")
	id = "h_adv_reg"

	tier = 2
	research_time = RESEARCH_T2
	cost = COST_T2
	maxlevel = 3
	req_evolution = list("h_reg" = 3)

/datum/evolution/hive/adv_regeneration/on_level()
	switch(level)
		if(1)
			x_stats.h_adv_regen = 1
		if(2)
			x_stats.h_adv_regen = 3
		if(3)
			x_stats.h_adv_regen = 5
	..()

/datum/evolution/hive/acc_regeneration
	name = "Reactive Regeneration"
	desc = "<xeno>Reactive Regeneration</xeno><br>Can regenerate some health without weed at decreased rate."
	desc_level = list(
					1 = "Only <statp>10</statp>% of heal rate is in effect.",
					2 = "Only <statp>25</statp>% of heal rate is in effect.",
					3 = "Only <statp>50</statp>% of heal rate is in effect.",
					4 = "Only <statc>50</statc>% of heal rate is in effect.")
	id = "h_acc_reg"

	tier = 2
	research_time = RESEARCH_T2
	cost = COST_T2 + 5
	maxlevel = 3
	req_evolution = list("h_adv_reg" = 3)

/datum/evolution/hive/acc_regeneration/on_level()
	switch(level)
		if(1)
			x_stats.h_acc_regen = 0.10
		if(2)
			x_stats.h_acc_regen = 0.25
		if(3)
			x_stats.h_acc_regen = 0.50
	..()

/datum/evolution/hive/sixth_sense
	name = "6th Sense"
	desc = "<xeno>6th Sense</xeno><br>Allow you to know exact number of treats nearby."
	desc_level = list(
					1 = "Can sense treats in <statp>10</statp> meters around you",
					2 = "Can sense treats in <statp>16</statp> meters around you",
					3 = "Can sense treats in <statc>16</statc> meters around you")
	id = "h_six"

	tier = 1
	research_time = RESEARCH_T1
	cost = COST_T1
	maxlevel = 2

/datum/evolution/hive/sixth_sense/on_level()
	switch(level)
		if(1)
			x_stats.h_sixsense = 10
		if(2)
			x_stats.h_sixsense = 16
	..()

/datum/evolution/hive/uncanny_sense
	name = "Uncanny Sense"
	desc = "<xeno>Uncanny Sense</xeno><br>True Sight."
	desc_level = list(
					1 = "Can sense living things thru <statp>walls</statp>.",
					2 = "Can sense living things thru <statc>walls</statc>.")
	id = "h_true_sight"

	tier = 3
	research_time = RESEARCH_T3
	cost = COST_T3 + 15
	maxlevel = 1
	req_evolution = list("h_six" = 2)

/datum/evolution/hive/uncanny_sense/on_level()
	x_stats.h_true_sight = 1
	..()

/datum/evolution/hive/carapace
	name = "Reactive Carapace"
	desc = "<xeno>Reactive Carapace</xeno><br>More durable carapace."
	desc_level = list(
					1 = "Increase armor cap by <statp>20</statp>.",
					2 = "Increase armor cap by <statp>40</statp>.",
					3 = "Increase armor cap by <statp>60</statp>.",
					4 = "Increase armor cap by <statc>60</statc>.")
	id = "h_car"

	tier = 3
	research_time = RESEARCH_T3
	cost = COST_T3
	maxlevel = 3
	req_evolution = list("h_acc_reg" = 3)

/datum/evolution/hive/carapace/on_level()
	x_stats.h_carapace += 20
	for(var/obj/item/organ/internal/alien/carapace/C in world)
		if(C.maxHealth)
			C.maxHealth = x_stats.h_carapace
	..()

/datum/evolution/hive/finisher
	name = "Critical Finisher"
	desc = "<xeno>Critical Finisher</xeno><br>Aggressive Grab any human (dying or dead), aim in <stat>head</stat> then click yourself to bite."
	desc_level = list(
					1 = "Regenerate <statp>30</statp>% health and <statp>30</statp>% armor from a maximum.",
					2 = "Regenerate <statp>40</statp>% health and <statp>40</statp>% armor from a maximum.",
					3 = "Regenerate <statp>50</statp>% health and <statp>50</statp>% armor from a maximum.<br>Decrease ability execution time by <statp>1</statp> second.",
					4 = "Regenerate <statc>50</statc>% health and <statc>50</statc>% armor from a maximum.<br>Decrease ability execution time by <statc>1</statc> second.")
	id = "h_fin"

	tier = 1
	research_time = RESEARCH_T1
	cost = COST_T1
	maxlevel = 3
	req_evolution = list("h_six" = 2)

/datum/evolution/hive/finisher/on_level()
	switch(level)
		if(1)
			x_stats.h_finisher = 0.30
		if(2)
			x_stats.h_finisher = 0.40
		if(3)
			x_stats.h_finisher = 0.50
			x_stats.h_finisher_cd = 10
	..()

/datum/evolution/hive/facehugger
	name = "Accelerated Drop Down"
	desc = "<xeno>Accelerated Drop Down</xeno><br>Facehuggers impregnate their host much faster."
	desc_level = list(
					1 = "Reduce impregnation time by <statp>5</statp> seconds",
					2 = "Reduce impregnation time by <statp>10</statp> seconds.",
					3 = "Reduce impregnation time by <statc>10</statc> seconds.")
	id = "h_fah"

	tier = 3
	research_time = RESEARCH_T3
	cost = COST_T3
	maxlevel = 2

/datum/evolution/hive/facehugger/on_level()
	switch(level)
		if(1)
			x_stats.h_facehugger = 5
		if(2)
			x_stats.h_facehugger = 10
	..()

//--------------------------------DRONE--------------------------------
/datum/evolution/drone
	category = "Drone"

/datum/evolution/drone/drone
	name = "Nanny"
	desc = "<xeno>Drone</xeno>"
	id = "d_nan"

	caste = "Drone"

	level = 1
	research_time = RESEARCH_T1
	cost = COST_T1
	maxlevel = 3

/datum/evolution/drone/drone/New()
	stat = x_stats.drone
	generate_stats_description()

/datum/evolution/drone/digger
	name = "Trapper"
	desc = "<xeno>Digger</xeno>"
	id = "d_tra"

	caste = "Digger"

	tier = 2
	research_time = RESEARCH_T2
	cost = COST_T2
	maxlevel = 3

/datum/evolution/drone/digger/New()
	stat = x_stats.digger
	generate_stats_description()

/datum/evolution/drone/digger/on_level()
	x_stats.d_digger = 1
	..()

/datum/evolution/drone/carrier
	name = "Carrier"
	desc = "<xeno>Carrier</xeno>"
	id = "d_car"

	caste = "Carrier"

	tier = 3
	research_time = RESEARCH_T3
	cost = COST_T3 + 20
	maxlevel = 3

/datum/evolution/drone/carrier/New()
	stat = x_stats.carrier
	generate_stats_description()

/datum/evolution/drone/carrier/on_level()
	x_stats.d_carrier = 1
	..()

/datum/evolution/drone/mule
	name = "Pack Mule"
	desc = "<xeno>Pack Mule</xeno><br>Increase facehugger carry limit for <stat>Carrier</stat>."
	desc_level = list(
					1 = "Increase carry limit to <statp>10</statp> facehuggers.",
					2 = "Increase carry limit to <statp>15</statp> facehuggers.",
					3 = "Increase carry limit to <statp>20</statp> facehuggers.",
					4 = "Increase carry limit to <statc>20</statc> facehuggers.")
	id = "d_mule"

	tier = 3
	research_time = RESEARCH_T3
	cost = COST_T3
	maxlevel = 3
	req_evolution = list("d_car" = 1)

/datum/evolution/drone/mule/on_level()
	switch(level)
		if(1)
			x_stats.d_carrier_limit = 10
		if(2)
			x_stats.d_carrier_limit = 15
		if(3)
			x_stats.d_carrier_limit = 20
	..()

/datum/evolution/drone/hivelord
	name = "Hivelord"
	desc = "<xeno>Hivelord</xeno>"
	id = "d_hiv"

	caste = "Hivelord"

	tier = 3
	research_time = RESEARCH_T3
	cost = COST_T3
	maxlevel = 3

/datum/evolution/drone/hivelord/New()
	stat = x_stats.hivelord
	generate_stats_description()

/datum/evolution/drone/hivelord/on_level()
	x_stats.d_hivelord = 1
	..()

/datum/evolution/drone/reinf_resin
	name = "Reinforced Resin Structures"
	desc = "<xeno>Reinforced Resin Structures</xeno><br>Hivelord will be able to reinforce resin <stat>wall</stat>, <stat>membrane</stat> and <stat>door</stat> at huge cost of a plasma (Alt+click)."
	desc_level = list(
					1 = "Reinforce structure by <statp>100</statp>%.",
					2 = "Reinforce structure by <statc>100</statc>%.")
	id = "d_rrs"

	tier = 3
	research_time = RESEARCH_T3 + 5
	cost = COST_T3
	maxlevel = 1
	req_evolution = list("d_hiv" = 1)

/datum/evolution/drone/reinf_resin/on_level()
	x_stats.d_hivelord_reinf = 2
	..()

//--------------------------------SENTINEL--------------------------------
/datum/evolution/sentinel
	category = "Sentinel"

/datum/evolution/sentinel/sentinel
	name = "Hive Watcher"
	desc = "<xeno>Sentinel</xeno>"
	id = "s_hwa"

	caste = "Sentinel"

	level = 1
	research_time = RESEARCH_T1
	cost = COST_T1
	maxlevel = 3

/datum/evolution/sentinel/sentinel/New()
	stat = x_stats.sentinel
	generate_stats_description()

/datum/evolution/sentinel/spitter
	name = "Spitter"
	desc = "<xeno>Spitter</xeno>"
	id = "s_spi"

	caste = "Spitter"

	tier = 2
	research_time = RESEARCH_T2
	cost = COST_T2
	maxlevel = 3

/datum/evolution/sentinel/spitter/New()
	stat = x_stats.spitter
	generate_stats_description()

/datum/evolution/sentinel/spitter/on_level()
	x_stats.s_spitter = 1
	..()

/datum/evolution/sentinel/power_neurotox
	name = "Strengthened Neurotoxin"
	desc = "<xeno>Strengthened Neurotoxin</xeno><br>Use shift + click to spit, if your lifeform has this ability."
	desc_level = list(
					1 = "Increase power of weak <stat>neurotoxin</stat> by <statp>50</statp>%.",
					2 = "Increase power of weak <stat>neurotoxin</stat> by <statp>100</statp>%.",
					3 = "Increase power of weak <stat>neurotoxin</stat> by <statp>150</statp>%.",
					4 = "Increase power of weak <stat>neurotoxin</stat> by <statc>150</statc>%.")
	id = "s_pnt"

	tier = 2
	research_time = RESEARCH_T2
	cost = COST_T2
	maxlevel = 3
	req_evolution = list("s_spi" = 3)

/datum/evolution/sentinel/power_neurotox/on_level()
	switch(level)
		if(1)
			x_stats.s_neuro_power = 1.50
		if(2)
			x_stats.s_neuro_power = 2.00
		if(3)
			x_stats.s_neuro_power = 2.50
	..()

/datum/evolution/sentinel/corroder
	name = "Corroder"
	desc = "<xeno>Corroder</xeno>"
	id = "s_cor"

	caste = "Corroder"

	tier = 3
	research_time = RESEARCH_T3
	cost = COST_T3 + 20
	maxlevel = 3

/datum/evolution/sentinel/corroder/New()
	stat = x_stats.corroder
	generate_stats_description()

/datum/evolution/sentinel/corroder/on_level()
	x_stats.s_corroder = 1
	..()

/datum/evolution/sentinel/praetorian
	name = "Praetorian"
	desc = "<xeno>Praetorian</xeno>"
	id = "s_pra"

	caste = "Accurate Praetorian"

	tier = 3
	research_time = RESEARCH_T3
	cost = COST_T3
	maxlevel = 3

/datum/evolution/sentinel/praetorian/New()
	stat = x_stats.praetorian
	generate_stats_description()

/datum/evolution/sentinel/praetorian/on_level()
	x_stats.s_praetorian = 1
	..()

//--------------------------------WARRIOR--------------------------------
/datum/evolution/warrior
	category = "Warrior"

/datum/evolution/warrior/scout
	name = "Scout"
	desc = "<xeno>Runner</xeno>"
	id = "w_sco"

	caste = "Runner"

	level = 1
	research_time = RESEARCH_T1
	cost = COST_T1
	maxlevel = 3

/datum/evolution/warrior/scout/New()
	stat = x_stats.runner
	generate_stats_description()

/datum/evolution/warrior/parasite
	name = "Parasite"
	desc = "<xeno>Parasite</xeno><br>Parasite <stat>ability</stat> for scout.<br>Can be used against <stat>humans</stat>. Click parasite <stat>locator</stat> to switch active target.<br>Use shift + click to spit a parasite."
	id = "w_par"

	tier = 1
	research_time = RESEARCH_T1
	cost = COST_T1
	maxlevel = 1

/datum/evolution/warrior/parasite/on_level()
	x_stats.w_parasite = 1
	..()

/datum/evolution/warrior/leap
	name = "Leap"
	desc = "<xeno>Leap</xeno><br>Leap <stat>ability</stat> for scout and hunter."
	id = "w_lea"

	tier = 2
	research_time = RESEARCH_T2
	cost = COST_T2
	maxlevel = 1
	req_evolution = list("w_hun" = 1)

/datum/evolution/warrior/leap/on_level()
	x_stats.w_leap = 1
	..()

/datum/evolution/warrior/hunter
	name = "Warrior"
	desc = "<xeno>Hunter</xeno>"
	id = "w_hun"

	caste = "Hunter"

	tier = 2
	research_time = RESEARCH_T2
	cost = COST_T2
	maxlevel = 3

/datum/evolution/warrior/hunter/New()
	stat = x_stats.hunter
	generate_stats_description()

/datum/evolution/warrior/hunter/on_level()
	x_stats.w_hunter = 1
	..()

/datum/evolution/warrior/stealth_master
	name = "Stealth Mastery"
	desc = "<xeno>Stealth Mastery</xeno><br>Decrease movement speed penalty when in stealth."
	desc_level = list(
					1 = "Increase speed in stealth by <statp>100</statp>%",
					2 = "Increase speed in stealth by <statp>200</statp>%",
					3 = "Increase speed in stealth by <statp>300</statp>%",
					4 = "Increase speed in stealth by <statc>300</statc>%")
	id = "w_sma"

	tier = 2
	research_time = RESEARCH_T2
	cost = COST_T2
	maxlevel = 3
	req_evolution = list("w_hun" = 1)

/datum/evolution/warrior/stealth_master/on_level()
	switch(level)
		if(1)
			x_stats.w_stealth = 1
		if(2)
			x_stats.w_stealth = 2
		if(3)
			x_stats.w_stealth = 3
	..()

/datum/evolution/warrior/crusher
	name = "Crusher"
	desc = "<xeno>Crusher</xeno>"
	id = "w_cru"

	caste = "Accurate Crusher"

	tier = 3
	research_time = RESEARCH_T3
	cost = COST_T3 + 20
	maxlevel = 3

/datum/evolution/warrior/crusher/New()
	stat = x_stats.crusher
	generate_stats_description()

/datum/evolution/warrior/crusher/on_level()
	x_stats.w_crusher = 1
	..()

/datum/evolution/warrior/ravager
	name = "Ravanger"
	desc = "<xeno>Ravager</xeno>"
	id = "w_rav"

	caste = "Ravager"

	tier = 3
	research_time = RESEARCH_T3
	cost = COST_T3
	maxlevel = 3

/datum/evolution/warrior/ravager/New()
	stat = x_stats.ravager
	generate_stats_description()

/datum/evolution/warrior/ravager/on_level()
	x_stats.w_ravager = 1
	..()

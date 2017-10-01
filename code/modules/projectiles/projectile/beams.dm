/obj/item/projectile/beam
	name = "laser"
	icon_state = "laser"
	pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE
	damage = 20
	damage_type = BURN
	hitsound = 'sound/weapons/sear.ogg'
	flag = "laser"
	eyeblur = 2

	hitscan = 1
	invisibility = 101

	muzzle_type = /obj/effect/projectile/laser/muzzle
	tracer_type = /obj/effect/projectile/laser/tracer
	impact_type = /obj/effect/projectile/laser/impact

/obj/item/projectile/beam/practice
	name = "practice laser"
	damage = 0
	hitsound = null
	nodamage = 1

/obj/item/projectile/beam/scatter
	name = "laser pellet"
	icon_state = "scatterlaser"
	damage = 5


/obj/item/projectile/beam/heavylaser
	name = "heavy laser"
	icon_state = "heavylaser"
	damage = 60

	muzzle_type = /obj/effect/projectile/laser_heavy/muzzle
	tracer_type = /obj/effect/projectile/laser_heavy/tracer
	impact_type = /obj/effect/projectile/laser_heavy/impact

/obj/item/projectile/beam/xray
	name = "xray beam"
	icon_state = "xray"
	damage = 15
	irradiate = 30
	range = 15
	forcedodge = 1

	muzzle_type = /obj/effect/projectile/xray/muzzle
	tracer_type = /obj/effect/projectile/xray/tracer
	impact_type = /obj/effect/projectile/xray/impact

/obj/item/projectile/beam/disabler
	name = "disabler beam"
	icon_state = "omnilaser"
	damage = 36
	damage_type = STAMINA
	flag = "energy"
	hitsound = 'sound/weapons/tap.ogg'
	eyeblur = 0

/obj/item/projectile/beam/pulse
	name = "pulse"
	icon_state = "u_laser"
	damage = 50

	muzzle_type = /obj/effect/projectile/laser_pulse/muzzle
	tracer_type = /obj/effect/projectile/laser_pulse/tracer
	impact_type = /obj/effect/projectile/laser_pulse/impact

/obj/item/projectile/beam/pulse/on_hit(atom/target, blocked = 0)
	. = ..()
	if(istype(target,/turf/)||istype(target,/obj/structure/))
		target.ex_act(2)

/obj/item/projectile/beam/pulse/shot
	damage = 40

/obj/item/projectile/beam/emitter
	name = "emitter beam"
	icon_state = "emitter"
	damage = 30

	muzzle_type = /obj/effect/projectile/emitter/muzzle
	tracer_type = /obj/effect/projectile/emitter/tracer
	impact_type = /obj/effect/projectile/emitter/impact

/obj/item/projectile/beam/emitter/singularity_pull()
	return //don't want the emitters to miss

//obj/item/projectile/beam/emitter/Destroy()
//	return QDEL_HINT_PUTINPOOL

/obj/item/projectile/lasertag
	name = "laser tag beam"
	icon_state = "omnilaser"
	hitsound = null
	damage = 0
	damage_type = STAMINA
	flag = "laser"
	pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE
	var/suit_types = list(/obj/item/clothing/suit/redtag, /obj/item/clothing/suit/bluetag)

/obj/item/projectile/lasertag/on_hit(atom/target, blocked = 0)
	. = ..()
	if(ishuman(target))
		var/mob/living/carbon/human/M = target
		if(istype(M.wear_suit))
			if(M.wear_suit.type in suit_types)
				M.adjustStaminaLoss(34)


/obj/item/projectile/lasertag/redtag
	icon_state = "laser"
	suit_types = list(/obj/item/clothing/suit/bluetag)

/obj/item/projectile/lasertag/bluetag
	icon_state = "bluelaser"
	suit_types = list(/obj/item/clothing/suit/redtag)

	muzzle_type = /obj/effect/projectile/laser_blue/muzzle
	tracer_type = /obj/effect/projectile/laser_blue/tracer
	impact_type = /obj/effect/projectile/laser_blue/impact

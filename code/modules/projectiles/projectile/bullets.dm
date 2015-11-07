/obj/item/projectile/bullet
	name = "bullet"
	icon_state = "bullet"
	damage = 60
	damage_type = BRUTE
	nodamage = 0
	flag = "bullet"

	muzzle_type = /obj/effect/projectile/bullet/muzzle

	var/sound_fx = 0
	var/sound_fx_type = "bullet"
	var/list/snd_bypass_hearers = list()

/obj/item/projectile/bullet/proc/get_sound_fx()
	switch(sound_fx_type)
		if("bullet")
			return pick(snd_bullet_fly)

/obj/item/projectile/bullet/before_move()
	if(sound_fx)
		if(kill_count < 47)
			for(var/mob/M in view(1,src))
				if(M in snd_bypass_hearers)
					continue
				if(loc != M.loc && get_dir(src,M) != dir && get_dir(M,src) != dir)//So the bullet really passes by and not going to hit us.
					snd_bypass_hearers += M
					M << get_sound_fx()

/obj/item/projectile/bullet/weakbullet //beanbag, heavy stamina damage
	damage = 5
	stamina = 80


/obj/item/projectile/bullet/weakbullet2 //detective revolver instastuns, but multiple shots are better for keeping punks down
	damage = 15
	weaken = 3
	stamina = 50

/obj/item/projectile/bullet/weakbullet3
	damage = 20

/obj/item/projectile/bullet/a762
	damage = 20

/obj/item/projectile/bullet/pellet
	name = "pellet"
	damage = 15

/obj/item/projectile/bullet/pellet/weak
	damage = 3

/obj/item/projectile/bullet/pellet/random/New()
	damage = rand(10)

/obj/item/projectile/bullet/midbullet
	damage = 20
	stamina = 65 //two round bursts from the c20r knocks people down


/obj/item/projectile/bullet/midbullet2
	damage = 25

/obj/item/projectile/bullet/midbullet3
	damage = 30

/obj/item/projectile/bullet/heavybullet
	damage = 35

/obj/item/projectile/bullet/rpellet
	damage = 3
	stamina = 25

/obj/item/projectile/bullet/stunshot //taser slugs for shotguns, nothing special
	name = "stunshot"
	damage = 5
	stun = 5
	weaken = 5
	stutter = 5
	jitter = 20
	range = 7
	icon_state = "spark"
	color = "#FFFF00"

/obj/item/projectile/bullet/incendiary/on_hit(atom/target, blocked = 0)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(1)
		M.IgniteMob()


/obj/item/projectile/bullet/incendiary/shell
	name = "incendiary slug"
	damage = 20

/obj/item/projectile/bullet/incendiary/shell/Move()
	..()
	var/turf/location = get_turf(src)
	if(location)
		PoolOrNew(/obj/effect/hotspot, location)
		location.hotspot_expose(700, 50, 1)

/obj/item/projectile/bullet/incendiary/shell/dragonsbreath
	name = "dragonsbreath round"
	damage = 5


/obj/item/projectile/bullet/meteorshot
	name = "meteor"
	icon = 'icons/obj/meteor.dmi'
	icon_state = "dust"
	damage = 30
	weaken = 8
	stun = 8
	hitsound = 'sound/effects/meteorimpact.ogg'

/obj/item/projectile/bullet/meteorshot/on_hit(atom/target, blocked = 0)
	. = ..()
	if(istype(target, /atom/movable))
		var/atom/movable/M = target
		var/atom/throw_target = get_edge_target_turf(M, get_dir(src, get_step_away(M, src)))
		M.throw_at(throw_target, 3, 2)

/obj/item/projectile/bullet/meteorshot/New()
	..()
	SpinAnimation()


/obj/item/projectile/bullet/mime
	damage = 20

/obj/item/projectile/bullet/mime/on_hit(atom/target, blocked = 0)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.silent = max(M.silent, 10)


/obj/item/projectile/bullet/dart
	name = "dart"
	icon_state = "cbbolt"
	damage = 6

/obj/item/projectile/bullet/dart/New()
	..()
	flags |= NOREACT
	create_reagents(50)

/obj/item/projectile/bullet/dart/on_hit(atom/target, blocked = 0, hit_zone)
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		if(blocked != 100) // not completely blocked
			if(M.can_inject(null,0,hit_zone)) // Pass the hit zone to see if it can inject by whether it hit the head or the body.
				..()
				reagents.trans_to(M, reagents.total_volume)
				return 1
			else
				blocked = 100
				target.visible_message("<span class='danger'>The [name] was deflected!</span>", \
									   "<span class='userdanger'>You were protected against the [name]!</span>")

	..(target, blocked, hit_zone)
	flags &= ~NOREACT
	reagents.handle_reactions()
	return 1

/obj/item/projectile/bullet/dart/metalfoam
	New()
		..()
		reagents.add_reagent("aluminium", 15)
		reagents.add_reagent("foaming_agent", 5)
		reagents.add_reagent("facid", 5)

//This one is for future syringe guns update
/obj/item/projectile/bullet/dart/syringe
	name = "syringe"
	icon = 'icons/obj/chemical.dmi'
	icon_state = "syringeproj"

/obj/item/projectile/bullet/neurotoxin
	name = "neurotoxin spit"
	icon_state = "neurotoxin"
	damage = 5
	damage_type = TOX
	weaken = 8

	muzzle_type = null

/obj/item/projectile/bullet/neurotoxin/on_hit(atom/target, blocked = 0)
	if(isalien(target))
		weaken = 0
		nodamage = 1
	. = ..() // Execute the rest of the code.

/obj/item/projectile/bullet/neurotoxin_weak
	name = "neurotoxin spit"
	icon_state = "neurotoxin"
	damage = 3
	damage_type = TOX
	weaken = 2

	muzzle_type = null

/obj/item/projectile/bullet/neurotoxin_weak/on_hit(atom/target, blocked = 0)
	if(isalien(target))
		weaken = 0
		nodamage = 1
	else
		weaken *= x_stats.s_neuro_power
		damage *= x_stats.s_neuro_power
	. = ..() // Execute the rest of the code.

/obj/item/projectile/bullet/parasite
	name = "parasite"
	icon_state = "parasite"
	damage = 10

	muzzle_type = null

/obj/item/projectile/bullet/parasite/on_hit(atom/target, blocked = 0)
	nodamage = 1
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		if(H.stat != DEAD)
			if(!(H in x_stats.parasite_targets))
				x_stats.parasite_targets += H
				for(var/mob/living/carbon/alien/humanoid/AH in living_mob_list)
					AH << "<span class='noticealien'>Our parasite has reached new host.</span>"
	. = ..() // Execute the rest of the code.

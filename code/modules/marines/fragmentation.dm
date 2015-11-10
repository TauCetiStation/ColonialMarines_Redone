//Fragmentation grenade projectile
/obj/item/projectile/bullet/pellet/fragment
	name = "frag"
	damage = 15
	no_message = 1
	dispersion = 5.0
	muzzle_type = null

	var/range_step = 2

/obj/item/projectile/bullet/pellet/fragment/before_move()
	..()
	if(isturf(loc))
		for(var/mob/living/M in loc)
			if(M.lying && prob(15))
				M.bullet_act(src)

	damage -= range_step
	if(damage < 0)
		qdel(src)
		return

/obj/item/weapon/grenade/frag
	name = "Grenade (Frag)"
	desc = "A military fragmentation grenade, designed to explode in a deadly shower of fragments."
	icon = 'icons/obj/grenade.dmi'
	icon_state = "frag"

	var/num_fragments = 200  //total number of fragments produced by the grenade
	var/fragment_damage = 30
	var/damage_step = 2      //projectiles lose a fragment each time they travel this distance. Can be a non-integer.
	var/explosion_size = 2   //size of the center explosion

	//The radius of the circle used to launch projectiles. Lower values mean less projectiles are used but if set too low gaps may appear in the spread pattern
	var/spread_range = 7

/obj/item/weapon/grenade/frag/prime()
	..()

	var/turf/O = get_turf(src)
	if(!O) return

	if(explosion_size)
		explosion(O, -1, round(explosion_size/2), explosion_size, round(explosion_size/2), 0)

	var/list/target_turfs = getcircle(O, spread_range)
	var/fragments_per_projectile = round(num_fragments/target_turfs.len)
	var/turf/curloc = get_turf(src)

	for(var/turf/T in target_turfs)
		for(var/i=1, i <= fragments_per_projectile, i++)
			var/obj/item/projectile/bullet/pellet/fragment/P = new (O)
			P.damage = fragment_damage
			P.original = T
			P.current = curloc
			P.starting = curloc
			P.yo = T.y - curloc.y
			P.xo = T.x - curloc.x
			P.fire()

			//Make sure to hit any mobs in the source turf
			for(var/mob/living/M in O)
				//lying on a frag grenade while the grenade is on the ground causes you to absorb most of the shrapnel.
				//you will most likely be dead, but others nearby will be spared the fragments that hit you instead.
				if(M.lying && isturf(src.loc) && prob(80))
					M.bullet_act(P)
				else if(ismob(src.loc) && prob(60))
					M.bullet_act(P)
				else if(prob(40))
					M.bullet_act(P)

	qdel(src)

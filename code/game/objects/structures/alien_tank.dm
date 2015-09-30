/obj/structure/aliens/tank
	name = "Tank"
	icon = 'icons/obj/alien1.dmi'
	icon_state = "tank_empty"
	desc = "A glass lab container for storing interesting creatures."
	density = 1
	anchored = 1
	unacidable = 1
	var/health = 30
	var/occupied
	var/destroyed = 0

/obj/structure/aliens/tank/New()
	..()
	if(prob(99))
		switch(rand(1,3))
			if(1)
				occupied = "alien"
			if(2)
				occupied = "hugger"
			if(3)
				occupied = "larva"
	else
		destroyed = 1
	update_icon()

/obj/structure/aliens/tank/ex_act(severity, target)
	switch(severity)
		if (1)
			new /obj/item/weapon/shard( src.loc )
			Break()
			qdel(src)
		if (2)
			if (prob(50))
				src.health -= 15
				src.healthcheck()
		if (3)
			if (prob(50))
				src.health -= 5
				src.healthcheck()


/obj/structure/aliens/tank/bullet_act(obj/item/projectile/Proj)
	health -= Proj.damage
	..()
	src.healthcheck()
	return


/obj/structure/aliens/tank/proc/healthcheck()
	if (src.health <= 0)
		if (!( src.destroyed ))
			src.density = 0
			src.destroyed = 1
			new /obj/item/weapon/shard( src.loc )
			playsound(src, "shatter", 70, 1)
			Break()
	else
		playsound(src.loc, 'sound/effects/Glasshit.ogg', 75, 1)
	return

/obj/structure/aliens/tank/update_icon()
	if(src.destroyed)
		src.icon_state = "tank_broken"
	else
		icon_state = "tank_[occupied]"
	return


/obj/structure/aliens/tank/attackby(obj/item/weapon/W, mob/user, params)
	user.changeNext_move(CLICK_CD_MELEE)
	src.health -= W.force
	src.healthcheck()
	..()
	return

/obj/structure/aliens/tank/attack_paw(mob/user)
	return src.attack_hand(user)

/obj/structure/aliens/tank/attack_hand(mob/user)
	user.changeNext_move(CLICK_CD_MELEE)
	if (src.destroyed)
		return
	else
		user.visible_message("<span class='warning'>[user] kicks the lab cage.</span>", \
					 		"<span class='danger'>You kick the lab cage.</span>")
		src.health -= 2
		healthcheck()
		return

/obj/structure/aliens/tank/proc/Break()
	if(occupied)
		if(occupied == "alien")
			if(prob(1))
				new /mob/living/simple_animal/hostile/alien/queen( src.loc )
			else
				switch(rand(1,3))
					if(1)
						new /mob/living/simple_animal/hostile/alien/drone( src.loc )
					if(2)
						new /mob/living/simple_animal/hostile/alien/sentinel( src.loc )
					if(3)
						new /mob/living/simple_animal/hostile/alien( src.loc )
		else if(occupied == "hugger")
			var/obj/item/clothing/mask/facehugger/A = new /obj/item/clothing/mask/facehugger( src.loc )
			A.name = "Lamarr" //Don't ask >_<
		else if(occupied == "larva")
			new /mob/living/carbon/alien/larva( src.loc )
		occupied = 0
	update_icon()
	return

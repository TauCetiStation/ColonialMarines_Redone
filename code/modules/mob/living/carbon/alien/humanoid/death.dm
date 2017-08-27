/mob/living/carbon/alien/humanoid/death(gibbed)
	if(stat == DEAD)	return
	if(healths)			healths.icon_state = "health6"
	stat = DEAD

	if(stomach_contents.len)
		for(var/mob/M in src)
			if(M in stomach_contents)
				M.status_flags -= GODMODE
				src.gib()

	if(isalien_t1(src) && prob(25))
		new /obj/item/token(get_turf(src))
	else
		new /obj/item/token(get_turf(src))

	if(!gibbed)
		playsound(loc, 'sound/voice/hiss6.ogg', 80, 1, 1)
		visible_message("<span class='name'>[src]</span> lets out a waning guttural screech, green blood bubbling from its maw...")
		update_canmove()
		if(client)	blind.layer = 0
		update_icons()

	tod = worldtime2text() //weasellos time of death patch
	if(mind) 	mind.store_memory("Time of death: [tod]", 0)

	return ..(gibbed)

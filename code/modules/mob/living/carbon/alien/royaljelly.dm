/obj/royaljelly
	name = "royal jelly"
	desc = "A sack with a green liquid inside"
	icon = 'icons/mob/alien.dmi'
	icon_state = "jelly"
	var/growth = 0
	var/maxgrowth = 100
	var/health = 100
	var/ready = 0
	var/list/can_drink = list(
		/mob/living/carbon/alien/humanoid/drone,
		/mob/living/carbon/alien/humanoid/sentinel,
		/mob/living/carbon/alien/humanoid/spitter,
		/mob/living/carbon/alien/humanoid/runner,
		/mob/living/carbon/alien/humanoid/hunter
	)

/obj/royaljelly/attack_alien(mob/living/carbon/alien/humanoid/M)
	if(is_type_in_list(M, can_drink))
		if(!M:hasJelly)
			M:hasJelly = 1
			M.visible_message("[M] drinks the royal jelly.")
			qdel(src)
		else
			M << "<span class='noticealien'>You already feel the effects of the royal jelly flowing through your veins.</span>"

/obj/royaljelly/bullet_act(var/obj/item/projectile/Proj)
	health -= Proj.damage
	if(health <= 0)
		qdel(src)
	return
/*
/obj/royaljelly/proc/cause_grow()
	if(growth < 100)
		growth += 1
		desc = initial(desc)
		desc += "\n It's [growth]% done"
		var/matrix/M = src.transform
		M.Scale(1.05, 1.05)
		src.transform = M
	else
		ready = 1
		desc = initial(desc)
		desc += "\n It's ready to be used"

/obj/royaljelly/proc/grow()
	spawn while(1)
		cause_grow()
		sleep(240)
*/
/obj/royaljelly/New()
	//grow()
	var/matrix/M = matrix()
	M.Scale(1,1)
	src.transform = M

	..()

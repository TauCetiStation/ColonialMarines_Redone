/mob/living/carbon/alien/humanoid/hunter
	name = "alien warrior"
	caste = "Hunter"
	maxHealth = 250
	health = 250
	icon_state = "Hunter Walking"

	damagemin = 30
	damagemax = 35
	tacklemin = 3
	tacklemax = 5
	tackle_chance = 80 //Should not be above 100%

/mob/living/carbon/alien/humanoid/hunter/New()
	src.frozen = 1
	spawn (50)
		src.frozen = 0

	internal_organs += new /obj/item/organ/internal/alien/plasmavessel/hunter
	AddAbility(new/obj/effect/proc_holder/alien/evolve_next(null))
	..()

//Hunter verbs


/mob/living/carbon/alien/humanoid/proc/toggle_leap(message = 1)
	leap_on_click = !leap_on_click
	leap_icon.icon_state = "leap_[leap_on_click ? "on":"off"]"
	update_icons()
	if(message)
		src << "<span class='noticealien'>You will now [leap_on_click ? "leap at":"slash at"] enemies!</span>"
	else
		return


/mob/living/carbon/alien/humanoid/ClickOn(atom/A, params)
	face_atom(A)
	if(leap_on_click)
		leap_at(A)
	else
		..()


#define MAX_ALIEN_LEAP_DIST 7

/mob/living/carbon/alien/humanoid/proc/leap_at(atom/A)
	if(!x_stats.w_leap)
		src << "<span class='alertalien'>You are unsure how to do this!</span>"
		return

	if(pounce_cooldown)
		src << "<span class='alertalien'>You are too fatigued to pounce right now!</span>"
		return

	if(leaping) //Leap while you leap, so you can leap while you leap
		return

	if(!has_gravity(src) || !has_gravity(A))
		src << "<span class='alertalien'>It is unsafe to leap without gravity!</span>"
		//It's also extremely buggy visually, so it's balance+bugfix
		return
	if(lying)
		return

	else //Maybe uses plasma in the future, although that wouldn't make any sense...
		leaping = 1
		update_icons()
		throw_at(A,MAX_ALIEN_LEAP_DIST,1, spin=0, diagonals_first = 1)
		leaping = 0
		update_icons()

/mob/living/carbon/alien/humanoid/throw_impact(atom/A)

	if(!leaping)
		return ..()

	if(A)
		if(istype(A, /mob/living))
			var/mob/living/L = A
			L.visible_message("<span class ='danger'>[src] pounces on [L]!</span>", "<span class ='userdanger'>[src] pounces on you!</span>")
			L.Weaken(5)
			sleep(2)//Runtime prevention (infinite bump() calls on hulks)
			step_towards(src,L)

			toggle_leap(0)
			pounce_cooldown = !pounce_cooldown
			spawn(pounce_cooldown_time) //3s by default
				pounce_cooldown = !pounce_cooldown
		else if(A.density && !A.CanPass(src))
			visible_message("<span class ='danger'>[src] smashes into [A]!</span>", "<span class ='alertalien'>[src] smashes into [A]!</span>")
			weakened = 2
		else
			pounce_cooldown = !pounce_cooldown
			spawn(30) //3s by default
				pounce_cooldown = !pounce_cooldown

		if(leaping)
			leaping = 0
			update_icons()
			update_canmove()


/mob/living/carbon/alien/humanoid/float(on)
	if(leaping)
		return
	..()

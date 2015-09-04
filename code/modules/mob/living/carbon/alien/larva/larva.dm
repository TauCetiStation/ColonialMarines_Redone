/mob/dead/observer/verb/join_as_larva()
	set name = "Join as larva"
	set desc = "Take control of clientless larva."
	set category = "Ghost"

	var/answer = alert(src, "Search for any clientless larva?",,"Yes","No")

	if(answer == "No")
		return

	var/clientless_count = 0
	var/clientless_tick = 0
	if(istype(usr, /mob/dead/observer)) //Make sure they're an observer!
		for(var/mob/living/carbon/alien/larva/L in living_mob_list)
			if((L.stat == DEAD) || L.client)
				continue
			if(L.larva_afk_tick < 120)
				clientless_count++
				if(clientless_tick < L.larva_afk_tick)
					clientless_tick = L.larva_afk_tick
				continue
			L.key = usr.key
			return
		if(clientless_count)
			usr << "<span class='notice'>There are [clientless_count] clientless larvas, and there is none that has passed 2 minutes.</span>"
			usr << "<span class='notice'>The one with highest afk time has [120 - clientless_tick] seconds left, until your control.</span>"
		else
			usr << "<span class='notice'>No clientless larvas at this time.</span>"

/mob/living/carbon/alien/larva
	name = "alien larva"
	real_name = "alien larva"
	icon_state = "Normal Larva"
	pass_flags = PASSTABLE | PASSMOB
	mob_size = MOB_SIZE_SMALL
	density = 0

	maxHealth = 25
	health = 25

	var/amount_grown = 0
	var/max_grown = 200
	var/time_of_birth
	var/larva_afk_tick = 0

//This is fine right now, if we're adding organ specific damage this needs to be updated
/mob/living/carbon/alien/larva/New()
	regenerate_icons()
	internal_organs += new /obj/item/organ/internal/alien/plasmavessel/larva

	AddAbility(new/obj/effect/proc_holder/alien/hide(null))
	AddAbility(new/obj/effect/proc_holder/alien/larva_evolve(null))
	..()

//This needs to be fixed
/mob/living/carbon/alien/larva/Stat()
	..()
	if(statpanel("Status"))
		stat(null, "Progress: [amount_grown]/[max_grown]")

/mob/living/carbon/alien/larva/adjustPlasma(amount)
	if(stat != DEAD && amount > 0)
		amount_grown = min(amount_grown + 1, max_grown)
	..(amount)

//can't equip anything
/mob/living/carbon/alien/larva/attack_ui(slot_id)
	return

/mob/living/carbon/alien/larva/attack_hulk(mob/living/carbon/human/user)
	if(user.a_intent == "harm")
		..(user, 1)
		adjustBruteLoss(5 + rand(1,9))
		Paralyse(1)
		spawn()
			step_away(src,user,15)
			sleep(1)
			step_away(src,user,15)
		return 1

/mob/living/carbon/alien/larva/attack_hand(mob/living/carbon/human/M)
	if(..())
		var/damage = rand(1, 9)
		if (prob(90))
			playsound(loc, "punch", 25, 1, -1)
			add_logs(M, src, "attacked")
			visible_message("<span class='danger'>[M] has kicked [src]!</span>", \
					"<span class='userdanger'>[M] has kicked [src]!</span>")
			if ((stat != DEAD) && (damage > 4.9))
				Paralyse(rand(5,10))

			adjustBruteLoss(damage)
			updatehealth()
		else
			playsound(loc, 'sound/weapons/punchmiss.ogg', 25, 1, -1)
			visible_message("<span class='danger'>[M] has attempted to kick [src]!</span>", \
					"<span class='userdanger'>[M] has attempted to kick [src]!</span>")

	return

/mob/living/carbon/alien/larva/restrained()
	return 0

// new damage icon system
// now constructs damage icon for each organ from mask * damage field


/mob/living/carbon/alien/larva/show_inv(mob/user)
	return

/mob/living/carbon/alien/larva/toggle_throw_mode()
	return

/mob/living/carbon/alien/larva/start_pulling()
	return

/mob/living/carbon/alien/larva/stripPanelUnequip(obj/item/what, mob/who)
	src << "<span class='warning'>You don't have the dexterity to do this!</span>"
	return

/mob/living/carbon/alien/larva/stripPanelEquip(obj/item/what, mob/who)
	src << "<span class='warning'>You don't have the dexterity to do this!</span>"
	return

/mob/living/carbon/human/attack_alien(mob/living/carbon/alien/humanoid/M)
	if(check_shields(0, M.name))
		visible_message("<span class='danger'>[M] attempted to touch [src]!</span>")
		return 0

	if(..())
		if(M.a_intent == "harm")
			if (w_uniform)
				w_uniform.add_fingerprint(M)

			if(!istype(M, /mob/living/carbon/alien/humanoid/queen) && x_stats.q_xeno_canharm == 0)
				var/found_queen = 0
				for(var/mob/living/carbon/alien/humanoid/queen/Q in living_mob_list)
					if(!Q.stat)
						found_queen = 1
						break

				if(found_queen)
					M << "<span class='warning'>You may not harm any host. That's an order from the Queen.</span>"
					return 0

			var/damage = rand(M.damagemin, M.damagemax)
			if(!damage)
				playsound(loc, 'sound/weapons/slashmiss.ogg', 50, 1, -1)
				visible_message("<span class='danger'>[M] has lunged at [src]!</span>", \
					"<span class='userdanger'>[M] has lunged at [src]!</span>")
				return 0

			playsound(loc, 'sound/weapons/slice.ogg', 25, 1, -1)

			var/obj/item/organ/limb/affecting = get_organ(ran_zone(M.zone_sel.selecting))
			var/armor_block = run_armor_check(affecting, "melee","","",10)
			apply_damage(damage, BRUTE, affecting, armor_block)
			if(damage < 25)
				visible_message("<span class='danger'>[M] has slashed at [src]!</span>", \
					"<span class='userdanger'>[M] has slashed at [src]!</span>")
			else
				visible_message("<span class='danger'>[M] has wounded [src]!</span>", \
					"<span class='userdanger'>[M] has wounded [src]!</span>")
				//apply_effect(4, WEAKEN, armor_block)

			if(src.stat != DEAD)
				score_slashes_made++

			add_logs(M, src, "attacked")
			updatehealth()

		if(M.a_intent == "disarm")
			var/randn = rand(1, 100)
			if (randn <= 80)
				if(weakened)
					if(prob(20))
						if(stat != DEAD)
							score_tackles_made++
						playsound(loc, 'sound/weapons/pierce.ogg', 25, 1, -1)
						Weaken(rand(M.tacklemin,M.tacklemax))
						adjustStaminaLoss(rand(M.tacklemin*10,M.tacklemax*10))
						add_logs(M, src, "tackled")
						visible_message("<span class='danger'>[M] has tackled down [src]!</span>", \
							"<span class='userdanger'>[M] has tackled down [src]!</span>")
					else
						playsound(loc, 'sound/weapons/punchmiss.ogg', 25, 1, -1)
						visible_message("<span class='danger'>[M] has tried to tackle [src], but they're already down!</span>", \
							"<span class='userdanger'>[M] has tried to tackle [src], but they're already down!</span>")
				else
					if(prob(M.tackle_chance)) //Tackle_chance is now a special var for each caste.
						if(stat != DEAD)
							score_tackles_made++
						playsound(loc, 'sound/weapons/pierce.ogg', 25, 1, -1)
						Weaken(rand(M.tacklemin,M.tacklemax))
						adjustStaminaLoss(rand(M.tacklemin*10,M.tacklemax*10))
						add_logs(M, src, "tackled")
						visible_message("<span class='danger'>[M] has tackled down [src]!</span>", \
							"<span class='userdanger'>[M] has tackled down [src]!</span>")
					else
						playsound(loc, 'sound/weapons/punchmiss.ogg', 25, 1, -1)
						visible_message("<span class='danger'>[M] tried to tackle [src]!</span>", \
							"<span class='userdanger'>[M] tried to tackle [src]!</span>")
			else
				if(randn <= 99)
					if(stat != DEAD)
						score_tackles_made++
					playsound(loc, 'sound/weapons/slash.ogg', 25, 1, -1)
					drop_item()
					visible_message("<span class='danger'>[M] disarmed [src]!</span>", \
						"<span class='userdanger'>[M] disarmed [src]!</span>")
				else
					playsound(loc, 'sound/weapons/slashmiss.ogg', 50, 1, -1)
					visible_message("<span class='danger'>[M] has tried to disarm [src]!</span>", \
						"<span class='userdanger'>[M] has tried to disarm [src]!</span>")
	return

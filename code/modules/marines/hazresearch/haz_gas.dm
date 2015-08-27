/obj/effect/biohazard/gas
	name = "gas"
	desc = "That doesn't look pleasant to breathe."
	icon_state = ""
	icon = ""
	density = 0
	opacity = 0
	anchored = 1

	var/strength = 0.8
	var/health = 100
	var/property = ""


/obj/effect/biohazard/gas/New()
	..()
	SSobj.processing |= src


/obj/effect/biohazard/gas/Destroy()
	SSobj.processing.Remove(src)
	..()

/obj/effect/biohazard/gas/proc/lifespancheck()
	if(health <= 0)
		qdel(src)

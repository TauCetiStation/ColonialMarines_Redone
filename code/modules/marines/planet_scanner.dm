/obj/machinery/computer/planet_scanner
	name = "Planetary Scanner"
	desc = "Scan planet for lifeforms."
	icon_screen = "planscan"
	icon_keyboard = "id_key"
	circuit = "/obj/item/weapon/circuitboard/plan_scan"
	var/activated = 0
	var/obj/detector_image = new()
	var/list/detected = list()
	var/scanning = 0

/obj/machinery/computer/planet_scanner/attack_hand(mob/user as mob)
	if(..())
		return

	if(!detected.len)
		scan(user)

	CreateDetectorImage(user, 'icons/marines/detectorscreen.dmi')
	ToggleDetector(user)
	
	return

/obj/machinery/computer/planet_scanner/proc/CreateDetectorImage(mob/user,image) //Creates the animated detector background
	if(detector_image in user.client.screen)
		return
	else
		detector_image.icon = image
		detector_image.screen_loc = "detector:1,1"
		user.client.screen+=detector_image
	return

/obj/machinery/computer/planet_scanner/proc/scan(mob/user)
	if(!scanning)
		scanning = 1
		visible_message("<span class='notice'>[src.name]: scanning procedure activated... approximate completion time: 1 minute.</span>")
		spawn(450)
			for(var/mob/living/t in living_mob_list)
				if(ismouse(t))
					continue
				if(t.z == 1)
					detected += t
				if(t.z == 0)
					var/turf/check = get_turf(t)
					if(check.z == 1)
						detected += t
			if(detected.len)
				playsound(src.loc, 'sound/machines/twobeep.ogg', 125)
				visible_message("<span class='danger'>[src.name]: scanning prodecure completed... Life signs detected.</span>")
				spawn(3000)
					playsound(src.loc, 'sound/machines/twobeep.ogg', 125)
					visible_message("<span class='danger'>[src.name]: Scanning data outdated, new scan required!</span>")
					detected = list()
			else
				playsound(src.loc, 'sound/machines/buzz-two.ogg', 125)
				visible_message("<span class='notice'>[src.name]: scanning procedure completed... No life signs detected.</span>")
			scanning = 0
	else
		user << "<span class='notice'>Scanning procedure in progress... Please wait.</span>"

/obj/machinery/computer/planet_scanner/proc/Redraw(mob/user)
	while(activated && user.client && Adjacent(user) && !user.stat)
		if(!src)
			activated = 0
			break

		for(var/obj/Blip/o in user.client.screen)
			user.client.screen-=o //Remove all blips from the tracker, then..
			qdel(o)	//Store all removed blips in the pool

		if(detected.len)
			for(var/mob/living/t in detected)
				var/obj/Blip/o = PoolOrNew(/obj/Blip) // Get a blip from the blip pool
				o.pixel_x = (round(t.x/10)-12)*4-4 // Make the blip in the right position on the radar (multiplied by the icon dimensions)
				o.pixel_y = (round(t.y/10)-12)*4-4 //-4 is a slight offset south and west
				o.screen_loc = "detector:3:[o.pixel_x],3:[o.pixel_y]" // Make it appear on the radar map
				user.client.screen+=o // Add it to the radar
				flick("blip", o)
		flick("", detector_image)
		sleep(10)
	activated = 0
	user.current_detector = null
	winshow(user,"detectorwindow",0)

/obj/machinery/computer/planet_scanner/proc/ToggleDetector(mob/user)
	if(winget(user,"detectorwindow","is-visible")=="true" && user.current_detector == src) //Checks if radar window is already open and if radar is assigned
		activated = 0 //Sets the active state of the radar to off
		winshow(user,"detectorwindow",0) //Closes the radar window
		//user.current_detector = null
	else if(!user.current_detector)
		activated = 1
		winshow(user,"detectorwindow",1)
		user.current_detector = src
		Redraw(user)
	else user << "\red You're already using another tracker."

/obj/Blip
	icon = 'icons/marines/detector-blips.dmi'
	icon_state = "blip"
	layer = 5

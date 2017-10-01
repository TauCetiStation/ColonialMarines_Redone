///******MARINE VENDOR******///
/obj/machinery/vending/marine/weapons
	name = "ColMarWeap"
	desc = "A marine weapon vendor"
	product_ads = "If it moves, it's hostile!;How many enemies have you killed today?;Shoot first, perform autopsy later!;Your ammo is right here.;Guns!;Die, scumbag!;Don't shoot me bro!;Shoot them, bro.;Why not have a donut?"
	products = list(
					/obj/item/weapon/gun/projectile/pistol/m4a3 = 15,
					/obj/item/weapon/gun/projectile/shotgun/m37 = 15,
					/obj/item/weapon/gun/projectile/Assault/m39 = 15,
					/obj/item/weapon/gun/projectile/Assault/m41 = 15
					)

/obj/machinery/vending/marine/ammunition
	name = "ColMarAmmo"
	desc = "A marine ammunition vendor"
	product_ads = "If it moves, it's hostile!;How many enemies have you killed today?;Shoot first, perform autopsy later!;Your ammo is right here.;Guns!;Die, scumbag!;Don't shoot me bro!;Shoot them, bro.;Why not have a donut?"
	products = list(
					/obj/item/ammo_box/magazine/m4a3 = 55,
					/obj/item/ammo_box/m37/buckshot = 55,
					/obj/item/ammo_box/magazine/m39 = 55,
					/obj/item/ammo_box/magazine/m41 = 55
					)

/obj/machinery/vending/marine/equipment
	name = "ColMarEquip"
	desc = "A marine equipment vendor"
	product_ads = "If it moves, it's hostile!;How many enemies have you killed today?;Shoot first, perform autopsy later!;Your ammo is right here.;Guns!;Die, scumbag!;Don't shoot me bro!;Shoot them, bro.;Why not have a donut?"
	products = list(
					/obj/item/clothing/head/helmet/marine2 = 10,
					/obj/item/clothing/suit/storage/marine2 = 10,
					/obj/item/weapon/camera_assembly = 15,
					/obj/item/weapon/storage/backpack/marine = 10,
					/obj/item/device/flashlight/flare = 25,
					/obj/item/device/flashlight/seclite = 10,
					/obj/item/device/radio/marine = 10,
					/obj/item/weapon/grenade/explosive = 2,
					/obj/item/weapon/combat_knife = 25,
					/obj/item/weapon/storage/box/marine = 10,
					/obj/item/weapon/storage/box/mre = 10
					)

/obj/machinery/vending/marine/special
	name = "ColMarSpecial"
	desc = "A marine special vendor."
	product_ads = "If it moves, it's hostile!;How many enemies have you killed today?;Shoot first, perform autopsy later!;Your ammo is right here.;Guns!;Die, scumbag!;Don't shoot me bro!;Shoot them, bro.;Why not have a donut?"
	products = list()
	unacidable = 1

//MARINE FOOD VENDOR APOPHIS775 10JAN2014
/obj/machinery/vending/marineFood
	name = "Marine Food Vendor"
	desc = "Standard Issue Food Vendor, containing standard military food"
	icon_state = "boozeomat"        //////////////18 drink entities below, plus the glasses, in case someone wants to edit the number of bottles
	icon_deny = "boozeomat-deny"
	products = list(/obj/item/weapon/reagent_containers/food/snacks/burger/fish = 10, /obj/item/weapon/reagent_containers/food/snacks/burger/tofu = 5,
					/obj/item/weapon/reagent_containers/food/snacks/omelette = 10, /obj/item/weapon/reagent_containers/food/snacks/muffin = 10,
					/obj/item/weapon/reagent_containers/food/snacks/sosjerky = 10, /obj/item/weapon/reagent_containers/food/snacks/meat/steak = 10)
	contraband = list(/obj/item/weapon/paper/cake = 1)
	vend_delay = 15
	product_slogans = "Standard Issue Marine food!;It's good for you, and not the worst thing in the world.;Just fucking eat it;"
	product_ads = "Your only choice for food...Literally;"
	req_access_txt = ""

/obj/item/weapon/paper/cake
	name = "Cake"
	info = "Cake is a lie."

//MARINE MEDICAL VENDOR -APOPHIS775 24JAN2015
/obj/machinery/vending/MarineMed
	name = "MarineMed"
	desc = "Advanced Marine Drug Dispenser"
	icon_state = "med"
	icon_deny = "med-deny"
	product_ads = "Go save some lives!;The best stuff for your medbay.;Only the finest tools.;Natural chemicals!;This stuff saves lives.;Don't you want some?;Ping!"
	req_access_txt = "0"
	products = list(/obj/item/weapon/reagent_containers/hypospray/medipen = 10,
					/obj/item/weapon/reagent_containers/hypospray/medipen/morphine = 10,
					/obj/item/weapon/reagent_containers/glass/bottle/atropine = 4,
					/obj/item/weapon/reagent_containers/glass/bottle/charcoal = 4,
					/obj/item/weapon/storage/pill_bottle/anti_starve = 4,
					/obj/item/weapon/reagent_containers/glass/bottle/epinephrine = 4)
	contraband = list()



//NEW BLOOD VENDOR CODE - APOPHIS775 22JAN2015
/obj/machinery/vending/MarineMed/Blood
	name = "MM Blood Dispenser"
	desc = "Marine Med brand Blood Pack Dispensery"
	icon_state = "med"
	icon_deny = "med-deny"
	product_ads = "The best blood on the market!"
	req_access_txt = "0"
	products = list(/obj/item/weapon/reagent_containers/blood/APlus = 5, /obj/item/weapon/reagent_containers/blood/AMinus = 5,
					/obj/item/weapon/reagent_containers/blood/BPlus = 5, /obj/item/weapon/reagent_containers/blood/BMinus = 5,
					/obj/item/weapon/reagent_containers/blood/OPlus = 5, /obj/item/weapon/reagent_containers/blood/OMinus = 5,
					/obj/item/weapon/reagent_containers/blood/empty = 10)


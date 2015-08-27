//CHARLIE CLOTHING CLOSET
/obj/structure/closet/secure_closet/hazteam_closet
	name = "HazMat Clothing Locker"
	req_access = list()
	icon_state = "sec1"

	New()
		sleep(2)
		new /obj/item/clothing/suit/bio/marine(src)
		new /obj/item/clothing/head/helmet/bio/marine(src)
		//new /obj/item/clothing/shoes/swat(src)
		//new /obj/item/clothing/gloves/swat(src)
		return
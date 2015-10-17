/////////////////////////////////////////
////////////Medical Tools////////////////
/////////////////////////////////////////

/datum/design/mass_spectrometer
	name = "Mass-Spectrometer"
	desc = "A device for analyzing chemicals in the blood."
	id = "mass_spectrometer"
	req_tech = list("biotech" = 2, "magnets" = 2)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 30, MAT_GLASS = 20)
	reliability = 76
	build_path = /obj/item/device/mass_spectrometer
	category = list("Medical Designs")

/datum/design/adv_mass_spectrometer
	name = "Advanced Mass-Spectrometer"
	desc = "A device for analyzing chemicals in the blood and their quantities."
	id = "adv_mass_spectrometer"
	req_tech = list("biotech" = 2, "magnets" = 4)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 30, MAT_GLASS = 20)
	reliability = 74
	build_path = /obj/item/device/mass_spectrometer/adv
	category = list("Medical Designs")

/datum/design/synthetic_flash
	name = "Flash"
	desc = "When a problem arises, SCIENCE is the solution."
	id = "sflash"
	req_tech = list("magnets" = 3, "combat" = 2)
	build_type = MECHFAB
	materials = list(MAT_METAL = 750, MAT_GLASS = 750)
	construction_time = 100
	reliability = 76
	build_path = /obj/item/device/flash/handheld
	category = list("Misc")

/datum/design/bluespacebeaker
	name = "Bluespace Beaker"
	desc = "A bluespace beaker, powered by experimental bluespace technology and Element Cuban combined with the Compound Pete. Can hold up to 300 units."
	id = "bluespacebeaker"
	req_tech = list("bluespace" = 2, "materials" = 6)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 3000, MAT_PLASMA = 3000, MAT_DIAMOND = 500)
	reliability = 76
	build_path = /obj/item/weapon/reagent_containers/glass/beaker/bluespace
	category = list("Misc","Medical Designs")

/datum/design/noreactbeaker
	name = "Cryostasis Beaker"
	desc = "A cryostasis beaker that allows for chemical storage without reactions. Can hold up to 50 units."
	id = "splitbeaker"
	req_tech = list("materials" = 2)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 3000)
	reliability = 76
	build_path = /obj/item/weapon/reagent_containers/glass/beaker/noreact
	category = list("Medical Designs")

/datum/design/bluespacebodybag
	name = "Bluespace body bag"
	desc = "A bluespace body bag, powered by experimental bluespace technology. It can hold loads of bodies and the largest of creatures."
	id = "bluespacebodybag"
	req_tech = list("bluespace" = 2, "materials" = 6)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 3000, MAT_PLASMA = 2000, MAT_DIAMOND = 500)
	reliability = 76
	build_path = /obj/item/bodybag/bluespace
	category = list("Medical Designs")

/////////////////////////////////////////
////////////Regular Implants/////////////
/////////////////////////////////////////

/datum/design/implanter
	name = "Implanter"
	desc = "A sterile automatic implant injector."
	id = "implanter"
	req_tech = list("materials" = 1, "programming" = 2, "biotech" = 3)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 600, MAT_GLASS = 200)
	build_path = /obj/item/weapon/implanter
	category = list("Medical Designs")

/datum/design/implantcase
	name = "Implant Case"
	desc = "A glass case containing an implant."
	id = "implantcase"
	req_tech = list("materials" = 1, "biotech" = 2)
	build_type = PROTOLATHE
	materials = list(MAT_GLASS = 500)
	build_path = /obj/item/weapon/implantcase
	category = list("Medical Designs")

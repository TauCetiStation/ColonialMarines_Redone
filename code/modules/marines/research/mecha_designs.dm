///////////////////////////////////
//////////Mecha Module Disks///////
///////////////////////////////////

/datum/design/ripley_main
	name = "Exosuit Module (APLU \"Ripley\" Central Control module)"
	desc = "Allows for the construction of a \"Ripley\" Central Control module."
	id = "ripley_main"
	req_tech = list("programming" = 3)
	build_type = IMPRINTER
	materials = list(MAT_GLASS = 1000, "sacid" = 20)
	build_path = /obj/item/weapon/circuitboard/mecha/ripley/main
	category = list("Exosuit Modules")

/datum/design/ripley_peri
	name = "Exosuit Module (APLU \"Ripley\" Peripherals Control module)"
	desc = "Allows for the construction of a  \"Ripley\" Peripheral Control module."
	id = "ripley_peri"
	req_tech = list("programming" = 3)
	build_type = IMPRINTER
	materials = list(MAT_GLASS = 1000, "sacid" = 20)
	build_path = /obj/item/weapon/circuitboard/mecha/ripley/peripherals
	category = list("Exosuit Modules")

////////////////////////////////////////
/////////// Mecha Equpment /////////////
////////////////////////////////////////

/datum/design/mech_diamond_drill
	name = "Exosuit Module (Diamond Mining Drill)"
	desc = "An upgraded version of the standard drill."
	id = "mech_diamond_drill"
	build_type = MECHFAB
	req_tech = list("materials" = 4, "engineering" = 3)
	build_path = /obj/item/mecha_parts/mecha_equipment/drill/diamonddrill
	materials = list(MAT_METAL=10000,MAT_DIAMOND=6500)
	construction_time = 100
	category = list("Exosuit Equipment")

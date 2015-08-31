//PMC Weapons

/obj/item/weapon/gun/projectile/automatic/Assault/m39/PMCm39 // M39 SMG
	name = "\improper M39 SMG"
	desc = " Armat Battlefield Systems M39 SMG. This white version looks like it was produced for private security firms. Uses 9mm rounds."
	icon = 'icons/marines/PMC.dmi'
	icon_state = "smg"

/obj/item/weapon/gun/projectile/automatic/pistol/VP78 //VP78
	name = "\improper VP78 pistol"
	desc = "A specially made pistol manufactured by the Weyland Yutani corporation. Chambered with custom-made rounds."
	icon = 'icons/marines/PMC.dmi'
	icon_state = "VP78"

	mag_type = /obj/item/ammo_box/magazine/VP78
	can_suppress = 0
	burst_size = 1
	fire_delay = 0
	action_button_name = null

	fire_sound = 'sound/weapons/mg.ogg'

//bullets
	//M39
/obj/item/projectile/bullet/m39/toxic // M39 SMG
	damage = 15
	damage_type = TOX
	icon_state = "dart"
	weaken = 5

/obj/item/ammo_casing/m39/toxic // M39 SMG
	desc = "A .9mm special bullet casing."
	projectile_type = /obj/item/projectile/bullet/m39/toxic

/obj/item/ammo_box/magazine/m39/toxic // M39 SMG
	name = "M39 SMG Mag (9mm toxic)"
	desc = "A 9mm magazine filled with 9mm toxin rounds. Made from a much softer material than most bullets these special rounds are designed to deliver toxins which can severely debilitate a target."
	icon_state = "9x19toxic"
	ammo_type = /obj/item/ammo_casing/m39/toxic
	max_ammo = 20

//VP78
/obj/item/projectile/bullet/VP78
	damage = 50
	weaken = 5

/obj/item/ammo_casing/VP78 //VP78
	desc = "A 44 Magnum bullet casing."
	projectile_type = /obj/item/projectile/bullet/m44m

/obj/item/ammo_box/magazine/VP78 //VP78 Pistol mag
	name = "VP78 Magazine (.9mms special)"
	desc = "A magazine with .9mms ammo"
	icon_state = "a45"
	ammo_type = /obj/item/ammo_casing/VP78
	max_ammo = 18

//PMC Grunt gear

/obj/item/clothing/under/marine/PMC
	name = "PMC uniform"
	desc = "A white set of fatigues, designed for private security operators. The symbol of the Weyland-Yutani corporation is emblazed on the suit."
	icon_state = "pmc_jumpsuit"
	item_state = "pmc_jumpsuit_s"
	item_color = "pmc_jumpsuit"
	//	armor = list(melee = 20, bullet = 20, laser = 0,energy = 0, bomb = 10, bio = 0, rad = 0)

/obj/item/clothing/suit/storage/marine/PMCarmor
	name = "M4 Pattern PMC Armor"
	desc = "A modification of the standard Armat Systems M3 armor. Designed for high-profile security operators and corporate mercenaries in mind."
	icon = 'icons/marines/PMC.dmi'
	alternate_worn_icon = 'icons/marines/PMC.dmi'
	item_state = "pmc_armor"
	icon_state = "pmc_armor"

/obj/item/clothing/mask/gas/PMCmask
	name = "M8 Pattern Armored balaclava"
	desc = "An armored balaclava designed to conceal both the identity of the operator and act as an air-filter."
	flags = BLOCKHAIR
	icon = 'icons/marines/PMC.dmi'
	alternate_worn_icon = 'icons/marines/PMC.dmi'
	item_state = "pmc_mask"
	icon_state = "pmc_mask"
	armor = list(melee = 50, bullet = 80, laser = 50,energy = 10, bomb = 25, bio = 0, rad = 0)
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH

/obj/item/clothing/head/helmet/marine/PMC
	name = "PMC tactical cap"
	desc = "A protective cap made from flexable kevlar. Standard issue for most security forms in the place of a helmet."
	icon = 'icons/marines/PMC.dmi'
	alternate_worn_icon = 'icons/marines/PMC.dmi'
	item_state = "pmc_hat"
	icon_state = "pmc_hat"
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)

//PMC Officer gear

/obj/item/clothing/under/marine/PMC/leader
	name = "PMC command uniform"
	desc = "A white set of fatigues, designed for private security operators. The symbol of the Weyland-Yutani corporation is emblazed on the suit. This particular suit looks like it belongs to a high-ranking officer."
	item_state = "officer_jumpsuit_s"
	icon_state = "officer_jumpsuit"
	item_color = "officer_jumpsuit"

/obj/item/clothing/suit/storage/marine/PMCarmor/leader
	name = "M4 Pattern PMC Armor"
	desc = "A modification of the standard Armat Systems M3 armor. Designed for high-profile security operators and corporate mercenaries in mind. This particular suit looks like it belongs to a high-ranking officer."
	icon = 'icons/marines/PMC.dmi'
	item_state = "officer_armor"
	icon_state = "officer_armor"

/obj/item/clothing/mask/gas/PMCmask/leader
	name = "M8 Pattern Armored balaclava"
	desc = "An armored balaclava designed to conceal both the identity of the operator and act as an air-filter. This particular suit looks like it belongs to a high-ranking officer."
	icon = 'icons/marines/PMC.dmi'
	item_state = "officer_mask"
	icon_state = "officer_mask"


/obj/item/clothing/head/helmet/marine/PMC/leader
	name = "PMC Beret"
	desc = "The pinacle of fashion for any aspiring mercenary leader. Designed to protect the head from light impacts."
	icon = 'icons/marines/PMC.dmi'
	item_state = "officer_hat"
	icon_state = "officer_hat"


/obj/item/weapon/grenade/explosive/PMC
	desc = "A fragmentation grenade produced for private security firms. It explodes 3 seconds after the pin has been pulled."
	icon = 'icons/marines/grenade2.dmi'
	icon_state = "grenade_ex"
	item_state = "grenade_ex"


	prime()
		spawn(0)
			explosion(src.loc,-1,-1,3)
			del(src)
		return

//headset
/obj/item/device/radio/headset/syndicate/PMC
	name = "Weyland Yutani headset"
	desc = "A headset used by Weyland Yutani field operatives"
	keyslot2 = new /obj/item/device/encryptionkey/syndicate/WY
	//frequency = 1468

//encryption key
/obj/item/device/encryptionkey/syndicate/WY
	name = "Weyland Yutani Encryption Key"
	desc = "An encyption key for a radio headset.  Contains cypherkeys."


/obj/item/clothing/under/rank/chef/exec
	name = "Weyland Yutani suit"
	desc = "A formal white undersuit."
/obj/structure/flora
	burn_state = 0 //Burnable
	burntime = 30

//trees
/obj/structure/flora/tree
	name = "tree"
	anchored = 1
	density = 1
	opacity = 1
	pixel_x = -16
	layer = 9

/obj/structure/flora/tree/pine
	name = "pine tree"
	icon = 'icons/obj/flora/pinetrees.dmi'
	icon_state = "pine_1"

/obj/structure/flora/tree/pine/New()
	icon_state = "pine_[rand(1, 3)]"
	..()

/obj/structure/flora/tree/jungletree
	name = "jungle tree"
	icon = 'icons/obj/flora/jungletrees.dmi'
	icon_state = "tree3"

/obj/structure/flora/tree/jungletree/tree
	name = "jungle tree"
	icon = 'icons/obj/flora/jungletrees.dmi'
	icon_state = "tree"

/obj/structure/flora/tree/jungletree/tree1
	name = "jungle tree 1"
	icon = 'icons/obj/flora/jungletrees.dmi'
	icon_state = "tree1"

/obj/structure/flora/tree/jungletree/tree2
	name = "jungle tree 2"
	icon = 'icons/obj/flora/jungletrees.dmi'
	icon_state = "tree2"

/obj/structure/flora/tree/jungletree/tree3
	name = "jungle tree 3"
	icon = 'icons/obj/flora/jungletrees.dmi'
	icon_state = "tree3"

/obj/structure/flora/tree/jungletree/tree4
	name = "jungle tree 4"
	icon = 'icons/obj/flora/jungletrees.dmi'
	icon_state = "tree4"

/obj/structure/flora/tree/jungletree/tree5
	name = "jungle tree 5"
	icon = 'icons/obj/flora/jungletrees.dmi'
	icon_state = "tree5"

/obj/structure/flora/tree/jungletree/tree6
	name = "jungle tree 6"
	icon = 'icons/obj/flora/jungletrees.dmi'
	icon_state = "tree6"

/obj/structure/flora/tree/jungletree/tree7
	name = "jungle tree 7"
	icon = 'icons/obj/flora/jungletrees.dmi'
	icon_state = "tree7"

/obj/structure/flora/tree/jungletree/tree8
	name = "jungle tree 8"
	icon = 'icons/obj/flora/jungletrees.dmi'
	icon_state = "tree8"

/obj/structure/flora/tree/jungletree/tree9
	name = "jungle tree 9"
	icon = 'icons/obj/flora/jungletrees.dmi'
	icon_state = "tree9"

/obj/structure/flora/tree/jungletree/tree10
	name = "jungle tree 10"
	icon = 'icons/obj/flora/jungletrees.dmi'
	icon_state = "tree10"

/obj/structure/flora/tree/pine/xmas
	name = "xmas tree"
	icon = 'icons/obj/flora/pinetrees.dmi'
	icon_state = "pine_c"

/obj/structure/flora/tree/pine/xmas/New()
	..()
	icon_state = "pine_c"

/obj/structure/flora/tree/dead
	icon = 'icons/obj/flora/deadtrees.dmi'
	icon_state = "tree_1"

/obj/structure/flora/tree/festivus
	name = "festivus pole"
	icon = 'icons/obj/flora/pinetrees.dmi'
	icon_state = "festivus_pole"
	desc = "During last year's Feats of Strength the Research Director was able to suplex this passing immobile rod into a planter."

/obj/structure/flora/tree/dead/New()
	icon_state = "tree_[rand(1, 6)]"
	..()


//grass
/obj/structure/flora/grass
	name = "grass"
	icon = 'icons/obj/flora/snowflora.dmi'
	anchored = 1
	gender = PLURAL	//"this is grass" not "this is a grass"

/obj/structure/flora/grass/brown
	icon_state = "snowgrass1bb"

/obj/structure/flora/grass/brown/New()
	icon_state = "snowgrass[rand(1, 3)]bb"
	..()


/obj/structure/flora/grass/green
	icon_state = "snowgrass1gb"

/obj/structure/flora/grass/green/New()
	icon_state = "snowgrass[rand(1, 3)]gb"
	..()

/obj/structure/flora/grass/both
	icon_state = "snowgrassall1"

/obj/structure/flora/grass/both/New()
	icon_state = "snowgrassall[rand(1, 3)]"
	..()


//bushes
/obj/structure/flora/bush
	name = "bush"
	icon = 'icons/obj/flora/snowflora.dmi'
	icon_state = "snowbush1"
	anchored = 1

/obj/structure/flora/bush/New()
	icon_state = "snowbush[rand(1, 6)]"
	..()

//jungletreesmall

/obj/structure/flora/jungletreesmall
	name = "tree"
	icon = 'icons/obj/flora/jungletreesmall.dmi'
	icon_state = "tree"
	anchored = 1

/obj/structure/flora/jungletreesmall/jungtree1
	icon_state = "tree1"

/obj/structure/flora/jungletreesmall/jungtree2
	icon_state = "tree2"

/obj/structure/flora/jungletreesmall/jungtree3
	icon_state = "tree3"

/obj/structure/flora/jungletreesmall/jungtree4
	icon_state = "tree4"

/obj/structure/flora/jungletreesmall/jungtree5
	icon_state = "tree5"

/obj/structure/flora/jungletreesmall/jungtree6
	icon_state = "tree6"

//junglebushes

/obj/structure/flora/largejungleflora
	name = "bush"
	icon = 'icons/obj/flora/largejungleflora.dmi'
	icon_state = "bush1"
	anchored = 1

/obj/structure/flora/largejungleflora/jungbush
	icon_state = "bush0"

/obj/structure/flora/largejungleflora/jungbush1
	icon_state = "bush1"

/obj/structure/flora/largejungleflora/jungbush2
	icon_state = "bush2"

/obj/structure/flora/largejungleflora/jungbush3
	icon_state = "bush3"

/obj/structure/flora/largejungleflora/jungrock
	icon_state = "rocks0"

/obj/structure/flora/largejungleflora/jungrock1
	icon_state = "rocks1"

/obj/structure/flora/largejungleflora/jungrock2
	icon_state = "rocks2"

/obj/structure/flora/largejungleflora/jungrock3
	icon_state = "rocks3"

//newbushes

/obj/structure/flora/ausbushes
	name = "bush"
	icon = 'icons/obj/flora/ausflora.dmi'
	icon_state = "firstbush_1"
	anchored = 1

/obj/structure/flora/ausbushes/New()
	if(icon_state == "firstbush_1")
		icon_state = "firstbush_[rand(1, 4)]"
	..()

/obj/structure/flora/ausbushes/reedbush
	icon_state = "reedbush_1"

/obj/structure/flora/ausbushes/reedbush/New()
	icon_state = "reedbush_[rand(1, 4)]"
	..()

/obj/structure/flora/ausbushes/leafybush
	icon_state = "leafybush_1"

/obj/structure/flora/ausbushes/leafybush/New()
	icon_state = "leafybush_[rand(1, 3)]"
	..()

/obj/structure/flora/ausbushes/palebush
	icon_state = "palebush_1"

/obj/structure/flora/ausbushes/palebush/New()
	icon_state = "palebush_[rand(1, 4)]"
	..()

/obj/structure/flora/ausbushes/stalkybush
	icon_state = "stalkybush_1"

/obj/structure/flora/ausbushes/stalkybush/New()
	icon_state = "stalkybush_[rand(1, 3)]"
	..()

/obj/structure/flora/ausbushes/grassybush
	icon_state = "grassybush_1"

/obj/structure/flora/ausbushes/grassybush/New()
	icon_state = "grassybush_[rand(1, 4)]"
	..()

/obj/structure/flora/ausbushes/fernybush
	icon_state = "fernybush_1"

/obj/structure/flora/ausbushes/fernybush/New()
	icon_state = "fernybush_[rand(1, 3)]"
	..()

/obj/structure/flora/ausbushes/sunnybush
	icon_state = "sunnybush_1"

/obj/structure/flora/ausbushes/sunnybush/New()
	icon_state = "sunnybush_[rand(1, 3)]"
	..()

/obj/structure/flora/ausbushes/genericbush
	icon_state = "genericbush_1"

/obj/structure/flora/ausbushes/genericbush/New()
	icon_state = "genericbush_[rand(1, 4)]"
	..()

/obj/structure/flora/ausbushes/pointybush
	icon_state = "pointybush_1"

/obj/structure/flora/ausbushes/pointybush/New()
	icon_state = "pointybush_[rand(1, 4)]"
	..()

/obj/structure/flora/ausbushes/lavendergrass
	icon_state = "lavendergrass_1"

/obj/structure/flora/ausbushes/lavendergrass/New()
	icon_state = "lavendergrass_[rand(1, 4)]"
	..()

/obj/structure/flora/ausbushes/ywflowers
	icon_state = "ywflowers_1"

/obj/structure/flora/ausbushes/ywflowers/New()
	icon_state = "ywflowers_[rand(1, 3)]"
	..()

/obj/structure/flora/ausbushes/brflowers
	icon_state = "brflowers_1"

/obj/structure/flora/ausbushes/brflowers/New()
	icon_state = "brflowers_[rand(1, 3)]"
	..()

/obj/structure/flora/ausbushes/ppflowers
	icon_state = "ppflowers_1"

/obj/structure/flora/ausbushes/ppflowers/New()
	icon_state = "ppflowers_[rand(1, 3)]"
	..()

/obj/structure/flora/ausbushes/sparsegrass
	icon_state = "sparsegrass_1"

/obj/structure/flora/ausbushes/sparsegrass/New()
	icon_state = "sparsegrass_[rand(1, 3)]"
	..()

/obj/structure/flora/ausbushes/fullgrass
	icon_state = "fullgrass_1"

/obj/structure/flora/ausbushes/fullgrass/New()
	icon_state = "fullgrass_[rand(1, 3)]"
	..()

/obj/structure/flora/kirbyplants
	name = "potted plant"
	icon = 'icons/obj/flora/plants.dmi'
	icon_state = "plant-01"

/obj/structure/flora/kirbyplants/dead
	name = "RD's potted plant"
	desc = "A gift from the botanical staff, presented after the RD's reassignment. There's a tag on it that says \"Y'all come back now, y'hear?\"\nIt doesn't look very healthy..."
	icon_state = "plant-25"


//a rock is flora according to where the icon file is
//and now these defines
/obj/structure/flora/rock
	name = "rock"
	desc = "a rock"
	icon_state = "rock1"
	icon = 'icons/obj/flora/rocks.dmi'
	anchored = 1
	burn_state = -1 //Not Burnable

/obj/structure/flora/rock2
	name = "rock2"
	desc = "a rock"
	icon_state = "basalt1"
	icon = 'icons/obj/flora/rocks2.dmi'
	anchored = 1
	burn_state = -1 //Not Burnable

/obj/structure/flora/rock2/basalt1
	name = "basalt1"
	desc = "some rocks"
	icon_state = "basalt1"
	icon = 'icons/obj/flora/rocks2.dmi'

/obj/structure/flora/rock2/basalt2
	name = "basalt2"
	desc = "some rocks"
	icon_state = "basalt2"
	icon = 'icons/obj/flora/rocks2.dmi'

/obj/structure/flora/rock2/basalt3
	name = "basalt3"
	desc = "some rocks"
	icon_state = "basalt3"
	icon = 'icons/obj/flora/rocks2.dmi'

/obj/structure/flora/rock/New()
	..()
	icon_state = "rock[rand(1,5)]"

/obj/structure/flora/rock/pile
	name = "rocks"
	desc = "some rocks"
	icon_state = "rockpile1"


/obj/structure/flora/rock/pile/New()
	..()
	icon_state = "rockpile[rand(1,5)]"
/*
The /tg/ codebase currently requires you to have 7 z-levels of the same size dimensions.
z-level order is important, the order you put them in inside this file will determine what z level number they are assigned ingame.
Names of z-level do not matter, but order does greatly, for instances such as checking alive status of revheads on z1

z1 = Nostromo - which is actually just a station for now :). tgstation.2.1.3.dmm were used.
z2 = centcomm
z3 = derelict telecomms satellite
z4 = derelict station
z5 = mining
z6 = Sulaco
z7 = empty space
*/

#if !defined(MAP_FILE)

        #include "map_files\marines\nostromo.dmm"
        #include "map_files\generic\z2.dmm"
        #include "map_files\generic\z3.dmm"
        #include "map_files\generic\z4.dmm"
        #include "map_files\generic\z5.dmm"
        #include "map_files\marines\sulaco.dmm"
        #include "map_files\generic\z7.dmm"

        #define MAP_FILE "nostromo.dmm"
        #define MAP_NAME "TGstation 2"

#elif !defined(MAP_OVERRIDE)

	#warn a map has already been included, ignoring /tg/station 2.

#endif

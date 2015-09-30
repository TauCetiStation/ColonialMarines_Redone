/*
The codebase currently requires you to have z-levels of the same size dimensions.
z-level order is important, the order you put them in inside this file will determine what z level number they are assigned ingame.
Names of z-level do not matter, but order does greatly, for instances such as checking alive status on z1

z1 = Planet
z2 = centcomm
z3 = Sulaco
*/

#if !defined(MAP_FILE)

        #include "map_files\marines\unk379.dmm"
        #include "map_files\generic\z2.dmm"
        #include "map_files\marines\sulaco2.dmm"

        #define MAP_FILE "unk379.dmm"
        #define MAP_NAME "CMR"

#elif !defined(MAP_OVERRIDE)

	#warn a map has already been included.

#endif

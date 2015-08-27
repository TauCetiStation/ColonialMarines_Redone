//Queen respawn timer
var/queen_died = 0

//scoreboard
//Marines

var/score_marinescore = 0 //overall var/score for marines
var/score_marines_won = 0
/*
0 = fail
1 = marine major
2 = marine minor
*/

var/score_marines_mia = 0
var/score_marines_kia = 0
var/score_marines_survived = 0
var/score_survivors_rescued = 0
var/score_hit_called = 0
var/score_marines_chestbursted = 0
var/score_marines_cloned = 0
var/score_larvas_extracted = 0
var/score_shuttle_called = 0
var/score_crew_evacuated = 0

var/score_rounds_fired = 0
var/score_rounds_hit = 0
var/score_aliens_clamped = 0


var/round_end_situation = 3
/*
1 = alien major victory
2 = marine major victory
3 = draw
4 = alien minor victory
5 = marine minor victory
*/


//Aliens
var/score_alienscore = 0
var/score_aliens_won = 0
/*
0 = fail
1 = alien major
2 = aline minor
*/

var/score_aliens_dead = 0
var/score_larvas_dead = 0
var/score_queens_dead = 0
var/score_aliens_survived = 0
var/score_queen_survived = 0
var/score_eggs_made = 0
var/score_weeds_made = 0
var/score_hosts_infected = 0

var/score_resin_made = 0
var/score_tackles_made = 0
var/score_slashes_made = 0

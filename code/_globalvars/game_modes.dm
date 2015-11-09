var/master_mode = "infestation"//"extended"
var/secret_force_mode = "infestation" // if this is anything but "secret", the secret rotation will forceably choose this mode

var/wavesecret = 0 // meteor mode, delays wave progression, terrible name
var/datum/station_state/start_state = null // Used in round-end report

var/m_wins = 0
var/a_wins = 0

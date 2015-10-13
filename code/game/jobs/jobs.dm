
var/const/ENGSEC			=(1<<0)

var/const/CAPTAIN			=(1<<0)
var/const/HOS				=(1<<1)
var/const/WARDEN			=(1<<2)
var/const/DETECTIVE			=(1<<3)
var/const/OFFICER			=(1<<4)
var/const/CHIEF				=(1<<5)
var/const/ENGINEER			=(1<<6)
var/const/ATMOSTECH			=(1<<7)
var/const/ROBOTICIST			=(1<<8)
var/const/AI				=(1<<9)
var/const/CYBORG			=(1<<10)

var/const/MARINES			=(1<<0)

var/const/COMMANDER			=(1<<0)
var/const/LOGISTICS			=(1<<1)
var/const/MPOLICE			=(1<<2)
var/const/SULMED			=(1<<3)
var/const/MARINE			=(1<<4)
var/const/ASL				=(1<<5)
var/const/BSL				=(1<<6)
var/const/CSL				=(1<<7)
var/const/DSL				=(1<<8)


var/const/MEDSCI			=(1<<1)

var/const/RD				=(1<<0)
var/const/SCIENTIST			=(1<<1)
var/const/CHEMIST			=(1<<2)
var/const/CMO				=(1<<3)
var/const/DOCTOR			=(1<<4)
var/const/GENETICIST			=(1<<5)
var/const/VIROLOGIST			=(1<<6)


var/const/CIVILIAN			=(1<<2)

var/const/HOP				=(1<<0)
var/const/BARTENDER			=(1<<1)
var/const/BOTANIST			=(1<<2)
var/const/COOK				=(1<<3)
var/const/JANITOR			=(1<<4)
var/const/LIBRARIAN			=(1<<5)
var/const/QUARTERMASTER			=(1<<6)
var/const/CARGOTECH			=(1<<7)
var/const/MINER				=(1<<8)
var/const/LAWYER			=(1<<9)
var/const/CHAPLAIN			=(1<<10)
var/const/CLOWN				=(1<<11)
var/const/MIME				=(1<<12)
var/const/ASSISTANT			=(1<<13)


var/list/assistant_occupations = list(
	"Assistant",
	"Atmospheric Technician",
	"Cargo Technician",
	"Chaplain",
	"Lawyer",
	"Librarian"
)


var/list/command_positions = list(
	"Commander",
	"Logistics Officer",
	"Alpha Squad Leader",
	"Bravo Squad Leader",
	"Charlie Squad Leader",
	"Delta Squad Leader",

	"Captain",
	"Head of Personnel",
	"Head of Security",
	"Chief Engineer",
	"Research Director",
	"Chief Medical Officer"
)


var/list/engineering_positions = list(
	"Chief Engineer",
	"Station Engineer",
	"Atmospheric Technician",
)


var/list/medical_positions = list(
	"Sulaco Medic",

	"Chief Medical Officer",
	"Medical Doctor",
	"Geneticist",
	"Virologist",
	"Chemist"
)


var/list/science_positions = list(
	"Research Director",
	"Scientist",
	"Roboticist"
)


var/list/supply_positions = list(
	"Head of Personnel",
	"Quartermaster",
	"Cargo Technician",
	"Shaft Miner",
)


var/list/civilian_positions = list(
	"Bartender",
	"Botanist",
	"Cook",
	"Janitor",
	"Librarian",
	"Lawyer",
	"Chaplain",
	"Clown",
	"Mime",
	"Assistant"
)


var/list/security_positions = list(
	"Military Police",

	"Head of Security",
	"Warden",
	"Detective",
	"Security Officer"
)

var/list/marine_alpha_positions = list(
	"Alpha Squad Leader",
	"Alpha Squad Standard",
	"Alpha Squad Engineer",
	"Alpha Squad Medic"
)


var/list/marine_bravo_positions = list(
	"Bravo Squad Leader",
	"Bravo Squad Standard",
	"Bravo Squad Engineer",
	"Bravo Squad Medic"
)


var/list/marine_charlie_positions = list(
	"Charlie Squad Leader",
	"Charlie Squad Standard",
	"Charlie Squad Engineer",
	"Charlie Squad Medic"
)


var/list/marine_delta_positions = list(
	"Delta Squad Leader",
	"Delta Squad Standard",
	"Delta Squad Engineer",
	"Delta Squad Medic"
)


var/list/mar_unassigned = list(
	"Marine"
)

var/list/nonhuman_positions = list(
	"AI",
	"Cyborg",
	"pAI"
)


/proc/guest_jobbans(job)
	return ((job in command_positions) || (job in nonhuman_positions) || (job in security_positions))



//this is necessary because antags happen before job datums are handed out, but NOT before they come into existence
//so I can't simply use job datum.department_head straight from the mind datum, laaaaame.
/proc/get_department_heads(var/job_title)
	if(!job_title)
		return list()

	for(var/datum/job/J in SSjob.occupations)
		if(J.title == job_title)
			return J.department_head //this is a list

/datum/robot_hull
	var/icon = 'icons/mob/robots.dmi'
	var/icon_state = "robot"
	var/icon_state_ea = "robot-ea"
	var/icon_panel = "ov"
	var/footstep_sound = SFX_FOOTSTEP_ROBOT_SPIDER

/datum/robot_hull/New(icon, icon_state, icon_state_ea, icon_panel, light_color, footstep_sound)
	src.icon = icon ? icon : initial(src.icon)
	src.icon_state = icon_state ? icon_state : initial(src.icon_state)
	src.icon_state_ea = icon_state_ea ? icon_state_ea : initial(src.icon_state_ea)
	src.icon_panel = icon_panel ? icon_panel : initial(src.icon_panel)
	src.footstep_sound = footstep_sound ? footstep_sound : initial(src.footstep_sound)

/datum/robot_hull/spider
	footstep_sound = SFX_FOOTSTEP_ROBOT_SPIDER

/datum/robot_hull/spider/robot
	icon_state = "robot"

/datum/robot_hull/spider/droid
	icon_state = "droid"
	icon_state_ea = "droid-ea"

/datum/robot_hull/spider/robot_service
	icon_state = "robot-service"

/datum/robot_hull/spider/robot_janitor
	icon_state = "robot-janitor"

/datum/robot_hull/spider/robot_security
	icon_state = "robot-security"

/datum/robot_hull/spider/bloodhound
	icon_state = "bloodhound"
	icon_state_ea = "bloodhound-ea"

/datum/robot_hull/spider/robot_mining
	icon_state = "robot-mining"

/datum/robot_hull/spider/robot_science
	icon_state = "robot-science"

/datum/robot_hull/spider/droid_combat
	icon_state = "droid-combat"
	icon_state_ea = "droid-combat-ea"

/datum/robot_hull/spider/robot_medical
	icon_state = "robot-medical"

/datum/robot_hull/spider/robot_engineer
	icon_state = "robot-engineer"

/datum/robot_hull/spider/landmate
	icon_state = "landmate"
	icon_state_ea = "landmate-ea"

/datum/robot_hull/legs
	icon_state_ea = "android-ea"
	footstep_sound = SFX_FOOTSTEP_ROBOT_LEGS

/datum/robot_hull/legs/robot_old
	icon_state = "robot_old"

/datum/robot_hull/legs/service
	icon_state = "service"

/datum/robot_hull/legs/service2
	icon_state = "service2"

/datum/robot_hull/legs/brobot
	icon_state = "brobot"

/datum/robot_hull/legs/maximillion
	icon_state = "maximillion"
	icon_state_ea = "maximillion-ea"

/datum/robot_hull/legs/maidbot
	icon_state = "maidbot"
	icon_state_ea = "maidbot-ea"

/datum/robot_hull/legs/janbot2
	icon_state = "janbot2"

/datum/robot_hull/legs/janitorrobot
	icon_state = "janitorrobot"
	icon_state_ea = "janitorrobot-ea"

/datum/robot_hull/legs/secborg
	icon_state = "secborg"

/datum/robot_hull/legs/security
	icon_state = "security"
	icon_state_ea = "security-ea"

/datum/robot_hull/legs/securityrobot
	icon_state = "securityrobot"
	icon_state_ea = "securityrobot-ea"

/datum/robot_hull/legs/miner_old
	icon_state = "miner_old"

/datum/robot_hull/legs/droid_miner
	icon_state = "droid-miner"
	icon_state_ea = "droid-miner-ea"

/datum/robot_hull/legs/droid_science
	icon_state = "droid-science"

/datum/robot_hull/legs/medbot
	icon_state = "medbot"

/datum/robot_hull/legs/droid_medical
	icon_state = "droid-medical"

/datum/robot_hull/legs/engineering
	icon_state = "engineering"

/datum/robot_hull/legs/engineerrobot
	icon_state = "engineerrobot"

/datum/robot_hull/legs/kerfur_o_medical
	icon_state = "kerfur-o-medical"
	icon_state_ea = "kerfur-o-ea"
	icon_panel = "kerfur-o"

/datum/robot_hull/legs/kerfur_o_engineering
	icon_state = "kerfur-o-engineering"
	icon_state_ea = "kerfur-o-ea"
	icon_panel = "kerfur-o"

/datum/robot_hull/legs/kerfur_o_miner
	icon_state = "kerfur-o-miner"
	icon_state_ea = "kerfur-o-ea"
	icon_panel = "kerfur-o"

//I haven't found a use for these yet, but I've already drawn sprites for them, so...

/datum/robot_hull/legs/kerfur_o
	icon_state = "kerfur-o"
	icon_state_ea = "kerfur-o-ea"
	icon_panel = "kerfur-o"

/datum/robot_hull/legs/kerfur_o_science
	icon_state = "kerfur-o-science"
	icon_state_ea = "kerfur-o-ea"
	icon_panel = "kerfur-o"

/datum/robot_hull/legs/kerfur_o_security
	icon_state = "kerfur-o-security"
	icon_state_ea = "kerfur-o-ea"
	icon_panel = "kerfur-o"

/datum/robot_hull/truck
	// TODO: Add truck sound
	footstep_sound = null

/datum/robot_hull/truck/mopgearrex
	icon_state = "mopgearrex"
	icon_state_ea = "mopgearrex-ea"

/datum/robot_hull/truck/secborg_tread
	icon_state = "secborg+tread"
	icon_state_ea = "secborg+tread-ea"

/datum/robot_hull/truck/miner
	icon_state = "miner"
	icon_state_ea = "miner-ea"

/datum/robot_hull/truck/engiborg_tread
	icon_state = "engiborg+tread"
	icon_state_ea = "engiborg+tread-ea"

/datum/robot_hull/flying
	icon_panel = "drone"
	icon_state_ea = "drone-ea"
	footstep_sound = null

/datum/robot_hull/flying/drone_standard
	icon_state = "drone-standard"

/datum/robot_hull/flying/eyebot_standard
	icon_state = "eyebot-standard"
	icon_state_ea = "eyebot-ea"

/datum/robot_hull/flying/toiletbot
	icon_state = "toiletbot"
	icon_state_ea = "toiletbot"

/datum/robot_hull/flying/drone_service
	icon_state = "drone-service"

/datum/robot_hull/flying/drone_hydro
	icon_state = "drone-hydro"

/datum/robot_hull/flying/drone_janitor
	icon_state = "drone-janitor"

/datum/robot_hull/flying/eyebot_janitor
	icon_state = "eyebot-janitor"
	icon_state_ea = "eyebot-ea"

/datum/robot_hull/flying/drone_sec
	icon_state = "drone-sec"

/datum/robot_hull/flying/eyebot_security
	icon_state = "eyebot-security"
	icon_state_ea = "eyebot-ea"

/datum/robot_hull/flying/orb_security
	icon_state = "orb-security"
	icon_state_ea = "orb-security-ea"

/datum/robot_hull/flying/drone_miner
	icon_state = "drone-miner"

/datum/robot_hull/flying/eyebot_miner
	icon_state = "eyebot-miner"
	icon_state_ea = "eyebot-ea"

/datum/robot_hull/flying/drone_science
	icon_state = "drone-science"

/datum/robot_hull/flying/eyebot_science
	icon_state = "eyebot-science"
	icon_state_ea = "eyebot-ea"

/datum/robot_hull/flying/surgeon
	icon_state = "surgeon"
	icon_state_ea = "surgeon-ea"

/datum/robot_hull/flying/drone_medical
	icon_state = "drone-medical"

/datum/robot_hull/flying/eyebot_medical
	icon_state = "eyebot-medical"
	icon_state_ea = "eyebot-ea"

/datum/robot_hull/flying/drone_engineer
	icon_state = "drone-engineer"

/datum/robot_hull/flying/eyebot_engineering
	icon_state = "eyebot-engineering"
	icon_state_ea = "eyebot-ea"

/datum/robot_hull/drone
	icon_state = "repairbot"
	icon_state_ea = "repairbot-ea"
	footstep_sound = SFX_FOOTSTEP_ROBOT_SPIDER

/datum/robot_hull/drone/construction
	icon_state = "constructiondrone"
	icon_state_ea = "constructiondrone-ea"

/datum/robot_hull/sphere
	icon_state_ea = "kerfur-ea"
	icon_panel = "kerfur"
	footstep_sound = SFX_FOOTSTEP_ROBOT_SPHERE

/datum/robot_hull/sphere/kerfur
	icon_state = "kerfur"

/datum/robot_hull/sphere/kerfur_service
	icon_state = "kerfur-service"

/datum/robot_hull/sphere/kerfur_janitor
	icon_state = "kerfur-janitor"

/datum/robot_hull/sphere/kerfur_security
	icon_state = "kerfur-security"

/datum/robot_hull/sphere/kerfur_miner
	icon_state = "kerfur-miner"

/datum/robot_hull/sphere/kerfur_science
	icon_state = "kerfur-science"

/datum/robot_hull/sphere/kerfur_medical
	icon_state = "kerfur-medical"

/datum/robot_hull/sphere/kerfur_engineering
	icon_state = "kerfur-engineer"

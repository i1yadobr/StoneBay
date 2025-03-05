/area/future
	name = "Base future area"
	area_flags = AREA_FLAG_RAD_SHIELDED


// SHUTTLES
// Shuttle areas must contain at least two areas in a subgroup if you want to move a shuttle from one place to another.
// Look at escape shuttle for example.
// All shuttles should now be under shuttle since we have smooth-wall code.
/area/future/shuttle/administration/centcom
	name = "\improper Administration Shuttle"
	icon_state = "shuttlered"

/area/future/shuttle/administration/station
	name = "\improper Administration Shuttle"
	icon_state = "shuttlered2"

/area/future/shuttle/supply/elevator
	name = "Cargo Elevator"
	icon_state = "shuttle3"

/area/future/shuttle/supply/elevator/upper
	name = "Cargo Elevator Upper Deck"
	base_turf = /turf/simulated/open

/area/future/shuttle/supply/elevator/lower
	name = "Cargo Elevator Lower Deck"
	base_turf = /turf/simulated/floor/plating

/area/future/shuttle/merchant
	icon_state = "shuttlegrn"

/area/future/shuttle/merchant/home
	name = "\improper Merchant Van - Home"

/area/future/shuttle/merchant/transit
	icon_state = "shuttlegrn"
	base_turf = /turf/space/transit/south

/area/future/shuttle/merchant/away
	name = "\improper Merchant Van - Station North East"

/area/future/shuttle/merchant/dock
	name = "\improper Merchant Van - Station Docking Bay"

/area/future/shuttle/merchant/ghetto
	name = "\improper Merchant Van - Station Ghetto Dock"

/area/future/shuttle/merchant/outpost
	name = "\improper Merchant Van - Outpost"

// Command
/area/future/crew_quarters/heads/chief
	name = "\improper Engineering - CE's Office"

/area/future/crew_quarters/heads/hos
	name = "\improper Security - HoS' Office"

/area/future/crew_quarters/heads/hop
	name = "\improper Command - HoP's Office"

/area/future/crew_quarters/heads/hor
	name = "\improper Research - RD's Office"

/area/future/crew_quarters/heads/cmo
	name = "\improper Command - CMO's Office"

/area/future/bridge
	name = "\improper Bridge"
	icon_state = "bridge"

/area/future/bridge/meeting_room
	name = "\improper Heads of Staff Meeting Room"
	sound_env = MEDIUM_SOFTFLOOR

/area/future/bridge/meeting_room/cafe
	name = "\improper Heads of Staff Cafeteria"

// Shuttles

/area/future/shuttle/constructionsite
	name = "Construction Site Shuttle"
	icon_state = "yellow"

/area/future/shuttle/constructionsite/station
	name = "Construction Site Shuttle"

/area/future/shuttle/constructionsite/transit
	name = "Construction Site Shuttle Transit"
	icon_state = "shuttle"

/area/future/shuttle/mining
	name = "\improper Mining Shuttle"

/area/future/shuttle/mining/outpost
	icon_state = "shuttle"
	base_turf = /turf/simulated/floor/asteroid
	area_flags = AREA_FLAG_UNIQUE_AREA

/area/future/shuttle/mining/station
	icon_state = "shuttle2"

/area/future/shuttle/mining/transit
	name = "Mining Shuttle Transit"
	icon_state = "shuttle"

/area/future/shuttle/security
	name = "\improper Security Shuttle"

/area/future/shuttle/security/outpost
	icon_state = "shuttle"
	base_turf = /turf/simulated/floor/asteroid

/area/future/shuttle/security/station
	icon_state = "shuttle2"

/area/future/shuttle/security/transit
	name = "Mining Security Transit"
	icon_state = "shuttle"

/area/future/shuttle/deathsquad/centcom
	name = "Deathsquad Shuttle"
	area_flags = AREA_FLAG_RAD_SHIELDED | AREA_FLAG_UNIQUE_AREA

/area/future/shuttle/deathsquad/transit
	name = "Deathsquad Shuttle Internim"
	area_flags = AREA_FLAG_RAD_SHIELDED | AREA_FLAG_UNIQUE_AREA

/area/future/shuttle/deathsquad/station
	name = "Deathsquad Shuttle Station"

/area/future/shuttle/administration
	area_flags = AREA_FLAG_RAD_SHIELDED | AREA_FLAG_UNIQUE_AREA

/area/future/shuttle/syndicate_elite
	name = "\improper Syndicate Elite Shuttle"
	area_flags = AREA_FLAG_RAD_SHIELDED | AREA_FLAG_UNIQUE_AREA

/area/future/shuttle/transport/centcom
	icon_state = "shuttle"
	name = "\improper Transport Shuttle Centcom"

/area/future/shuttle/transport/transit
	icon_state = "shuttle"
	name = "\improper Transport Shuttle Transit"

/area/future/shuttle/transport/station
	icon_state = "shuttle"
	name = "\improper Transport Shuttle"

/area/future/shuttle/alien/mine
	icon_state = "shuttle"
	name = "\improper Alien Shuttle Mine"
	requires_power = 1

/area/future/shuttle/alien/base
	icon_state = "shuttle"
	name = "\improper Alien Shuttle Base"
	requires_power = 1

/area/future/shuttle/arrival
	name = "\improper Arrival Shuttle"

/area/future/shuttle/arrival/station
	icon_state = "shuttle"

/area/future/shuttle/escape/centcom
	name = "\improper Emergency Shuttle Centcom"
	icon_state = "shuttle"

/area/future/shuttle/escape
	name = "\improper Emergency Shuttle"
	area_flags = AREA_FLAG_RAD_SHIELDED | AREA_FLAG_UNIQUE_AREA

/area/future/shuttle/escape/station
	name = "\improper Emergency Shuttle Station"
	icon_state = "shuttle2"

/area/future/shuttle/escape/transit // the area to pass through for 3 minute transit
	name = "\improper Emergency Shuttle Transit"
	icon_state = "shuttle"

/area/future/shuttle/escape_pod1
	name = "\improper Escape Pod One"
	area_flags = AREA_FLAG_RAD_SHIELDED | AREA_FLAG_UNIQUE_AREA

/area/future/shuttle/escape_pod1/station
	icon_state = "shuttle2"

/area/future/shuttle/escape_pod1/transit
	icon_state = "shuttle"
	base_turf = /turf/space/transit/north

/area/future/shuttle/escape_pod2
	name = "\improper Escape Pod Two"
	area_flags = AREA_FLAG_RAD_SHIELDED | AREA_FLAG_UNIQUE_AREA

/area/future/shuttle/escape_pod2/station
	icon_state = "shuttle2"

/area/future/shuttle/escape_pod2/transit
	icon_state = "shuttle"
	base_turf = /turf/space/transit/north

/area/future/shuttle/escape_pod3
	name = "\improper Escape Pod Three"
	area_flags = AREA_FLAG_RAD_SHIELDED | AREA_FLAG_UNIQUE_AREA

/area/future/shuttle/escape_pod3/station
	icon_state = "shuttle2"

/area/future/shuttle/escape_pod3/transit
	icon_state = "shuttle"
	base_turf = /turf/space/transit/east

/area/future/shuttle/escape_pod5 // Pod 4 was lost to meteors
	name = "\improper Escape Pod Five"
	area_flags = AREA_FLAG_RAD_SHIELDED | AREA_FLAG_UNIQUE_AREA

/area/future/shuttle/escape_pod5/station
	icon_state = "shuttle2"

/area/future/shuttle/escape_pod5/transit
	icon_state = "shuttle"
	base_turf = /turf/space/transit/east

/area/future/shuttle/administration/transit
	name = "Administration Shuttle Transit"
	icon_state = "shuttle"
	base_turf = /turf/space/transit/east

// === Trying to remove these areas:

/area/future/shuttle/research
	name = "\improper Research Shuttle"

/area/future/shuttle/research/station
	icon_state = "shuttle2"

/area/future/shuttle/research/outpost
	icon_state = "shuttle"
	base_turf = /turf/simulated/floor/asteroid

/area/future/shuttle/research/transit
	name = "Research Shuttle Transit"
	icon_state = "shuttle"

// SYNDICATES

/area/future/syndicate_mothership
	name = "\improper Syndicate Base"
	icon_state = "syndie-ship"
	requires_power = 0
	dynamic_lighting = 0

/area/future/syndicate_mothership/ninja
	name = "\improper Ninja Base"
	requires_power = 0
	base_turf = /turf/space/transit/north

// RESCUE

// names are used
/area/future/rescue_base
	name = "\improper Response Team Base"
	icon_state = "yellow"
	requires_power = 0
	dynamic_lighting = 1
	area_flags = AREA_FLAG_RAD_SHIELDED | AREA_FLAG_UNIQUE_AREA

/area/future/rescue_base/base
	name = "\improper Barracks"
	icon_state = "yellow"
	dynamic_lighting = 0

/area/future/rescue_base/start
	name = "\improper Response Team Base"
	icon_state = "shuttlered"

/area/future/rescue_base/southwest
	name = "south-west of SS13"
	icon_state = "southwest"

/area/future/rescue_base/northwest
	name = "north-west of SS13"
	icon_state = "northwest"

/area/future/rescue_base/northeast
	name = "north-east of SS13"
	icon_state = "northeast"

/area/future/rescue_base/southeast
	name = "south-east of SS13"
	icon_state = "southeast"

/area/future/rescue_base/north
	name = "north of SS13"
	icon_state = "north"

/area/future/rescue_base/south
	name = "south of SS13"
	icon_state = "south"

/area/future/rescue_base/arrivals_dock
	name = "docked with station"
	icon_state = "shuttle"

/area/future/rescue_base/transit
	name = "\proper bluespace"
	icon_state = "shuttle"
	base_turf = /turf/space/transit/north

// MINING MOTHERSHIP

/area/future/creaker
	name = "\improper Mining Ship 'Creaker'"
	icon_state = "yellow"
	area_flags = AREA_FLAG_RAD_SHIELDED | AREA_FLAG_UNIQUE_AREA

/area/future/creaker/station
	name = "\improper Mining Ship 'Creaker'"
	icon_state = "shuttlered"

/area/future/creaker/north
	name = "northern asteroid field"
	icon_state = "southwest"

/area/future/creaker/west
	name = "western asteroid field"
	icon_state = "northwest"

/area/future/creaker/east
	name = "eastern asteroid field"
	icon_state = "northeast"

// ENEMY

// names are used
/area/future/syndicate_station
	name = "\improper Independant Station"
	icon_state = "yellow"
	requires_power = 0
	area_flags = AREA_FLAG_RAD_SHIELDED | AREA_FLAG_UNIQUE_AREA

/area/future/syndicate_station/start
	name = "\improper Syndicate Forward Operating Base"
	icon_state = "yellow"

/area/future/syndicate_station/southwest
	name = "south-west of SS13"
	icon_state = "southwest"

/area/future/syndicate_station/northwest
	name = "north-west of SS13"
	icon_state = "northwest"

/area/future/syndicate_station/northeast
	name = "north-east of SS13"
	icon_state = "northeast"

/area/future/syndicate_station/southeast
	name = "south-east of SS13"
	icon_state = "southeast"

/area/future/syndicate_station/north
	name = "north of SS13"
	icon_state = "north"

/area/future/syndicate_station/south
	name = "south of SS13"
	icon_state = "south"

/area/future/syndicate_station/transit
	name = "\proper bluespace"
	icon_state = "shuttle"
	base_turf = /turf/space/transit/north

/area/future/shuttle/syndicate_elite/northwest
	icon_state = "northwest"

/area/future/shuttle/syndicate_elite/northeast
	icon_state = "northeast"

/area/future/shuttle/syndicate_elite/southwest
	icon_state = "southwest"

/area/future/shuttle/syndicate_elite/southeast
	icon_state = "southeast"

/area/future/shuttle/syndicate_elite/transit
	name = "\proper bluespace"
	icon_state = "shuttle"
	base_turf = /turf/space/transit/north

/area/future/skipjack_station
	name = "\improper Skipjack"
	icon_state = "yellow"
	requires_power = 0
	ambient_music_tags = list(MUSIC_TAG_MYSTIC, MUSIC_TAG_SPACE)

/area/future/skipjack_station/southwest_solars
	name = "aft port solars"
	icon_state = "southwest"

/area/future/skipjack_station/northwest_solars
	name = "fore port solars"
	icon_state = "northwest"

/area/future/skipjack_station/northeast_solars
	name = "fore starboard solars"
	icon_state = "northeast"

/area/future/skipjack_station/southeast_solars
	name = "aft starboard solars"
	icon_state = "southeast"

/area/future/skipjack_station/base
	name = "Raider Base"
	icon_state = "yellow"
	base_turf = /turf/simulated/floor/asteroid

/area/future/skipjack_station/start
	name = "\improper Skipjack"
	icon_state = "shuttlered"

/area/future/skipjack_station/transit
	name = "Skipjack Transit"
	icon_state = "shuttle"
	base_turf = /turf/space/transit/north

// SUBSTATIONS (Subtype of maint, that should let them serve as shielded area during radstorm)

/area/future/maintenance/substation
	name = "Substation"
	icon_state = "substation"
	sound_env = SMALL_ENCLOSED

/area/future/maintenance/substation/command // AI and central cluster. This one will be between HoP office and meeting room (probably).
	name = "Command Substation"

/area/future/maintenance/substation/engineering // Probably will be connected to engineering SMES room, as wires cannot be crossed properly without them sharing powernets.
	name = "Engineering Substation"

/area/future/maintenance/substation/medical // Medbay
	name = "Medical Substation"

/area/future/maintenance/substation/research // Research
	name = "Research Substation"

/area/future/maintenance/substation/civilian_east // Bar, kitchen, dorms, ...
	name = "Civilian East Substation"

/area/future/maintenance/substation/civilian_west // Cargo, PTS, locker room, probably arrivals, ...)
	name = "Civilian West Substation"

/area/future/maintenance/substation/security // Security, Brig, Permabrig, etc.
	name = "Security Substation"

/area/future/maintenance/substation/atmospherics
	name = "Atmospherics Substation"

/area/future/maintenance/substation/cargo
	name = "Cargo Substation"

/area/future/maintenance/substation/starport
	name = "Starport Substation"

/area/future/maintenance/substation/hydro
	name = "Hydroponics Substation"

/area/future/maintenance/substation/emergency
	name = "Emergency Substation"

// Maintenance

/area/future/maintenance/disposal
	name = "\improper Trash Disposal"
	icon_state = "disposal"

/area/future/maintenance/ghetto_medbay
	name = "\improper Ghetto Medbay"
	icon_state = "ghettomedbay"

/area/future/maintenance/ghetto_minicasino
	name = "\improper Ghetto Mini Casino"
	icon_state = "ghettominicasino"

/area/future/maintenance/ghetto_rnd
	name = "\improper Ghetto RnD"
	icon_state = "ghettornd"

/area/future/maintenance/ghetto_janitor
	name = "\improper Ghetto Janitor Room"
	icon_state = "ghettojanitor"

/area/future/maintenance/ghetto_virology
	name = "\improper Ghetto Virology"
	icon_state = "ghettovirology"

/area/future/maintenance/ghetto_shop
	name = "\improper Ghetto Shop"
	icon_state = "ghettoshop"

/area/future/maintenance/ghetto_bar
	name = "\improper Ghetto Bar"
	icon_state = "ghettobar"

/area/future/maintenance/ghetto_library
	name = "\improper Ghetto Library"
	icon_state = "ghettolibrary"

/area/future/maintenance/ghetto_toilet
	name = "\improper Underground Toilets"
	icon_state = "ghettotoilets"

/area/future/maintenance/ghetto_dorm
	name = "\improper Abandoned Dorm"
	icon_state = "ghettodorm"

/area/future/maintenance/ghetto_main
	name = "\improper Underground Main"
	icon_state = "ghettomain"

/area/future/maintenance/ghetto_main_south
	name = "\improper Underground Main - South"
	icon_state = "ghettomainsouth"

/area/future/maintenance/ghetto_main_west
	name = "\improper Underground Main - West"
	icon_state = "ghettomainsouth"

/area/future/maintenance/ghetto_eva
	name = "\improper Ghetto EVA"
	icon_state = "ghettoeva"

/area/future/maintenance/ghetto_eva_maint
	name = "\improper Ghetto EVA Maintenance"
	icon_state = "ghettoevamaint"

/area/future/maintenance/ghetto_casino
	name = "\improper Ghetto Casino"
	icon_state = "ghettocasino"

/area/future/maintenance/ghetto_syndie
	name = "\improper Ghetto Syndie"
	icon_state = "ghettosyndie"

/area/future/maintenance/ghetto_dockhall
	name = "\improper Underground Dock Hall"
	icon_state = "ghettodockhall"

/area/future/maintenance/ghetto_cafe
	name = "\improper Underground Cafe"
	icon_state = "ghettocafe"

/area/future/maintenance/ghetto_strangeplace
	name = "\improper Underground Bar"
	icon_state = "ghettostrangeplace"

/area/future/maintenance/ghetto_detective
	name = "\improper Abandoned Detective's Office"
	icon_state = "ghettodetective"

/area/future/maintenance/underground/central_one
	name = "\improper Underground Central Primary Hallway SE"
	icon_state = "uhall1"

/area/future/maintenance/underground/central_two
	name = "\improper Underground Central Primary Hallway SW"
	icon_state = "uhall2"

/area/future/maintenance/underground/central_three
	name = "\improper Underground Central Primary Hallway NW"
	icon_state = "uhall3"

/area/future/maintenance/underground/central_four
	name = "\improper Underground Central Primary Hallway NE"
	icon_state = "uhall4"

/area/future/maintenance/underground/central_five
	name = "\improper Underground Central Primary Hallway E"
	icon_state = "uhall5"

/area/future/maintenance/underground/central_six
	name = "\improper Underground Central Primary Hallway N"
	icon_state = "uhall6"

/area/future/maintenance/underground/cargo
	name = "\improper Underground Cargo Maintenance"
	icon_state = "ucargo"

/area/future/maintenance/underground/atmospherics
	name = "\improper Underground Atmospherics Maintenance"
	icon_state = "uatmos"


/area/future/maintenance/underground/arrivals
	name = "\improper Underground Arrivals Maintenance"
	icon_state = "uarrival"

/area/future/maintenance/underground/locker_room
	name = "\improper Underground Locker Room Maintenance"
	icon_state = "ulocker"

/area/future/maintenance/underground/EVA
	name = "\improper Underground EVA Maintenance"
	icon_state = "uEVA"

/area/future/maintenance/underground/security
	name = "\improper Underground Security Maintenance"
	icon_state = "usecurity"

/area/future/maintenance/underground/security_west
	name = "\improper Underground Security Maintenance - West"
	icon_state = "usecuritywest"

/area/future/maintenance/underground/security_port
	name = "\improper Underground Security Port Maintenance"
	icon_state = "usecurityport"

/area/future/maintenance/underground/security_main
	name = "\improper Underground Security Main Maintenance"
	icon_state = "usecuritymain"

/area/future/maintenance/underground/security_lobby
	name = "\improper Underground Security Lobby Maintenance"
	icon_state = "usecuritylobby"

/area/future/maintenance/underground/security_firefighting
	name = "\improper Underground Security Tech Room"
	icon_state = "usecurityfirefighting"

/area/future/maintenance/underground/security_dorms
	name = "\improper Underground Security Dormitories"
	icon_state = "usecuritybreak"

/area/future/maintenance/underground/security_breakroom
	name = "\improper Underground Security Break Room"
	icon_state = "usecuritybreak"

/area/future/maintenance/underground/security_storage
	name = "\improper Underground Security Storage Room"
	icon_state = "usecuritystorage"

/area/future/maintenance/underground/security_mainhall
	name = "\improper Underground Security Main Hall"
	icon_state = "usecuritylobby"

/area/future/maintenance/underground/security_hallway
	name = "\improper Underground Security Hallway"
	icon_state = "usecurityhall"

/area/future/maintenance/underground/security_meeting
	name = "\improper Underground Security Meeting Maintenance"
	icon_state = "usecuritymeeting"

/area/future/maintenance/underground/engineering
	name = "\improper Underground Engineering Maintenance"
	icon_state = "uengineering"

/area/future/maintenance/underground/engineering_lower
	name = "\improper Underground Engineering"
	icon_state = "uengineering"

/area/future/maintenance/underground/research
	name = "\improper Underground Research Maintenance"
	icon_state = "uresearch"

/area/future/maintenance/underground/robotics_lab
	name = "\improper Underground Robotics Lab Maintenance"
	icon_state = "urobotics"

/area/future/maintenance/underground/research_port
	name = "\improper Underground Research Port Maintenance"
	icon_state = "uresearchport"

/area/future/maintenance/underground/research_shuttle
	name = "\improper Underground Research Shuttle Dock Maintenance"
	icon_state = "uresearchshuttle"

/area/future/maintenance/underground/research_utility_room
	name = "\improper Underground Utility Room"
	icon_state = "uresearchutilityroom"

/area/future/maintenance/underground/research_starboard
	name = "\improper Underground Research Maintenance - Starboard"
	icon_state = "uresearchstarboard"

/area/future/maintenance/underground/research_xenobiology
	name = "\improper Underground Research Xenobiology Maintenance"
	icon_state = "uresearchxeno"

/area/future/maintenance/underground/research_misc
	name = "\improper Underground Research Miscellaneous Maintenance"
	icon_state = "uresearchmisc"

/area/future/maintenance/underground/civilian_NE
	name = "\improper Underground Civilian NE Maintenance"
	icon_state = "ucivne"

/area/future/maintenance/underground/medbay
	name = "\improper Underground Medbay Maintenance"
	icon_state = "umedbay"

/area/future/maintenance/underground/medbay/south
	name = "\improper Underground Medbay Maintenance - South"
	icon_state = "umedbay"

/area/future/maintenance/underground/dormitories
	name = "\improper Underground Dormitories Maintenance"
	icon_state = "udorm"

/area/future/maintenance/underground/warehouse
	name = "\improper Underground Warehouse Maintenance"
	icon_state = "uwarehouse"

/area/future/maintenance/underground/vault
	name = "\improper Underground Vault Maintenance"
	icon_state = "uvault"

/area/future/maintenance/underground/tool_storage
	name = "\improper Underground Tool Storage Maintenance"
	icon_state = "utoolstorage"

/area/future/maintenance/underground/janitor
	name = "\improper Underground Custodial Closet Maintenance"
	icon_state = "ujanitor"

/area/future/maintenance/underground/vaccant_office
	name = "\improper Underground Vaccant Office Maintenance"
	icon_state = "uvaccant"

/area/future/maintenance/underground/engine
	name = "\improper Underground Engine Maintenance"
	icon_state = "uengine"

/area/future/maintenance/underground/incinerator
	name = "\improper Underground Incinerator Maintenance"
	icon_state = "uincinerator"

/area/future/maintenance/underground/port_primary_hallway
	name = "\improper Underground Port Primary Hallway Maintenance"
	icon_state = "uportprim"

/area/future/maintenance/underground/board_games_club
	name = "\improper Underground Board Games Club"
	icon_state = "uportprim"

/area/future/maintenance/underground/gateway
	name = "\improper Underground Gateway Maintenance"
	icon_state = "ugateway"

/area/future/maintenance/underground/fitness
	name = "\improper Underground Fitness Room Maintenance"
	icon_state = "ufitness"

/area/future/maintenance/underground/bar
	name = "\improper Underground Bar Maintenance"
	icon_state = "ubar"

/area/future/maintenance/underground/kitchen
	name = "\improper Underground Kitchen Maintenance"
	icon_state = "ukitchen"

/area/future/maintenance/underground/hydroponics
	name = "\improper Underground Hydroponics Maintenance"
	icon_state = "uhydro"

/area/future/maintenance/underground/library
	name = "\improper Underground Library Maintenance"
	icon_state = "ulibrary"

/area/future/maintenance/underground/starboard_primary_hallway
	name = "\improper Starboard Primary Hallway Maintenance"
	icon_state = "ustarboard"

/area/future/maintenance/underground/cloning_entrance
	name = "\improper Undefined Area"
	icon_state = "dark"

/area/future/maintenance/underground/cloning_checkpoint
	name = "\improper Undefined Area"
	icon_state = "dark"

/area/future/maintenance/underground/cloning_storage
	name = "\improper Undefined Area"
	icon_state = "dark"

/area/future/maintenance/underground/cloning_lobby
	name = "\improper Undefined Area"
	icon_state = "dark"

/area/future/maintenance/underground/cloning_laboratory
	name = "\improper Undefined Area"
	icon_state = "dark"

/area/future/maintenance/underground/cloning_surgery
	name = "\improper Undefined Area"
	icon_state = "dark"

/area/future/maintenance/underground/cloning_morgue
	name = "\improper Undefined Area"
	icon_state = "dark"

/area/future/maintenance/underground/cloning_cells
	name = "\improper Undefined Area"
	icon_state = "dark"

/area/future/maintenance/atmos_control
	name = "\improper Atmospherics Maintenance"
	icon_state = "fpmaint"

/area/future/maintenance/arrivals
	name = "\improper Arrivals Maintenance"
	icon_state = "maint_arrivals"

/area/future/maintenance/bar
	name = "\improper Bar Maintenance"
	icon_state = "maint_bar"

/area/future/maintenance/cargo
	name = "\improper Cargo Maintenance"
	icon_state = "maint_cargo"

/area/future/maintenance/engi_engine
	name = "\improper Engine Maintenance"
	icon_state = "maint_engine"

/area/future/maintenance/engi_shuttle
	name = "\improper Engineering Shuttle Access"
	icon_state = "maint_e_shuttle"

/area/future/maintenance/engineering
	name = "\improper Engineering Maintenance"
	icon_state = "maint_engineering"

/area/future/maintenance/evahallway
	name = "\improper EVA Maintenance"
	icon_state = "maint_eva"

/area/future/maintenance/dormitory
	name = "\improper Dormitory Maintenance"
	icon_state = "maint_dormitory"

/area/future/maintenance/library
	name = "\improper Library Maintenance"
	icon_state = "maint_library"

/area/future/maintenance/locker
	name = "\improper Locker Room Maintenance"
	icon_state = "maint_locker"

/area/future/maintenance/medbay
	name = "\improper Medbay Maintenance"
	icon_state = "maint_medbay"

/area/future/maintenance/bridge
	name = "\improper Bridge Maintenance"
	icon_state = "maint_eva"

/area/future/maintenance/bridge/west
	name = "\improper Bridge Maintenance - West"

/area/future/maintenance/bridge/east
	name = "\improper Bridge Maintenance - East"

/area/future/maintenance/research_port
	name = "\improper Research Maintenance - Port"
	icon_state = "maint_research_port"

/area/future/maintenance/research_shuttle
	name = "\improper Research Shuttle Dock Maintenance"
	icon_state = "maint_research_shuttle"

/area/future/maintenance/research_starboard
	name = "\improper Research Maintenance - Starboard"
	icon_state = "maint_research_starboard"

/area/future/maintenance/security_port
	name = "\improper Security Maintenance - Port"
	icon_state = "maint_security_port"

/area/future/maintenance/security_starboard
	name = "\improper Security Maintenance - Starboard"
	icon_state = "maint_security_starboard"

/area/future/maintenance/exterior
	name = "\improper Exterior Reinforcements"
	icon_state = "maint_security_starboard"
	area_flags = AREA_FLAG_EXTERNAL & AREA_FLAG_NO_STATION
	has_gravity = FALSE
	turf_initializer = /decl/turf_initializer/maintenance/space

/area/future/maintenance/research_atmos
	name = "\improper Research Atmospherics Maintenance"
	icon_state = "maint_engineering"

/area/future/maintenance/medbay_north
	name = "\improper North Medbay Maintenance"
	icon_state = "maint_medbay"

/area/future/maintenance/hydro
	name = "\improper Hydroponics Maintenance"
	icon_state = "maint_medbay"

/area/future/maintenance/chapel
	name = "\improper Chapel Maintenance"
	icon_state = "maint_security_port"

/area/future/maintenance/chapel/north
	name = "\improper Chapel Maintenance - North"

/area/future/maintenance/chapel/south
	name = "\improper Chapel Maintenance - South"

/area/future/maintenance/abandoned_casino
	name = "\improper Abandoned Casino"
	icon_state = "ghettocasino"


/area/future/maintenance/getto_rnd
	name = "\improper RnD Maintenance"
	icon_state = "maint_cargo"

/area/future/maintenance/disposal/underground
	name = "Underground Waste Disposal"
	icon_state = "disposal"

// Dank Maintenance
/area/future/maintenance/sub
	turf_initializer = /decl/turf_initializer/maintenance/heavy

/area/future/maintenance/sub/relay_station
	name = "\improper Sublevel Maintenance - Relay Station"
	icon_state = "blue2"
	turf_initializer = null

/area/future/maintenance/sub/fore
	name = "\improper Sublevel Maintenance - Fore"
	icon_state = "sub_maint_fore"

/area/future/maintenance/sub/aft
	name = "\improper Sublevel Maintenance - Aft"
	icon_state = "sub_maint_aft"

/area/future/maintenance/sub/port
	name = "\improper Sublevel Maintenance - Port"
	icon_state = "sub_maint_port"

/area/future/maintenance/sub/starboard
	name = "\improper Sublevel Maintenance - Starboard"
	icon_state = "sub_maint_starboard"

/area/future/maintenance/sub/central
	name = "\improper Sublevel Maintenance - Central"
	icon_state = "sub_maint_central"

/area/future/maintenance/sub/command
	name = "\improper Sublevel Maintenance - Command"
	icon_state = "sub_maint_command"
	turf_initializer = null

// Hallway

/area/future/hallway/primary/
	sound_env = LARGE_ENCLOSED

/area/future/hallway/primary/fore
	name = "\improper Fore Primary Hallway"
	icon_state = "hallF"

/area/future/hallway/primary/starboard
	name = "\improper Starboard Primary Hallway"
	icon_state = "hallS"

/area/future/hallway/primary/aft
	name = "\improper Aft Primary Hallway"
	icon_state = "hallA"

/area/future/hallway/primary/port
	name = "\improper Port Primary Hallway"
	icon_state = "hallP"

/area/future/hallway/primary/seclobby
	name = "\improper Security Lobby"
	icon_state = "security"

/area/future/hallway/primary/englobby
	name = "\improper Engineering Foyer"
	icon_state = "engineering_foyer"

/area/future/hallway/primary/central_one
	name = "\improper Central Primary Hallway"
	icon_state = "hallC1"

/area/future/hallway/primary/central_two
	name = "\improper Central Primary Hallway"
	icon_state = "hallC2"

/area/future/hallway/primary/central_three
	name = "\improper Central Primary Hallway"
	icon_state = "hallC3"

/area/future/hallway/primary/central_fore
	name = "\improper Central Primary Hallway"
	icon_state = "hallC3"

/area/future/hallway/primary/central_fife
	name = "\improper Central Primary Hallway"
	icon_state = "hallC3"

/area/future/hallway/primary/central_six
	name = "\improper Central Primary Hallway"
	icon_state = "hallC3"

/area/future/hallway/primary/central_seven
	name = "\improper Central Primary Hallway"
	icon_state = "hallC3"

/area/future/hallway/primary/frontier
	name = "\improper Central Hallway"
	icon_state = "hallC1"

/area/future/hallway/primary/frontier/ring_north
	name = "\improper Ring Hallway - North"
	icon_state = "hallF"

/area/future/hallway/primary/frontier/ring_south
	name = "\improper Ring Hallway - South"
	icon_state = "hallP"

/area/future/hallway/primary/frontier/central_mideast
	name = "\improper Central Hallway - Mideast"
	icon_state = "hallC2"

/area/future/hallway/primary/frontier/central_east
	name = "\improper Central Hallway - East"
	icon_state = "hallC2"

/area/future/hallway/primary/frontier/central_midwest
	name = "\improper Central Hallway - Midwest"
	icon_state = "hallC3"

/area/future/hallway/primary/frontier/central_west
	name = "\improper Central Hallway - West"
	icon_state = "hallC3"

/area/future/hallway/primary/frontier/brighall
	name = "\improper Brig Hallway"
	icon_state = "security"

/area/future/hallway/primary/frontier/dormhall
	name = "\improper Dormitory Hallway"
	icon_state = "Sleep"




/area/future/hallway/secondary/exit
	name = "\improper Escape Shuttle Hallway"
	icon_state = "escape"

/area/future/hallway/secondary/entry/pods
	name = "\improper Arrival Shuttle Hallway - Escape Pods"
	icon_state = "entry_pods"

/area/future/hallway/secondary/entry/fore
	name = "\improper Arrival Shuttle Hallway - Fore"
	icon_state = "entry_1"

/area/future/hallway/secondary/entry/port
	name = "\improper Arrival Shuttle Hallway - Port"
	icon_state = "entry_2"

/area/future/hallway/secondary/entry/starboard
	name = "\improper Arrival Shuttle Hallway - Starboard"
	icon_state = "entry_3"

/area/future/hallway/secondary/entry/aft
	name = "\improper Arrival Shuttle Hallway - Aft"
	icon_state = "entry_4"

// Command

/area/future/crew_quarters/captain
	name = "\improper Command - Captain's Office"
	icon_state = "captain"
	sound_env = MEDIUM_SOFTFLOOR

// Crew


/area/future/crew_quarters
	name = "\improper Dormitories"
	icon_state = "Sleep"

/area/future/crew_quarters/locker
	name = "\improper Locker Room"
	icon_state = "locker"

/area/future/crew_quarters/toilet
	name = "\improper Dormitory Toilets"
	icon_state = "toilet"
	sound_env = SMALL_ENCLOSED

/area/future/crew_quarters/toilet/bar
	name = "\improper Bar Toilet"

/area/future/crew_quarters/toilet/west
	name = "\improper West Hallway Bathroom"

/area/future/crew_quarters/sleep
	name = "\improper Dormitories"
	icon_state = "Sleep"

/area/future/crew_quarters/sleep/cryo
	name = "\improper Cryogenic Storage"
	icon_state = "Cryopods"

/area/future/crew_quarters/sleep2
	name = "\improper Dormitories Hallway North"
	icon_state = "Sleep"

/area/future/crew_quarters/sleep3
	name = "\improper Dormitories Hallway West"
	icon_state = "Sleep"

/area/future/crew_quarters/sleep/lobby
	name = "\improper Dormitory Lobby"
	icon_state = "Sleep"

/area/future/crew_quarters/sleep/cave
	name = "\improper Dormitory Cave"
	icon_state = "explored"

/area/future/crew_quarters/underdorm
	name = "\improper Underground Dormitories"
	icon_state = "underdorm"

/area/future/crew_quarters/underdorm/boxing
	name = "\improper Boxing Club"
	icon_state = "fitness"

/area/future/crew_quarters/underdorm/maint
	name = "\improper Underground Dormitories Maintenance"
	icon_state = "underdormmaint"

/area/future/crew_quarters/underdorm/theater
	name = "\improper Theater"
	icon_state = "Theatre"

/area/future/crew_quarters/underdorm/theater/clown
	name = "\improper Clown's Bedroom"
	icon_state = "Theatre"

/area/future/crew_quarters/underdorm/theater/mime
	name = "\improper Mime's Bedroom"
	icon_state = "Theatre"

/area/future/crew_quarters/underdorm/theater/actor
	name = "\improper Actors' Break Room"
	icon_state = "Theatre"

/area/future/crew_quarters/underdorm/sauna
	name = "\improper Sauna"
	icon_state = "toilet"


/area/future/crew_quarters/sleep/cabin1
	name = "\improper Private Bedroom One"
	icon_state = "PrivDormOne"
	sound_env = SMALL_SOFTFLOOR

/area/future/crew_quarters/sleep/cabin2
	name = "\improper Private Bedroom Two"
	icon_state = "PrivDormTwo"
	sound_env = SMALL_SOFTFLOOR

/area/future/crew_quarters/sleep/cabin3
	name = "\improper Private Bedroom Three"
	icon_state = "PrivDormThree"
	sound_env = SMALL_SOFTFLOOR

/area/future/crew_quarters/sleep/cabin4
	name = "\improper Private Bedroom Four"
	icon_state = "PrivDormFour"
	sound_env = SMALL_SOFTFLOOR

/area/future/crew_quarters/sleep/cabin5
	name = "\improper Private Bedroom Five"
	icon_state = "PrivDormFive"
	sound_env = SMALL_SOFTFLOOR

/area/future/crew_quarters/sleep/cabin6
	name = "\improper Private Bedroom Six"
	icon_state = "PrivDormSix"
	sound_env = SMALL_SOFTFLOOR

/area/future/crew_quarters/sleep/underg_cabin1
	name = "\improper Underground Bedroom One"
	icon_state = "UndergroundDormOne"
	sound_env = SMALL_SOFTFLOOR

/area/future/crew_quarters/sleep/underg_cabin2
	name = "\improper Underground Bedroom Two"
	icon_state = "UndergroundDormTwo"
	sound_env = SMALL_SOFTFLOOR

/area/future/crew_quarters/sleep/underg_cabin3
	name = "\improper Underground Bedroom Three"
	icon_state = "UndergroundDormThree"
	sound_env = SMALL_SOFTFLOOR

/area/future/crew_quarters/sleep/engi_wash
	name = "\improper Engineering Washroom"
	icon_state = "toilet"
	sound_env = SMALL_ENCLOSED

/area/future/crew_quarters/sleep/bedrooms
	name = "\improper Dormitory Bedroom One"
	icon_state = "Sleep"
	sound_env = SMALL_SOFTFLOOR

/area/future/crew_quarters/sleep/dorms
	name = "\improper Dormitory Shared Bedroom"
	icon_state = "Sleep"
	sound_env = SMALL_SOFTFLOOR

/area/future/crew_quarters/sleep/quartes1
	name = "\improper Dormitory Quartes One"
	icon_state = "Sleep"
	sound_env = SMALL_SOFTFLOOR

/area/future/crew_quarters/sleep/quartes2
	name = "\improper Dormitory Quartes Two"
	icon_state = "Sleep"
	sound_env = SMALL_SOFTFLOOR

/area/future/crew_quarters/sleep/quartes3
	name = "\improper Dormitory Quartes Three"
	icon_state = "Sleep"
	sound_env = SMALL_SOFTFLOOR

/area/future/crew_quarters/sleep/quartes4
	name = "\improper Dormitory Quartes Four"
	icon_state = "Sleep"
	sound_env = SMALL_SOFTFLOOR

/area/future/crew_quarters/locker/locker_toilet
	name = "\improper Locker Toilets"
	icon_state = "toilet"
	sound_env = SMALL_ENCLOSED

/area/future/crew_quarters/fitness
	name = "\improper Fitness Room"
	icon_state = "fitness"

/area/future/crew_quarters/fitness/arcade
	name = "\improper Arcade"
	icon_state = "arcade"

/area/future/crew_quarters/kitchen
	name = "\improper Kitchen"
	icon_state = "kitchen"

/area/future/crew_quarters/bar
	name = "\improper Bar"
	icon_state = "bar"
	sound_env = LARGE_SOFTFLOOR

/area/future/crew_quarters/barbackroom
	name = "\improper Bar Backroom"
	icon_state = "barBR"

/area/future/crew_quarters/ubarbackroom // new room for bartender
	name = "\improper Underground Bar Backroom"
	icon_state = "ubarBR"

/area/future/crew_quarters/mess
	name = "\improper Mess Hall"
	icon_state = "cafeteria"
	sound_env = LARGE_SOFTFLOOR

/area/future/library
 	name = "\improper Library"
 	icon_state = "library"
 	sound_env = LARGE_SOFTFLOOR

/area/future/janitor
	name = "\improper Custodial Closet"
	icon_state = "janitor"

/area/future/chapel/main
	name = "\improper Chapel"
	icon_state = "chapel"
	ambience_off = list(SFX_AMBIENT_OFF_GLOBAL)
	ambience_powered = list(SFX_AMBIENT_CHAPEL)
	sound_env = LARGE_ENCLOSED

/area/future/chapel/office
	name = "\improper Chapel Office"
	icon_state = "chapeloffice"

/area/future/chapel/crematorium
	name = "\improper Crematorium"
	icon_state = "chapelcrematorium"

/area/future/iaoffice
	name = "\improper Internal Affairs"
	icon_state = "law"

/area/future/lawoffice
	name = "\improper Law Office"
	icon_state = "law"


// Engineering

/area/future/engineering/
	name = "\improper Engineering"
	icon_state = "engineering"
	ambience_powered = list(SFX_AMBIENT_ENGINEERING)

/area/future/engineering/grav_generator
	name = "\improper Gravitational Generator Room"
	icon_state = "engine"
	sound_env = LARGE_ENCLOSED

/area/future/engineering/lower
	name = "\improper Engineering Lower Deck"
	icon_state = "lower_engi"

/area/future/engineering/lower/rust
	name = "\improper R-UST Engine"
	icon_state = "rust"

/area/future/engineering/lower/rust/core
	name = "\improper R-UST Core"
	icon_state = "rust"

/area/future/engineering/lower/rust/control
	name = "\improper R-UST Control Room"
	icon_state = "rust"

/area/future/engineering/engine_airlock
	name = "\improper Engine Room Airlock"
	icon_state = "engine"

/area/future/engineering/singularity_engine
	name = "\improper Singularity Engine"
	icon_state = "engine"

/area/future/engineering/singularity_control
	name = "\improper Singularity Engine Control Room"
	icon_state = "engine_monitoring"

/area/future/engineering/singularity_storage
	name = "\improper Singularity Engine Storage"
	icon_state = "engineering_storage"

/area/future/engineering/engine_waste
	name = "\improper Engine Waste Handling"
	icon_state = "engine_waste"

/area/future/engineering/break_room
	name = "\improper Engineering Break Room"
	icon_state = "engineering_break"
	sound_env = MEDIUM_SOFTFLOOR

/area/future/engineering/workshop
	name = "\improper Engineering Workshop"
	icon_state = "engineering_workshop"

/area/future/engineering/sublevel_access
	name = "\improper Engineering Sublevel Access"

/area/future/engineering/atmos
	name = "\improper Atmospherics"
	icon_state = "atmos"
	ambience_powered = list(SFX_AMBIENT_ENGINEERING, SFX_AMBIENT_ATMOSPHERICS)

/area/future/engineering/atmos/storage
	name = "\improper Atmospherics Storage"
	icon_state = "atmos_storage"

/area/future/engineering/toilet
	name = "\improper Atmospherics"
	icon_state = "engineering_break"

/area/future/engineering/eva_airlock
	name = "\improper Engineering Airlock"
	icon_state = "engineering_break"

/area/future/engineering/atmos_monitoring
	name = "\improper Atmospherics Monitoring Room"
	icon_state = "engine_monitoring"

/area/future/engineering/storage
	name = "\improper Engineering Storage"
	icon_state = "engineering_storage"

/area/future/engineering/engine_eva
	name = "\improper Engine EVA"
	icon_state = "engine_eva"

/area/future/engineering/engine_monitoring
	name = "\improper Engine Monitoring Room"
	icon_state = "engine_monitoring"

/area/future/engineering/locker_room
	name = "\improper Engineering Locker Room"
	icon_state = "engineering_locker"

/area/future/engineering/engineering_monitoring
	name = "\improper Engineering Monitoring Room"
	icon_state = "engine_monitoring"

/area/future/engineering/drone_fabrication
	name = "\improper Engineering Drone Fabrication"
	icon_state = "drone_fab"
	sound_env = SMALL_ENCLOSED

/area/future/engineering/engine_smes
	name = "\improper Engineering SMES"
	icon_state = "engine_smes"
	sound_env = SMALL_ENCLOSED

/area/future/engineering/engine_room
	name = "\improper Engine Room"
	icon_state = "engine"
	sound_env = LARGE_ENCLOSED

// Medbay

/area/future/medical/genetics
	name = "\improper Genetics Lab"
	icon_state = "genetics"

/area/future/medical/genetics_cloning
	name = "\improper Cloning Lab"
	icon_state = "cloning"

/area/future/medical/biostorage/underground
	name = "\improper Undergound Medbay Storage"
	icon_state = "medbay4"

/area/future/medical/sleeper
	name = "\improper Emergency Treatment Room"
	icon_state = "exam_room"

/area/future/medical/sleeper/underground
	name = "\improper Underground Emergency Treatment Room"
	icon_state = "exam_room"

/area/future/medical/chemistry
	name = "\improper Chemistry"
	icon_state = "chem"

/area/future/medical/exam_room
	name = "\improper Exam Room"
	icon_state = "exam_room"

/area/future/medical/morgue
	name = "\improper Morgue"
	icon_state = "morgue"
	ambience_powered = list(SFX_AMBIENT_MORGUE, SFX_AMBIENT_SCIENCE)

/area/future/medical/surgery
	name = "\improper Operating Theatre"
	icon_state = "surgery"

// Solars

/area/future/solar
	ambient_music_tags = list(MUSIC_TAG_SPACE)

/area/future/solar/starboard
	name = "\improper Starboard Auxiliary Solar Array"
	icon_state = "panelsS"

/area/future/solar/auxport
	name = "\improper Fore Port Solar Array"
	icon_state = "panelsA"

/area/future/solar/fore
	name = "\improper Fore Solar Array"
	icon_state = "yellow"

/area/future/solar/port
	name = "\improper Port Auxiliary Solar Array"
	icon_state = "panelsP"

/area/future/maintenance/foresolar
	name = "\improper Solar Maintenance - Fore"
	icon_state = "SolarcontrolA"
	sound_env = SMALL_ENCLOSED

/area/future/maintenance/portsolar
	name = "\improper Solar Maintenance - Aft Port"
	icon_state = "SolarcontrolP"
	sound_env = SMALL_ENCLOSED

/area/future/maintenance/starboardsolar
	name = "\improper Solar Maintenance - Aft Starboard"
	icon_state = "SolarcontrolS"
	sound_env = SMALL_ENCLOSED

// Teleporter

/area/future/teleporter
	name = "\improper Teleporter"
	icon_state = "teleporter"
	ambient_music_tags = list(MUSIC_TAG_SPACE)

/area/future/gateway
	name = "\improper Gateway"
	icon_state = "teleporter"
	ambient_music_tags = list(MUSIC_TAG_SPACE)

// MedBay

/area/future/medical/medbay
	name = "\improper Medbay Hallway - Port"
	icon_state = "medbay"

// Medbay is a large area, these additional areas help level out APC load.
/area/future/medical/medbay2
	name = "\improper Medbay Hallway - Starboard"
	icon_state = "medbay2"

/area/future/medical/medbay3
	name = "\improper Medbay Hallway - Fore"
	icon_state = "medbay3"

/area/future/medical/medbay3/underground
	name = "\improper Underground Medbay Hallway - Fore"
	icon_state = "medbay3"

/area/future/medical/medbay4
	name = "\improper Medbay Hallway - Aft"
	icon_state = "medbay4"

/area/future/medical/medbay4/underground
	name = "\improper Underground Medbay Hallway - Aft"
	icon_state = "medbay4"

/area/future/medical/reception
	name = "\improper Medbay Reception"
	icon_state = "medbay"

/area/future/medical/psych
	name = "\improper Psych Room"
	icon_state = "medbay3"

/area/future/crew_quarters/medbreak
	name = "\improper Break Room"
	icon_state = "medbay3"

/area/future/medical/ward
	name = "\improper Recovery Ward"
	icon_state = "patients"

/area/future/medical/patient_a
	name = "\improper Isolation A"
	icon_state = "patients"

/area/future/medical/patient_b
	name = "\improper Isolation B"
	icon_state = "patients"

/area/future/medical/patient_c
	name = "\improper Isolation C"
	icon_state = "patients"

/area/future/medical/patient_d
	name = "\improper Isolation D"
	icon_state = "patients"

/area/future/medical/patient_wing
	name = "\improper Underground Patient Ward"
	icon_state = "patients"

/area/future/medical/patient_wing/garden
	name = "\improper Medbay Garden"
	icon_state = "patients"

/area/future/medical/patient_wing/washroom
	name = "\improper Patient Wing Washroom"

/area/future/medical/surgery2
	name = "\improper Operating Theatre 2"
	icon_state = "surgery"

/area/future/medical/surgery_storage
	name = "\improper Surgery Storage"
	icon_state = "surgery"

/area/future/medical/surgeryobs
	name = "\improper Operation Observation Room"
	icon_state = "surgery"

/area/future/medical/surgeryprep
	name = "\improper Pre-Op Prep Room"
	icon_state = "surgery"

/area/future/medical/cryo
	name = "\improper Cryogenics"
	icon_state = "cryo"

/area/future/medical/med_toilet
	name = "\improper Medbay Toilets"
	icon_state = "medbay"

/area/future/medical/med_mech
	name = "\improper Medbay Mech Room"
	icon_state = "medbay3"

/area/future/medical/storage1
	name = "\improper Primary Storage"
	icon_state = "medbay4"

/area/future/medical/storage2
	name = "\improper Medbay Storage"
	icon_state = "medbay3"

/area/future/medical/resleever
	name = "\improper Neural Lace Resleever"
	icon_state = "cloning"

// Security

/area/future/security/main
	name = "\improper Security Office"
	icon_state = "security"

/area/future/security/briefingroom
	name = "\improper Security - Briefing Room"
	icon_state = "briefroom"

/area/future/security/storage
	name = "\improper Security Storage"
	icon_state = "brigstorage"

/area/future/security/execution
	name = "\improper Security - Execution Room"
	icon_state = "execution"

/area/future/security/evidence
	name = "\improper Security - Evidence Storage"
	icon_state = "evidence"

/area/future/security/brigmorgue
	name = "\improper Security - Morgue"
	icon_state = "brigmorgue"

/area/future/security/brigswstorage
	name = "\improper Security - S-W Storage"
	icon_state = "brigswstorage"

/area/future/security/meeting
	name = "\improper Security Meeting Room"
	icon_state = "security"

/area/future/security/lobby
	name = "\improper Security Lobby"
	icon_state = "security"

/area/future/security/brig/processing
	name = "\improper Security - Processing Room 1"
	icon_state = "proc1"

/area/future/security/brig/processing2
	name = "\improper Security - Processing Room 2"
	icon_state = "proc2"

/area/future/security/brig/interrogation
	name = "\improper Security - Interrogation"
	icon_state = "interrogation"

/area/future/security/brig/solitaryA
	name = "\improper Security - Solitary 1"
	icon_state = "sec_prison"

/area/future/security/brig/solitaryB
	name = "\improper Security - Solitary 2"
	icon_state = "sec_prison"

/area/future/security/brig/prison_break()
	for(var/obj/structure/closet/secure_closet/brig/temp_closet in src)
		temp_closet.locked = 0
		temp_closet.icon_state = temp_closet.icon_closed
	for(var/obj/machinery/door_timer/temp_timer in src)
		temp_timer.releasetime = 1
	..()

/area/future/security/prison/restroom
	name = "\improper Security - Prison Wing Restroom"
	icon_state = "sec_prison"

/area/future/security/prison/dorm
	name = "\improper Security - Prison Wing Dormitory"
	icon_state = "sec_prison"

/area/future/security/prison/monitoring
	name = "\improper Security - Prison Wing Monitoring"

/area/future/security/prison/prison_break()
	for(var/obj/structure/closet/secure_closet/brig/temp_closet in src)
		temp_closet.locked = 0
		temp_closet.icon_state = temp_closet.icon_closed
	for(var/obj/machinery/door_timer/temp_timer in src)
		temp_timer.releasetime = 1
	..()

/area/future/security/warden
	name = "\improper Security - Warden's Office"
	icon_state = "Warden"

/area/future/security/tactical
	name = "\improper Security - Tactical Equipment"
	icon_state = "Tactical"

/area/future/security/vacantoffice
	name = "\improper Vacant Office"
	icon_state = "security"

/area/future/security/nuke_storage
	name = "\improper Vault"
	icon_state = "nuke_storage"

/area/future/security/checkpoint2
	name = "\improper Command Security - Checkpoint"
	icon_state = "checkpoint1"

/area/future/quartermaster
	name = "\improper Quartermasters"
	icon_state = "quart"

/area/future/quartermaster/breakroom
	name = "\improper Cargo Break Room"
	icon_state = "cargobreak"

/area/future/quartermaster/storage
	name = "\improper Warehouse"
	icon_state = "quartstorage"
	sound_env = LARGE_ENCLOSED

/area/future/quartermaster/storage/under
	name = "\improper Underground Cargo Warehouse"
	icon_state = "cargounder"

/area/future/quartermaster/storage/under/secure
	name = "\improper Underground Cargo Storage"
	icon_state = "cargounderstorage"

/area/future/quartermaster/qm
	name = "\improper Cargo - Quartermaster's Office"
	icon_state = "quart"

/area/future/quartermaster/miningdock
	name = "\improper Cargo Mining Dock"
	icon_state = "mining"

/area/future/quartermaster/office
	name = "\improper Supply Office"
	icon_state = "quartoffice"

/area/future/hydroponics
	name = "\improper Hydroponics"
	icon_state = "hydro"

/area/future/hydroponics/garden
	name = "\improper Garden"
	icon_state = "garden"

/area/future/hydroponics/lower
	name = "\improper Lower Hydroponics"
	icon_state = "garden"

/area/future/hydroponics/biodome
	name = "\improper Central Biodome"
	icon_state = "garden"

// Research
/area/future/rnd/docking
	name = "\improper Research Dock"
	icon_state = "research_dock"

/area/future/assembly/robotics
	name = "\improper Robotics Lab"
	icon_state = "robotics"

/area/future/assembly/chargebay
	name = "\improper Mech Bay"
	icon_state = "mechbay"

/area/future/rnd/lab
	name = "\improper Research Lab"
	icon_state = "toxlab"

/area/future/rnd/misc_lab
	name = "\improper Miscellaneous Research"
	icon_state = "toxmisc"

/area/future/rnd/mixing
	name = "\improper Toxins Mixing Room"
	icon_state = "toxmix"

/area/future/rnd/storage
	name = "\improper Toxins Storage"
	icon_state = "toxstorage"

/area/future/rnd/test_area
	name = "\improper Toxins Test Area"
	icon_state = "toxtest"

/area/future/server
	name = "\improper Research Server Room"
	icon_state = "server"
	ambient_music_tags = list(MUSIC_TAG_SPACE)

/area/future/rnd/research_under
	name = "\improper Underground Research Wing"
	icon_state = "uresearch"

/area/future/rnd/research_under/breakroom
	name = "\improper Underground Research Wing - Break Room"
	icon_state = "uresearchbreak"

/area/future/rnd/restroom
	name = "\improper Research Restroom"
	icon_state = "research"

/area/future/rnd/research
	name = "\improper Research and Development"
	icon_state = "research"

// Storage

/area/future/storage/art
	name = "Art Supply Storage"
	icon_state = "storage"

/area/future/storage/emergency
	name = "Starboard Emergency Storage"
	icon_state = "emergencystorage"

/area/future/storage/emergency2
	name = "Port Emergency Storage"
	icon_state = "emergencystorage"

/area/future/storage/primary
	name = "Primary Tool Storage"
	icon_state = "primarystorage"

/area/future/storage/tools
	name = "Auxiliary Tool Storage"
	icon_state = "auxstorage"

/area/future/storage/tech
	name = "Technical Storage"
	icon_state = "storage"

// HALF-BUILT STATION (REPLACES DERELICT IN BAYCODE, ABOVE IS LEFT FOR DOWNSTREAM)

/area/future/shuttle/constructionsite/site
	name = "\improper Construction Site Shuttle"
	base_turf = /turf/simulated/floor/asteroid

// AI

/area/future/turret_protected
	ambience_powered = list(SFX_AMBIENT_AI, SFX_AMBIENT_SCIENCE)

/area/future/turret_protected/ai
	name = "\improper AI Chamber"
	icon_state = "ai_chamber"
	ambience_powered = list(SFX_AMBIENT_AI)

/area/future/turret_protected/ai_server_room
	name = "Messaging Server Room"
	icon_state = "ai_server"
	sound_env = SMALL_ENCLOSED

/area/future/turret_protected/ai_cyborg_station
	name = "\improper Cyborg Station"
	icon_state = "ai_cyborg"
	sound_env = SMALL_ENCLOSED
	ambience_powered = list(SFX_AMBIENT_AI)

/area/future/turret_protected/ai_upload
	name = "\improper AI Upload Chamber"
	icon_state = "ai_upload"
	ambience_powered = list(SFX_AMBIENT_AI)

/area/future/turret_protected/ai_upload_foyer
	name = "\improper  AI Upload Access"
	icon_state = "ai_foyer"
	ambience_powered = list(SFX_AMBIENT_AI)
	sound_env = SMALL_ENCLOSED

/area/future/turret_protected/tcomsat/port
	name = "\improper Telecoms Satellite - Port"

/area/future/turret_protected/tcomsat/starboard
	name = "\improper Telecoms Satellite - Starboard"

/area/future/ai_monitored/storage/eva
	name = "\improper EVA Storage"
	icon_state = "eva"

// Misc

/area/future/alien
	name = "\improper Alien base"
	icon_state = "yellow"
	requires_power = 0
	ambient_music_tags = list(MUSIC_TAG_MYSTIC, MUSIC_TAG_SPACE)

// Telecommunications Satellite

/area/future/tcommsat
	ambient_music_tags = list(MUSIC_TAG_SPACE)
	ambience_powered = list(SFX_AMBIENT_AI, SFX_AMBIENT_COMMS)

/area/future/tcommsat/entrance
	name = "\improper Telecoms Teleporter"
	icon_state = "tcomsatentrance"

/area/future/turret_protected/tcomsat
	name = "\improper Telecoms Satellite"
	icon_state = "tcomsatlob"

/area/future/turret_protected/tcomfoyer
	name = "\improper Telecoms Foyer"
	icon_state = "tcomsatentrance"

/area/future/tcommsat/powercontrol
	name = "\improper Telecommunications Power Control"
	icon_state = "tcomsatwest"

/area/future/tcommsat/chamber
	name = "\improper Telecoms Central Compartment"
	icon_state = "tcomsatcham"

/area/future/tcommsat/computer
	name = "\improper Telecoms Control Room"
	icon_state = "tcomsatcomp"

/*******
* Moon *
*******/

// Mining main outpost

/area/future/outpost
	ambient_music_tags = list(MUSIC_TAG_MYSTIC, MUSIC_TAG_SPACE)

/area/future/outpost/mining_main
	icon_state = "outpost_mine_main"

/area/future/outpost/mining_main/east_hall
	name = "Mining Outpost East Hallway"

/area/future/outpost/mining_main/eva
	name = "Mining Outpost EVA storage"

/area/future/outpost/mining_main/dorms
	name = "Mining Outpost Dormitory"

/area/future/outpost/mining_main/medbay
	name = "Mining Outpost Medical"

/area/future/outpost/mining_main/refinery
	name = "Mining Outpost Refinery"

/area/future/outpost/mining_main/west_hall
	name = "Mining Outpost West Hallway"

/area/future/outpost/mining_main/mechbay
	name = "Mining Outpost Mech Bay"

// Mining outpost
/area/future/outpost/mining_main/maintenance
	name = "Mining Outpost Maintenance"

// Main Outpost
/area/future/outpost/main_outpost
	icon_state = "green"
	ambience_off = list(SFX_AMBIENT_OFF_GLOBAL, SFX_AMBIENT_OFF_MAINTENANCE)
	ambience_powered = list(SFX_AMBIENT_POWERED_GLOBAL, SFX_AMBIENT_POWERED_MAINTENANCE, SFX_AMBIENT_OUTPOST)

/area/future/outpost/main_outpost/shallway
	name = "Outpost Southern Hallway"

/area/future/outpost/main_outpost/challway
	name = "Outpost Central Hallway"

/area/future/outpost/main_outpost/nhallway
	name = "Outpost Northern Hallway"

/area/future/outpost/main_outpost/dock
	name = "Outpost Dock"
	icon_state = "bluenew"
	area_flags = AREA_FLAG_UNIQUE_AREA

/area/future/outpost/main_outpost/dock/security
	name = "Outpost Security Dock"
	icon_state = "bluenew"

/area/future/outpost/security/shallway
	name = "Outpost Security Hallway"
	icon_state = "green"

/area/future/outpost/security/mining_main
	name = "Mining Outpost Prisoner Refinery"
	icon_state = "outpost_mine_main"

/area/future/outpost/security/dorms
	name = "Outpost Prison Dorm"
	icon_state = "blue2"

/area/future/outpost/security/prison
	name = "Outpost Prison"
	icon_state = "sec_prison"

/area/future/outpost/security/post
	name = "Outpost Security Post"
	icon_state = "brig"

/area/future/outpost/security/eva
	name = "Outpost Security EVA"
	icon_state = "brig"

/area/future/mine/explored/prison
	name = "Mine Prison"
	icon_state = "explored"

/area/future/outpost/main_outpost/infirmary
	name = "Outpost Infirmary"
	ambience_powered = list(SFX_AMBIENT_POWERED_GLOBAL, SFX_AMBIENT_SCIENCE, SFX_AMBIENT_OUTPOST)

/area/future/outpost/main_outpost/canteen
	name = "Outpost Canteen"
	icon_state = "kitchen"

/area/future/outpost/main_outpost/bar
	name = "Outpost Bar"
	icon_state = "bar"

/area/future/outpost/main_outpost/dorms
	name = "Outpost Living Quarters"
	icon_state = "blue2"

/area/future/outpost/main_outpost/dorms/substation
	name = "Outpost Living Quarters Substation"

/area/future/outpost/main_outpost/dorms/proom1
	name = "Outpost Private Room One"

/area/future/outpost/main_outpost/dorms/proom2
	name = "Outpost Private Room Two"

/area/future/outpost/main_outpost/dorms/proom3
	name = "Outpost Private Room Three"

/area/future/outpost/main_outpost/dorms/proom4
	name = "Outpost Private Room Four"

// Small outposts
/area/future/outpost/mining_north
	name = "North Mining Outpost"
	icon_state = "outpost_mine_north"
	ambience_powered = list(SFX_AMBIENT_POWERED_GLOBAL, SFX_AMBIENT_POWERED_MAINTENANCE, SFX_AMBIENT_OUTPOST)

/area/future/outpost/mining_west
	name = "West Mining Outpost"
	icon_state = "outpost_mine_west"
	ambience_powered = list(SFX_AMBIENT_POWERED_GLOBAL, SFX_AMBIENT_POWERED_MAINTENANCE, SFX_AMBIENT_OUTPOST)

/area/future/outpost/abandoned
	name = "Abandoned Outpost"
	icon_state = "dark"

/area/future/outpost/abandonedpost
	name = "Abandoned Post"
	icon_state = "dark"

/area/future/outpost/prydwen
	name = "NSC Prydwen"
	icon_state = "green"

// Engineering outpost

/area/future/outpost/engineering
	icon_state = "outpost_engine"
	ambience_powered = list(SFX_AMBIENT_POWERED_GLOBAL, SFX_AMBIENT_POWERED_MAINTENANCE, SFX_AMBIENT_ENGINEERING)

/area/future/outpost/engineering/atmospherics
	name = "Engineering Outpost Atmospherics"

/area/future/outpost/engineering/hallway
	name = "Engineering Outpost Hallway"

/area/future/outpost/engineering/power
	name = "Engineering Outpost Power Distribution"

/area/future/outpost/engineering/telecomms
	name = "Engineering Outpost Telecommunications"

/area/future/outpost/engineering/storage
	name = "Engineering Outpost Storage"

/area/future/outpost/engineering/meeting
	name = "Engineering Outpost Meeting Room"

// Research Outpost
/area/future/outpost/research
	icon_state = "outpost_research"

/area/future/outpost/research/hor
	name = "Research Outpost - RD's Office"
	icon_state = "Sleep"

/area/future/outpost/research/hallway
	name = "Research Outpost Hallway"

/area/future/outpost/research/dock
	name = "Research Outpost Shuttle Dock"

/area/future/outpost/research/eva
	name = "Research Outpost EVA"

/area/future/outpost/research/analysis
	name = "Research Outpost Sample Analysis"

/area/future/outpost/research/chemistry
	name = "Research Outpost Chemistry"

/area/future/outpost/research/medical
	name = "Research Outpost Medical"

/area/future/outpost/research/power
	name = "Research Outpost Maintenance"

/area/future/outpost/research/isolation_a
	name = "Research Outpost Isolation A"

/area/future/outpost/research/isolation_b
	name = "Research Outpost Isolation B"

/area/future/outpost/research/isolation_c
	name = "Research Outpost Isolation C"

/area/future/outpost/research/isolation_monitoring
	name = "Research Outpost Isolation Monitoring"

/area/future/outpost/research/lab
	name = "Research Outpost Laboratory"

/area/future/outpost/research/emergency_storage
	name = "Research Outpost Emergency Storage"

/area/future/outpost/research/anomaly_storage
	name = "Research Outpost Anomalous Storage"

/area/future/outpost/research/anomaly_analysis
	name = "Research Outpost Anomaly Analysis"

/area/future/outpost/research/kitchen
	name = "Research Outpost Kitchen"

/area/future/outpost/research/disposal
	name = "Research Outpost Waste Disposal"

/area/future/outpost/research/atmospherics
	name = "Research Outpost Atmospherics"

/area/future/outpost/research/breakroom
	name = "Research Outpost Break Room"

/area/future/outpost/research/engine
	name = "Research Outpost Engine"
	icon_state = "engine"
	sound_env = LARGE_ENCLOSED

/area/future/outpost/research/brainstorm
	name = "Research Outpost Brainstorm Room"

/area/future/construction
	name = "\improper Engineering Construction Area"
	icon_state = "yellow"

// CentComm
/area/future/centcom/control
	name = "\improper Centcom Control"

/area/future/tdome
	name = "\improper Thunderdome"
	icon_state = "thunder"
	requires_power = 0
	dynamic_lighting = 0
	sound_env = ARENA

/area/future/centcom/museum
	name = "\improper Museum"
	icon_state = "museum"

// Thunderdr
/area/future/tdome/tdome1
	name = "\improper Thunderdome (Team 1)"
	icon_state = "green"

/area/future/tdome/tdome2
	name = "\improper Thunderdome (Team 2)"
	icon_state = "yellow"

/area/future/tdome/tdomeadmin
	name = "\improper Thunderdome (Admin.)"
	icon_state = "purple"

/area/future/tdome/tdomeobserve
	name = "\improper Thunderdome (Observer.)"
	icon_state = "purple"

/area/future/holodeck
	name = "\improper Holodeck"
	icon_state = "Holodeck"
	requires_power = FALSE
	dynamic_lighting = FALSE
	sound_env = LARGE_ENCLOSED

/area/future/prison/solitary
	name = "Solitary Confinement"
	icon_state = "brig"

/area/future/security/range
	name = "\improper Security - Firing Range"
	icon_state = "firingrange"

/area/future/mine
	icon_state = "mining"
	sound_env = 5 // stoneroom
	ambience_off = list(SFX_AMBIENT_MINE)
	ambience_powered = list(SFX_AMBIENT_MINE)
	ambient_music_tags = list(MUSIC_TAG_MYSTIC, MUSIC_TAG_SPACE)

/area/future/mine/explored
	name = "Mine"
	icon_state = "explored"

/area/future/mine/unexplored
	name = "Mine"
	icon_state = "unexplored"

/area/future/mine/unexplored/medium
	name = "Medium mine"
	icon_state = "unexplored_medium"

/area/future/mine/unexplored/deep
	name = "Deep mine"
	icon_state = "unexplored_deep"

/area/future/constructionsite
	name = "\improper Construction Site"
	icon_state = "yellow"
	has_gravity = FALSE

/area/future/constructionsite/maintenance
	name = "\improper Construction Site Maintenance"
	icon_state = "yellow"

/area/future/constructionsite/bridge
	name = "\improper Construction Site Bridge"
	icon_state = "bridge"

/area/future/constructionsite/hallway/fore
	name = "\improper Construction Site Fore Hallway"
	icon_state = "hallS"

/area/future/constructionsite/storage
	name = "\improper Construction Site Storage Area"

/area/future/constructionsite/medical
	name = "\improper Construction Site Medbay"
	icon_state = "medbay"

/area/future/constructionsite/engineering
	name = "\improper Construction Site Engine Bay"
	icon_state = "engine"

/area/future/solar/constructionsite
	name = "\improper Construction Site Solars"
	icon_state = "aft"

/area/future/constructionsite/teleporter
	name = "Construction Site Teleporter"
	icon_state = "yellow"

/area/future/constructionsite/ai
	name = "\improper Construction Computer Core"
	icon_state = "ai"

/area/future/constructionsite/hallway/aft
	name = "\improper Construction Site Aft Hallway"
	icon_state = "hallP"

/area/future/maintenance/auxsolarstarboard
	name = "Solar Maintenance - Fore Starboard"
	icon_state = "SolarcontrolS"

/area/future/maintenance/incinerator
	name = "\improper Incinerator"
	icon_state = "disposal"

/area/future/maintenance/auxsolarport
	name = "Solar Maintenance - Fore Port"
	icon_state = "SolarcontrolP"

/area/future/derelict/ship
	name = "\improper Abandoned Ship"
	icon_state = "yellow"

/area/future/derelict/snowasteroid
	name = "\improper Hidden Outpost"
	icon_state = "yellow"
	has_gravity = TRUE

/area/future/derelict/snowasteroid/bunker
	name = "\improper Hidden Outpost Bunker"
	icon_state = "red"
	has_gravity = TRUE

/area/future/derelict/snowasteroid/shuttle
	name = "\improper Hidden Outpost Shuttle"
	icon_state = "blue"
	has_gravity = TRUE

/area/future/derelict/djstation
	name = "\improper DJ Station"
	icon_state = "yellow"
	has_gravity = TRUE

/area/future/AIsattele
	name = "\improper AI Satellite Teleporter Room"
	icon_state = "teleporter"
	ambience_powered = list(SFX_AMBIENT_AI)
	has_gravity = FALSE
	ambient_music_tags = list(MUSIC_TAG_MYSTIC, MUSIC_TAG_SPACE)

/area/future/constructionsite/atmospherics
	name = "\improper Construction Site Atmospherics"
	icon_state = "green"

/area/future/supply
	name = "Supply Shuttle"
	icon_state = "shuttle3"

/area/future/supply/dock
	name = "Supply Shuttle"
	icon_state = "shuttle3"
	requires_power = 0

/area/future/supply/station
	name = "Supply Shuttle"
	icon_state = "shuttle3"
	requires_power = 0

/area/future/security/armory
	name = "\improper Security - Armory"
	icon_state = "armory"

/area/future/security/detectives_office
	name = "\improper Security - Forensic Office"
	icon_state = "detective"
	sound_env = MEDIUM_SOFTFLOOR

/area/future/shuttle/escape_pod1/centcom
	icon_state = "shuttle"

/area/future/shuttle/escape_pod2/centcom
	icon_state = "shuttle"

/area/future/shuttle/escape_pod3/centcom
	icon_state = "shuttle"

/area/future/shuttle/escape_pod5/centcom
	icon_state = "shuttle"

/area/future/centcom/evac
	name = "\improper Centcom Emergency Shuttle"

/area/future/centcom/ferry
	name = "\improper Centcom Transport Shuttle"

/area/future/centcom/living
	name = "\improper Centcom Living Quarters"

/area/future/centcom/suppy
	name = "\improper Centcom Supply Shuttle"

/area/future/centcom/test
	name = "\improper Centcom Testing Facility"

/area/future/centcom/creed
	name = "Creed's Office"

/area/future/acting/stage
	name = "\improper Stage"
	dynamic_lighting = 0
	requires_power = 0
	icon_state = "yellow"

/area/future/merchant_station
	name = "\improper Merchant Station"
	icon_state = "LP"
	requires_power = 0

/area/future/thunder_rock
	name = "\improper Thunder Rock"
	icon_state = "LP"
	luminosity = 1
	dynamic_lighting = 0
	requires_power = 0

/area/future/acting/backstage
	name = "\improper Backstage"
	luminosity = 1
	dynamic_lighting = 0
	requires_power = 0

/area/future/solar/auxstarboard
	name = "\improper Fore Starboard Solar Array"
	icon_state = "panelsA"

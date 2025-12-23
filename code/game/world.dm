#define REBOOT_HARD 1
#define REBOOT_REALLY_HARD 2

var/server_name = "StoneBay"

/var/game_id = null
/hook/global_init/proc/generate_gameid()
	if(game_id != null)
		return
	game_id = ""

	var/list/c = list("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0")
	var/l = c.len

	var/t = world.timeofday
	for(var/_ = 1 to 4)
		game_id = "[c[(t % l) + 1]][game_id]"
		t = round(t / l)
	game_id = "-[game_id]"
	t = round(world.realtime / (10 * 60 * 60 * 24))
	for(var/_ = 1 to 3)
		game_id = "[c[(t % l) + 1]][game_id]"
		t = round(t / l)
	return 1

/proc/toggle_ooc()
	config.misc.ooc_allowed = !config.misc.ooc_allowed
	if(config.misc.ooc_allowed)
		to_world("<b>The OOC channel has been globally enabled!</b>")
	else
		to_world("<b>The OOC channel has been globally disabled!</b>")

/proc/disable_ooc()
	if(config.misc.ooc_allowed)
		toggle_ooc()

/proc/enable_ooc()
	if(!config.misc.ooc_allowed)
		toggle_ooc()

/proc/toggle_looc()
	config.misc.looc_allowed = !config.misc.looc_allowed
	if(config.misc.looc_allowed)
		to_world("<b>The LOOC channel has been globally enabled!</b>")
	else
		to_world("<b>The LOOC channel has been globally disabled!</b>")

/proc/disable_looc()
	if(config.misc.ooc_allowed)
		toggle_ooc()

/proc/enable_looc()
	if(!config.misc.looc_allowed)
		toggle_looc()

// Find mobs matching a given string
//
// search_string: the string to search for, in params format; for example, "some_key;mob_name"
// restrict_type: A mob type to restrict the search to, or null to not restrict
//
// Partial matches will be found, but exact matches will be preferred by the search
//
// Returns: A possibly-empty list of the strongest matches
/proc/text_find_mobs(search_string, restrict_type = null)
	var/list/search = params2list(search_string)
	var/list/ckeysearch = list()
	for(var/text in search)
		ckeysearch += ckey(text)

	var/list/match = list()

	for(var/mob/M in SSmobs.mob_list)
		if(restrict_type && !istype(M, restrict_type))
			continue
		var/strings = list(M.name, M.ckey)
		if(M.mind)
			strings += M.mind.assigned_role
			strings += M.mind.special_role
		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			if(H.species)
				strings += H.species.name
		for(var/text in strings)
			if(ckey(text) in ckeysearch)
				match[M] += 10 // an exact match is far better than a partial one
			else
				for(var/searchstr in search)
					if(findtext(text, searchstr))
						match[M] += 1

	var/maxstrength = 0
	for(var/mob/M in match)
		maxstrength = max(match[M], maxstrength)
	for(var/mob/M in match)
		if(match[M] < maxstrength)
			match -= M

	return match

#define RECOMMENDED_VERSION 516
/world/New()
	SetupLogs()

	if(byond_version < RECOMMENDED_VERSION)
		to_world_log("Your server's byond version does not meet the recommended requirements for this server. Please update BYOND")

	// Load converter lib that is required for reading TOML configs
	if(world.system_type == UNIX)
		GLOB.converter_dll = "./converter.so"
	else
		GLOB.converter_dll = "converter.dll"

	if(!fexists(GLOB.converter_dll))
		log_error("CRITICAL: [GLOB.converter_dll] not found")
		log_error("Can't read config, shutting down...")
		sleep(50)
		shutdown()

	load_sql_config("config/dbconfig.txt")

	// Load up the base config.toml
	try
		config.load_configuration()
	catch(var/exception/e)
		log_error("CRITICAL: failed to read config: [e.name]")
		log_error("Can't read config, shutting down...")
		sleep(50)
		shutdown()

	// TODO(rufus): move the title/music/watchlist stuff into procs or something else, world creation proc should be clean
	//set window title
	if(config.general.subserver_name)
		var/subserver_name = uppertext(copytext(config.general.subserver_name, 1, 2)) + copytext(config.general.subserver_name, 2)
		name = "[config.general.server_name]: [subserver_name] - [GLOB.using_map.full_name]"
	else
		name = "[config.general.server_name] - [GLOB.using_map.full_name]"

	watchlist = new /datum/watchlist

	var/list/lobby_music_tracks = subtypesof(/lobby_music)
	var/lobby_music_type = /lobby_music
	if(lobby_music_tracks.len)
		lobby_music_type = pick(lobby_music_tracks)
	GLOB.lobby_music = new lobby_music_type()

	callHook("startup")

	. = ..()

	Master.Initialize(10, FALSE)
	webhook_send_world_started(config.general.server_id)

#undef RECOMMENDED_VERSION

var/world_topic_spam_protect_time = world.timeofday

/world/Topic(T, addr, master, keys)
	log_href("\"[T]\", from:[addr]")
	// TODO(rufus): add topic rate limiting, create code/modules/world_topic/rate_limit.dm
	return handle_world_topic(T)

/world/Reboot(reason, force = FALSE)
	for(var/client/C in GLOB.clients)
		C?.tgui_panel?.send_roundrestart()

	if(!force)
		Master.Shutdown()
		game_log("World rebooted at [time_stamp()]")
		blackbox?.save_all_data_to_sql()

	..(reason)

/world/Del()
	callHook("shutdown")
	return ..()

/world/proc/save_mode(the_mode)
	var/F = file("data/mode.txt")
	fdel(F)
	to_file(F, the_mode)

/hook/startup/proc/loadMOTD()
	world.load_motd()
	return TRUE

/world/proc/load_motd()
	join_motd = file2text("config/motd.txt")
	load_regular_announcement()

/world/proc/update_status()
	var/status_html = "<b>RU/EN - StoneBay - Inspired by 2025 OnyxBay</b><br>\
	Focused on a mostly classic, controversy-free experience.<br>\
	Everyone is welcome!<br>"
	status = status_html

// TODO(rufus): there is zero reason for these to be impossible to find a reference to macros, refactor
#define WORLD_LOG_START(X) WRITE_FILE(GLOB.world_##X##_log, "\n\nStarting up round ID [game_id]. [time2text(world.realtime, "DD.MM.YY hh:mm")]\n---------------------")
#define WORLD_SETUP_LOG(X) GLOB.world_##X##_log = file("[log_directory]/[log_prefix][#X].log") ; WORLD_LOG_START(X)
#define WORLD_SETUP_LOG_DETAILED(X) GLOB.world_##X##_log = file("[log_directory_detailed]/[log_prefix_detailed][#X].log") ; WORLD_LOG_START(X)

/world/proc/SetupLogs()
	if (!game_id)
		util_crash_with("Unknown game_id!")

	var/log_directory = "data/logs/[time2text(world.realtime, "YYYY/MM-Month")]"
	var/log_prefix = "[time2text(world.realtime, "DD.MM.YY")]_"

	GLOB.log_directory = log_directory // TODO: remove GLOB.log_directory, check initialize.log

	var/log_directory_detailed = "data/logs/[time2text(world.realtime, "YYYY/MM-Month")]/[time2text(world.realtime, "DD.MM.YY")]_detailed"
	var/log_prefix_detailed = "[time2text(world.realtime, "DD.MM.YY_hh.mm")]_[game_id]_"

	WORLD_SETUP_LOG_DETAILED(runtime)
	WORLD_SETUP_LOG_DETAILED(qdel)
	WORLD_SETUP_LOG_DETAILED(debug)
	WORLD_SETUP_LOG_DETAILED(hrefs)
	WORLD_SETUP_LOG(story)
	WORLD_SETUP_LOG(common)

#undef WORLD_SETUP_LOG_DETAILED
#undef WORLD_SETUP_LOG
#undef WORLD_LOG_START

#define FAILED_DB_CONNECTION_CUTOFF 5
var/failed_db_connections = 0

// TODO(rufus): move database related stuff into its proper folder
/hook/startup/proc/connectDB()
	if(!config.external.sql_enabled)
		log_to_dd("SQL disabled. Your server will not use the main database.")
	else if(!setup_database_connection())
		log_to_dd("Your server failed to establish a connection with the main database.")
	else
		log_to_dd("Main database connection established.")
	return TRUE

/proc/setup_database_connection()
	if(failed_db_connections > FAILED_DB_CONNECTION_CUTOFF)	//If it failed to establish a connection more than 5 times in a row, don't bother attempting to connect anymore.
		return 0

	if(!dbcon)
		dbcon = new()

	dbcon.Connect("dbi:mysql:[sqldb]:[sqladdress]:[sqlport]","[sqllogin]","[sqlpass]")
	if (!dbcon.IsConnected())
		failed_db_connections++
		log_to_dd(dbcon.ErrorMsg())
		return FALSE
	. = dbcon.IsConnected()

	if ( . )
		failed_db_connections = 0	//If this connection succeeded, reset the failed connections counter.
	else
		failed_db_connections++		//If it failed, increase the failed connections counter.
		log_to_dd(dbcon.ErrorMsg())

	return .

//This proc ensures that the connection to the main database (global variable dbcon) is established
/proc/establish_db_connection()
	if(!config.external.sql_enabled)
		return FALSE

	if(failed_db_connections > FAILED_DB_CONNECTION_CUTOFF)
		return FALSE

	if(!dbcon || !dbcon.IsConnected())
		return setup_database_connection()
	else
		return TRUE

#undef FAILED_DB_CONNECTION_CUTOFF

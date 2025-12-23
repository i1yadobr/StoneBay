#define WHITELISTFILE "config/whitelist.txt"

var/list/whitelist = list()

/hook/startup/proc/loadWhitelist()
	if(config.game.use_whitelist)
		if(config.game.use_whitelist_sql)
			load_whitelistSQL()
			load_job_whitelistSQL()
		else
			load_whitelist()
	return TRUE

/proc/load_whitelist()
	whitelist = file2list(WHITELISTFILE)
	if(!whitelist.len)
		whitelist = null

/proc/check_whitelist(ckey)
	if(!whitelist)
		return 0
	return ("[ckey]" in whitelist)

/proc/load_whitelistSQL(ckey)
	if(!establish_db_connection())
		error("Failed to connect to database in load_whitelistSQL().")
		log_misc("Failed to connect to database in load_whitelistSQL().")
		return FALSE
	var/DBQuery/query = sql_query("SELECT * FROM whitelist WHERE ckey='[lowertext(ckey)]'", dbcon)
	while(query.NextRow())
		return TRUE
	return FALSE

/proc/load_job_whitelistSQL(ckey, rank)
	if(!establish_db_connection())
		error("Failed to connect to database in load_job_whitelistSQL.")
		log_misc("Failed to connect to database in load_job_whitelistSQL.")
		return FALSE
	var/DBQuery/query = sql_query("SELECT * FROM job_whitelist WHERE ckey='[lowertext(ckey)]' and job='[rank]'", dbcon)
	while(query.NextRow())
		return TRUE
	return FALSE


/var/list/alien_whitelist = list()

// TODO(rufus): clean up alien whitelist
/hook/startup/proc/loadAlienWhitelist()
	if(config.game.use_ingame_alien_whitelist)
		if(config.game.use_alien_whitelist_sql)
			load_alienwhitelistSQL()
		else
			load_alienwhitelist()
	return TRUE

/proc/load_alienwhitelist()
	var/text = file2text("config/alienwhitelist.txt")
	if(!text)
		log_misc("Failed to load config/alienwhitelist.txt")
		return FALSE
	else
		alien_whitelist = splittext(text, "\n")
		return TRUE

/proc/load_alienwhitelistSQL()
	if(!establish_db_connection())
		error("Failed to connect to database in load_alienwhitelist().")
		log_misc("Failed to connect to database in load_alienwhitelist().")
		return FALSE
	var/DBQuery/query = sql_query("SELECT * FROM whitelist", dbcon)
	while(query.NextRow())
		var/list/row = query.GetRowData()
		if(alien_whitelist[row["ckey"]])
			var/list/A = alien_whitelist[row["ckey"]]
			A.Add(row["race"])
		else
			alien_whitelist[row["ckey"]] = list(row["race"])
	return TRUE

/proc/is_species_whitelisted(mob/M, species_name)
	var/datum/species/S = all_species[species_name]
	return is_alien_whitelisted(M, S)

//todo: admin aliens
/proc/is_alien_whitelisted(mob/M, species)
	if(!M || !species)
		return FALSE
	if(!config.game.use_ingame_alien_whitelist)
		return TRUE

	var/client/C = M.client
	if (C && SpeciesIngameWhitelist_CheckPlayer(C))
		return TRUE

	if(istype(species,/datum/language))
		var/datum/language/L = species
		if(!(L.language_flags & (WHITELISTED|RESTRICTED)))
			return TRUE
		return whitelist_lookup(L.name, M.ckey)

	if(istype(species,/datum/species))
		var/datum/species/S = species
		if(!(S.spawn_flags & (SPECIES_IS_WHITELISTED|SPECIES_IS_RESTRICTED)))
			return TRUE
		return whitelist_lookup(S.name, M.ckey)

	return FALSE

/proc/whitelist_lookup(item, ckey)
	if(config.game.use_alien_whitelist_sql)
		//SQL Whitelist
		if(!(ckey in alien_whitelist))
			return FALSE
		var/list/whitelisted = alien_whitelist[ckey]
		if(lowertext(item) in whitelisted)
			return TRUE
	else
		//Config File Whitelist
		for(var/s in alien_whitelist)
			if(findtext(s,"[ckey] - [item]"))
				return TRUE
			if(findtext(s,"[ckey] - All"))
				return TRUE
	return FALSE

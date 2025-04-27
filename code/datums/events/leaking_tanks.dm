/datum/event/leaking_tanks
	id = "leaking_tanks"
	name = "Leaking fueltanks"
	description = "Some fueltanks was leaking"

	mtth = 1 HOURS
	difficulty = 10

/datum/event/leaking_tanks/get_mtth()
	. = ..()
	. -= (SSevents.triggers.roles_count["Station Engineer"] * (15 MINUTES))
	. = max(1 HOUR, .)

/datum/event/leaking_tanks/check_conditions()
	. = SSevents.triggers.roles_count["Station Engineer"] >= 1

/datum/event/leaking_tanks/on_fire()
	var/list/station_levels = GLOB.using_map.get_levels_with_trait(ZTRAIT_STATION)
	var/list/matching_tanks = list()


	announce()

	for (var/obj/structure/reagent_dispensers/fueltank/candidate as anything in GLOB.fueltanks)
		if (!(candidate.z in station_levels))
			continue

		matching_tanks += candidate

	var/leaking_tanks_quantity = rand(2, 5)

	for	(var/i = 0, i < leaking_tanks_quantity, i++)
		if (!matching_tanks?.len)
			break

		var/obj/structure/reagent_dispensers/fueltank/fueltank_leaked = pick_n_take(matching_tanks)
		matching_tanks -= fueltank_leaked

		if (fueltank_leaked)
			var/fuel_units_leak = rand(25, 100)
			fueltank_leaked.modded = TRUE
			fueltank_leaked.leak_fuel(fuel_units_leak)

			message_admins("Fuel tank was opened and leaked by event at ([fueltank_leaked.x],[fueltank_leaked.y],[fueltank_leaked.z]), leaking [fuel_units_leak] units.")
		
/datum/event/leaking_tanks/proc/announce()
	SSannounce.play_station_announce(/datum/announce/leak_fueltanks)

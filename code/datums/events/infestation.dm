// TODO(rufus): while Cael did a great job keeping janitors busy back in 2013, this event is too basic
//   for the modern build. Just a bunch of vermins spawning in a room all of a sudden looks janky and
//   doesn't make a good impression of the event system.
//   Needs to be reimplemented with better dynamic logic, modern code and maybe some interactivity.
//   Some examples: the code should check if anyone is in the room, have more types of vermin,
//   have a chance at rare creatures, provide an announcement to allow crew to weld vents and scrubbers,
//   thus creating an interaction with engineers, have some species carry diseases, cause wire breakages
//   for applicable vermin types, spawn over neighbouring areas, make vermins steal food and so on.
//   The more dynamic and creative this system will be, the better.
#define VERM_MICE 0
#define VERM_LIZARDS 1
#define VERM_SPIDERS 2
#define VERM_CRABS 3
#define VERM_HAMSTERS 4

/datum/event/infestation
	id = "infestation"
	name = "Infestation"
	description = "A large number of vermin will appear at the station"

	mtth = 2.5 HOURS
	difficulty = 15

	var/area/location
	var/vermin
	var/vermstring
	var/list/affecting_z = list()

/datum/event/infestation/New()
	. = ..()

	add_think_ctx("announce", CALLBACK(src, nameof(.proc/announce)), 0)

/datum/event/infestation/get_mtth()
	. = ..()
	. -= (SSevents.triggers.roles_count["Janitor"] * (30 MINUTES))
	. = max(1 HOUR, .)

/datum/event/infestation/on_fire()
	affecting_z = GLOB.using_map.get_levels_with_trait(ZTRAIT_STATION)
	var/list/vermin_turfs
	var/attempts = 3
	do
		vermin_turfs = set_location_get_infestation_turfs()
		if(!location)
			return
	while(!vermin_turfs && --attempts > 0)

	if(!vermin_turfs)
		log_debug("Vermin infestation failed to find a viable spawn after 3 attempts. Aborting.")
		return

	var/list/spawn_types = list()
	var/max_number
	vermin = rand(0, 3)
	switch(vermin)
		if(VERM_MICE)
			spawn_types = list(/mob/living/simple_animal/mouse) // The base mouse type selects a random color for us
			max_number = 12
			vermstring = "mice"
		if(VERM_LIZARDS)
			spawn_types = list(/mob/living/simple_animal/lizard)
			max_number = 4
			vermstring = "lizards"
		if(VERM_SPIDERS)
			spawn_types = list(/obj/structure/spider/spiderling)
			max_number = 3
			vermstring = "spiders"
		if(VERM_CRABS)
			spawn_types = list(/mob/living/simple_animal/crab)
			max_number = 4
			vermstring = "crabs"
		if(VERM_HAMSTERS)
			spawn_types = list(/mob/living/simple_animal/hamster)
			max_number = 10
			vermstring = "space hamsters"

	spawn(0)
		var/num = rand(2, max_number)
		var/datum/reagent/lizard_poison = pick(POSSIBLE_LIZARD_TOXINS)
		log_and_message_admins("Vermin infestation spawned ([vermstring] x[num]) in \the [location]", location = pick_area_turf(location))
		while(vermin_turfs.len && num > 0)
			var/turf/simulated/floor/T = pick(vermin_turfs)
			vermin_turfs.Remove(T)
			num--

			var/spawn_type = pick(spawn_types)
			var/obj/structure/spider/spiderling/S = new spawn_type(T)
			if(istype(S))
				S.amount_grown = -1
			if(istype(S, /mob/living/simple_animal/lizard))
				var/mob/living/simple_animal/lizard/L = S
				if(prob(50))
					L.setPoison(lizard_poison)

	set_next_think_ctx("announce", world.time + (30 SECONDS))

/datum/event/infestation/proc/announce()
	SSannounce.play_station_announce(/datum/announce/infestation, "Bioscans indicate that [vermstring] have been breeding in \the [location]. Clear them out, before this starts to affect productivity.")

/datum/event/infestation/proc/set_location_get_infestation_turfs()
	location = pick_area(list(/proc/is_not_space_area, /proc/is_station_area))
	if(!location)
		log_debug("Vermin infestation failed to find a viable area. Aborting.")
		return

	var/list/vermin_turfs = get_area_turfs(location, list(/proc/not_turf_contains_dense_objects, /proc/IsTurfAtmosSafe))
	if(!vermin_turfs.len)
		log_debug("Vermin infestation failed to find viable turfs in \the [location].")
		return
	return vermin_turfs

#undef VERM_MICE
#undef VERM_LIZARDS
#undef VERM_SPIDERS
#undef VERM_CRABS

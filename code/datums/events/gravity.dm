// TODO(rufus): an absolutely boring even that doesn't introduce anything besides a necessity
//   for someone with access to do a few clicks at the gravgen. Causes massive annoyance for the
//   players too as they can't do anything about it, and if gravgen is not addressed in time,
//   this just makes gameplay more annoying for everyone.
//   Keeping this enabled at an increased mtth of 3 hours so gravitation and gravgen stay at least somewhat relevant,
//   but this needs to be rethought and re-implemented in some other way.
/datum/event/gravity
	id = "gravity"
	name = "Gravity Failure"
	description = "The gravity generator will be turned off for a while"

	mtth = 2 HOURS
	difficulty = 40

/datum/event/gravity/New()
	. = ..()

	add_think_ctx("announce", CALLBACK(src, nameof(.proc/announce)), 0)

/datum/event/gravity/get_mtth()
	. = ..()
	. -= (SSevents.triggers.roles_count["Engineer"] * (11 MINUTES))
	. = max(1 HOUR, .)

/datum/event/gravity/on_fire()
	var/obj/machinery/gravity_generator/main/GG = GLOB.station_gravity_generator
	if(!GG)
		log_debug("The gravity generator was not found while trying to start an event.")
		return

	GG.set_state(FALSE)
	set_next_think_ctx("announce", world.time + (rand(30, 60) SECONDS))

/datum/event/gravity/proc/announce()
	SSannounce.play_announce(/datum/announce/gravity_failure)

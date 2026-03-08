/datum/element/waddling

/datum/element/waddling/attach(datum/target)
	. = ..()
	if(!istype(target))
		return ELEMENT_INCOMPATIBLE
	if(isliving(target))
		register_signal(target, SIGNAL_MOVED, nameof(.proc/LivingWaddle))

/datum/element/waddling/detach(datum/source, force)
	. = ..()
	unregister_signal(source, SIGNAL_MOVED)

/datum/element/waddling/proc/LivingWaddle(mob/living/target)
	SIGNAL_HANDLER
	if(target.incapacitated() || target.lying)
		return
	waddling_animation(target)

/datum/element/waddling/proc/waddling_animation(atom/movable/target)
	animate(target, pixel_z = 4, time = 0)
	var/prev_trans = matrix(target.transform)
	animate(pixel_z = 0, transform = turn(target.transform, pick(-12, 0, 12)), time = 2)
	animate(pixel_z = 0, transform = prev_trans, time = 0)

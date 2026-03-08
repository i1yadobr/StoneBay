/datum/element/waddling

/datum/element/waddling/attach(datum/target)
	. = ..()
	if(!istype(target))
		return ELEMENT_INCOMPATIBLE
	if(isliving(target))
		register_signal(target, SIGNAL_MOVED, .proc/LivingWaddle)
	else
		register_signal(target, SIGNAL_MOVED, .proc/Waddle)

/datum/element/waddling/detach(datum/source, force)
	. = ..()
	unregister_signal(source, SIGNAL_MOVED)

/datum/element/waddling/proc/LivingWaddle(mob/living/target)
	if(target.incapacitated() || target.lying)
		return
	Waddle(target)

/datum/element/waddling/proc/Waddle(atom/movable/target)
	animate(target, pixel_z = 4, time = 0)
	animate(pixel_z = 0, transform = turn(matrix(), pick(-12, 0, 12)), time=2)
	animate(pixel_z = 0, transform = matrix(), time = 0)
	animate(pixel_z = 0, transform = matrix(), time = 0)

/mob/living/silicon/robot/has_non_slip_footing(obj/item/shoes)
	if(module && module.no_slip)
		return TRUE
	return FALSE

/mob/living/silicon/robot/has_magnetised_footing(obj/item/shoes)
	if(module && module.no_slip)
		return TRUE
	return FALSE

/mob/living/silicon/robot/get_jetpack()
	return locate(/obj/item/tank/jetpack) in module?.modules

 //No longer needed, but I'll leave it here incase we plan to re-use it.
/mob/living/silicon/robot/movement_delay()
	var/tally = ..() //Incase I need to add stuff other than "speed" later

	tally += speed

	if(module_active && istype(module_active, /obj/item/borg/combat/mobility))
		tally-=3

	return tally+config.movement.robot_delay

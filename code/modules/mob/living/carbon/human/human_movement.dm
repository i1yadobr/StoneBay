/mob/living/carbon/human/movement_delay()
	. = ..()

	. += species.handle_movement_delay_special(src)

	var/human_delay = config.movement.human_delay

	if(istype(loc, /turf/space))
		return (. + human_delay) // It's hard to be slowed down in space by... anything. Except for your shitty physical body restrictions.

	if(embedded_flag || (stomach_contents && stomach_contents.len))
		handle_embedded_and_stomach_objects() //Moving with objects stuck in you can cause bad times.

	for(var/M in mutations)
		switch(M)
			if(mRun)
				return human_delay
			if(MUTATION_FAT)
				. += 1.5

	for(var/datum/modifier/M in modifiers)
		if(!isnull(M.haste) && M.haste == TRUE)
			return -1 // Returning -1 will actually result in a slowdown for Teshari.
		if(!isnull(M.slowdown))
			. += M.slowdown

		var/equipment_slowdown_immunity = FALSE
		for(var/datum/modifier/movespeed/MS in modifiers)
			if(!isnull(MS.movespeed_modifier))
				. += MS.movespeed_modifier

			if(!equipment_slowdown_immunity && MS.equipment_slowdown_immunity)
				equipment_slowdown_immunity = TRUE

	if(species.slowdown)
		. += species.slowdown

	if(aiming)
		. += aiming.movement_tally // Iron sights make you slower, it's a well-known fact.

	if(bodytemperature < 283.222)
		. += (283.222 - bodytemperature) / 10 * 1.75

	. += blocking * 1.5

	var/health_deficiency_percent = 100 - (health / maxHealth) * 100
	if(health_deficiency_percent >= 40)
		. += (health_deficiency_percent / 25)

	var/shock = get_shock()
	if(shock >= 10)
		. += (shock / 10) //pain shouldn't slow you down if you can't even feel it

	if(!full_prosthetic)	// not using isSynthetic cuz of overhead
		var/normalized_nutrition = nutrition / body_build.stomach_capacity
		var/nut_level = normalized_nutrition / 100
		switch(normalized_nutrition)
			if(0 to STOMACH_FULLNESS_LOW)
				. += 1.25 - nut_level
			if(STOMACH_FULLNESS_HIGH to INFINITY)
				. += nut_level - 4.25

	if(body_build.equipment_modifier > 0) // Is our equipment_modifier a good thing?
		if(equipment_slowdown + 1 > body_build.equipment_modifier)  // Lowering equipment cooldown if it's higher
			. += equipment_slowdown - body_build.equipment_modifier // than equipment_modifier, ignoring it otherwise
		else
			. -= 1 // Since default equipment_slowdown is -1 for some reason
	else
		if(equipment_slowdown > -1)
			. += equipment_slowdown - body_build.equipment_modifier
		else
			. += equipment_slowdown

	. += body_build.slowdown

	var/list/organ_list = list(BP_L_LEG, BP_R_LEG, BP_L_FOOT, BP_R_FOOT)  // if character use legs
	if(istype(buckled, /obj/structure/bed/chair/wheelchair))              // if character buckled into wheelchair
		organ_list = list(BP_L_HAND, BP_R_HAND, BP_L_ARM, BP_R_ARM)

	for(var/organ_name in organ_list)
		var/obj/item/organ/external/E = get_organ(organ_name)
		if(!E)
			. += 4
		else
			. += E.movement_tally

	for(var/E in chem_effects)
		switch(E)
			if(CE_SPEEDBOOST)
				. = max((. - chem_effects[CE_SPEEDBOOST]), (config.movement.run_speed/2))
			if(CE_SLOWDOWN)
				. += chem_effects[CE_SLOWDOWN]

	return (. + human_delay)

/mob/living/carbon/human/can_slip(magboots_only = FALSE)
	. = ..()
	if(!.)
		return

	if(species?.check_no_slip(src, magboots_only))
		return FALSE

	return TRUE

/mob/living/carbon/human/get_jetpack()
	if(!back)
		return null

	if(istype(back, /obj/item/tank/jetpack))
		return back

	if(istype(back, /obj/item/rig))
		var/obj/item/rig/rig = back
		for(var/obj/item/rig_module/maneuvering_jets/module in rig.installed_modules)
			return module.jets

	return null

/mob/living/carbon/human/get_eva_slip_prob(prob_slip = 10)
	// General slip check.
	if((has_gravity() || has_magnetised_footing()) && get_solid_footing())
		return 0
	var/obj/item/tank/jetpack/thrust = get_jetpack()
	if(thrust && thrust.on && thrust.stabilization_on)
		return 0 // Otherwise we are unable to slip in outer space, but still may slip while crawling along the hull.
	if(!l_hand)
		prob_slip -= 2
	else if(l_hand.w_class <= ITEM_SIZE_SMALL)
		prob_slip -= 1
	if(!r_hand)
		prob_slip -= 2
	else if(r_hand.w_class <= ITEM_SIZE_SMALL)
		prob_slip -= 1
	if(m_intent != M_RUN)
		prob_slip *= 0.5
	return max(prob_slip, 0)

/obj/item/organ/internal/kidneys
	name = "kidneys"
	icon_state = "kidneys"
	gender = PLURAL
	organ_tag = BP_KIDNEYS
	parent_organ = BP_GROIN
	min_bruised_damage = 25
	min_broken_damage = 40
	max_damage = 60
	relative_size = 25
	var/detox_efficiency = 0.25
	var/hydration_consumption = DEFAULT_THIRST_FACTOR

/obj/item/organ/internal/kidneys/robotize()
	. = ..()
	SetName("renal implants")
	icon_state = "kidneys-prosthetic"
	dead_icon = "kidneys-prosthetic-br"

/obj/item/organ/internal/kidneys/think()
	..()

	if(!owner)
		return

	if(isundead(owner))
		return

	detox_efficiency = 0.25
	// Technically, ceases toxloss healing function. Lore-wise, still filters out the body's natural toxic buildup, but can't handle anything beyond that.
	if(is_bruised())
		detox_efficiency -= 0.25
	// Causes the body's natural toxic buildup to... build up.
	if(is_broken())
		detox_efficiency -= 0.5

/obj/item/organ/internal/kidneys/proc/process_hydration()
	if(!owner)
		return

	if(isundead(owner))
		return

	var/dynamic_hydration_consumption = hydration_consumption
	switch(owner.hydration)
		if(HYDRATION_NONE)
			dynamic_hydration_consumption = 0
			take_internal_damage(0.15) // kidneys autoheal 0.1 damage each tick, so we effectively deal 0.05 damage here; hence it takes ~17 minutes of complete dehydration to bruise a pair of healthy kidneys.
		if(HYDRATION_NONE to HYDRATION_LOW)
			dynamic_hydration_consumption *= 0.75
		if(HYDRATION_HIGH to HYDRATION_SUPER)
			dynamic_hydration_consumption *= 1.25
		if(HYDRATION_SUPER to INFINITY)
			dynamic_hydration_consumption *= 2.0

	owner.remove_hydration(dynamic_hydration_consumption)

	if(owner.should_have_organ(BP_BLADDER))
		var/obj/item/organ/internal/bladder/L = owner.internal_organs_by_name[BP_BLADDER]
		if(!L)
			// Abdominal cavity here.
			return
		L.waste_to_spawn += dynamic_hydration_consumption


/obj/item/organ/internal/liver
	name = "liver"
	icon_state = "liver"
	w_class = ITEM_SIZE_SMALL
	organ_tag = BP_LIVER
	parent_organ = BP_CHEST
	min_bruised_damage = 25
	min_broken_damage = 45 // Also the amount of toxic damage it can store
	max_damage = 70
	relative_size = 60
	var/stored_tox = 0
	var/coagulation = COAGULATION_NORMAL
	var/filtering_efficiency = 3

/obj/item/organ/internal/liver/New(mob/living/carbon/holder)
	..(holder)
	update_coagulation()

/obj/item/organ/internal/liver/robotize()
	. = ..()
	SetName("hepatic filter")
	icon_state = "liver-prosthetic"
	dead_icon = "liver-prosthetic-br"

/obj/item/organ/internal/liver/set_dna(datum/dna/new_dna)
	..()
	update_coagulation()

/obj/item/organ/internal/liver/removed(mob/living/user, drop_organ = TRUE, detach = TRUE)
	owner?.coagulation = COAGULATION_NONE
	..()

/obj/item/organ/internal/liver/replaced(mob/living/carbon/human/target, obj/item/organ/external/affected)
	. = ..()
	if(. && owner)
		update_coagulation()

/obj/item/organ/internal/liver/proc/update_coagulation()
	if(species)
		coagulation = species.coagulation
	if(is_broken())
		coagulation = COAGULATION_NONE
	else if(is_bruised())
		coagulation = COAGULATION_WEAK
	return coagulation

/obj/item/organ/internal/liver/proc/store_tox(amount) // Store toxins up to min_broken_damage, return excessive toxins
	var/cap_toxins = max(0, min_broken_damage - stored_tox)
	. = max(0, amount - cap_toxins)
	stored_tox += amount - .

/obj/item/organ/internal/liver/think()
	..()

	if(!owner)
		return

	if(isundead(owner))
		return

	if(germ_level > INFECTION_LEVEL_ONE)
		if(prob(1))
			to_chat(owner, "<span class='danger'>Your skin itches.</span>")
	if(germ_level > INFECTION_LEVEL_TWO)
		if(prob(1))
			spawn owner.vomit()

	// Update the filtering efficiency of the liver.
	filtering_efficiency = 3
	if(is_bruised())
		filtering_efficiency -= 1
	if(is_broken())
		filtering_efficiency -= 2
	// Robotic organs filter better but don't get benefits from dylovene for filtering.
	if(BP_IS_ROBOTIC(src) || owner.chem_effects[CE_ANTITOX])
		filtering_efficiency += 1
	if(owner.chem_effects[CE_ALCOHOL_TOXIC])
		filtering_efficiency -= 2
	else if(owner.chem_effects[CE_ALCOHOL])
		filtering_efficiency -= 1

	// If you're not filtering well, you're going to take damage. Even more if you have alcohol in you.
	if(filtering_efficiency < 2)
		owner.adjustToxLoss(0.5 * max(2 - filtering_efficiency, 0) * (1 + owner.chem_effects[CE_ALCOHOL_TOXIC] + 0.5 * owner.chem_effects[CE_ALCOHOL]))
	else
		// Get rid of some stored toxins.
		stored_tox = max(damage, (stored_tox - filtering_efficiency * 0.1))

	if((stored_tox > min_bruised_damage) && prob(stored_tox * 0.1))
		to_chat(src, SPAN("warning", "You feel nauseous..."))

	if(owner.chem_effects[CE_ALCOHOL_TOXIC])
		take_internal_damage(store_tox(owner.chem_effects[CE_ALCOHOL_TOXIC]/2), prob(90)) // Chance to warn them

/obj/item/organ/internal/liver/autoheal()
	if(!damage)
		return

	if(BP_IS_ROBOTIC(src))
		return // Flesh is superior.

	var/heal_value = autoheal_value * owner.coagulation

	// Boost healing a bit if we're not busy. Livers regenerate well, after all.
	if(!(owner.chem_effects[CE_ALCOHOL] || owner.chem_effects[CE_TOXIN] || owner.radiation > SAFE_RADIATION_DOSE))
		heal_value *= 2

	if(damage >= min_bruised_damage)
		damage = max(min_bruised_damage, damage - heal_value)
		return

	damage = max(0, damage - heal_value)
	return

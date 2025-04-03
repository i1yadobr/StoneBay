/obj/item/organ/internal/stomach
	name = "stomach"
	desc = "Gross. This is hard to stomach."
	icon_state = "stomach"
	dead_icon = "stomach"
	organ_tag = BP_STOMACH
	parent_organ = BP_CHEST
	min_bruised_damage = 25
	min_broken_damage = 45
	max_damage = 70
	relative_size = 40
	var/datum/reagents/metabolism/ingested
	var/next_cramp = 0
	var/volume_softcap = 120 // Above this point we'll start feeling bad.
	var/volume_hardcap = 240 // At this point our only option is vomiting left and right.
	var/list/processing = list()
	var/obj/item/currently_processing = null
	var/next_processing = 0

/obj/item/organ/internal/stomach/Destroy()
	QDEL_NULL(ingested)
	QDEL_NULL(currently_processing)
	QDEL_NULL_LIST(processing)
	. = ..()

/obj/item/organ/internal/stomach/New()
	..()
	ingested = new /datum/reagents/metabolism(contents_hardcap, owner, CHEM_INGEST)
	if(!ingested.my_atom)
		ingested.my_atom = src

/obj/item/organ/internal/stomach/robotize()
	..()
	SetName("nutrient processor")
	icon_state = "stomach-prosthetic"
	dead_icon = "stomach-prosthetic-br"

/obj/item/organ/internal/stomach/removed(mob/living/user, drop_organ = TRUE, detach = TRUE)
	. = ..()
	ingested.my_atom = src
	ingested.parent = null

/obj/item/organ/internal/stomach/replaced()
	. = ..()
	ingested.my_atom = owner
	ingested.parent = owner

/obj/item/organ/internal/stomach/proc/ingest(obj/item/I)
	if(QDELETED(I))
		return
	I.forceMove(src)
	processing.Add(I)

// 0 is empty, 100 is softcap, 200 is hardcap
/obj/item/organ/internal/stomach/proc/get_fullness()
	var/ret = ingested.total_volume
	for(var/obj/item/I in processing)
		ret += get_storage_cost() * 15
	return (ret / volume_softcap) * 100

// This call needs to be split out to make sure that all the ingested things are metabolised
// before the process call is made on any of the other organs
/obj/item/organ/internal/stomach/proc/metabolize()
	if(is_usable())
		ingested.metabolize()

/obj/item/organ/internal/stomach/think()
	..()

	if(!owner)
		return

	if(isundead(owner))
		return

	if(is_usable())
		for(var/mob/living/M in processing)
			if(M.is_ooc_dead())
				qdel(M)
				processing.Remove(M)
				continue

			M.adjustBruteLoss(3)
			M.adjustFireLoss(3)
			M.adjustToxLoss(3)

	else if(world.time >= next_cramp)
		next_cramp = world.time + rand(200, 800)
		owner.custom_pain("Your stomach cramps agonizingly!", 1)

	if(prob(1))
		var/fullness = get_fullness()
		if(fullness > 150)
			to_chat(src, SPAN("warning", "[pick("You definitely overate", "Thinking about food makes you gag", "It would be nice to clear your stomach")]..."))
		else if(fullness > 100)
			to_chat(src, SPAN("warning", "[pick("It seems you overate a bit", "Your own weight pulls you to the floor", "It would be nice to lose some weight")]..."))

	// Alcohol counts as double volume for the purposes of vomit probability
	var/effective_volume = ingested.total_volume + ingested.get_reagent_amount(/datum/reagent/ethanol)

	// Just over the limit, the probability will be low. It rises a lot such that at double ingested it's 16% chance per tick.
	if(effective_volume > 1.5 && (effective_volume / volume_softcap) ** 4)
		owner.vomit()

	if(QDELETED(currently_processing))
		currently_processing = null
		next_processing = 0

	// Damaged stomach works slower.
	var/reagents_processing = 1.5
	var/processing_time = 1.0
	if(is_broken())
		reagents_processing = 1.0
		processing_time = 2.5
	else if(is_bruised())
		reagents_processing = 1.25
		processing_time = 1.5

	// Reagents flow down evenly, as a mixture.
	ingested.trans_to_mob(owner, reagents_processing, CHEM_DIGEST)

	// Meanwhile, items get processed one by one, starting with the oldest.
	if(next_processing < world.time)
		return

	if(currently_processing)
		var/obj/item/organ/internal/intestines/I = owner.internal_organs_by_name[BP_INTESTINES]
		if(!I)
			// Abdominal cavity here.
		else
			if(!is_broken() && istype(currently_processing, /obj/item/reagent_containers))
				// Food, breaking down to reagents.
				currently_processing.reagents.trans_to_mob(owner, currently_processing.reagents.total_volume, CHEM_DIGEST)
				processing.Remove(currently_processing)
				qdel(currently_processing)
				currently_processing = null
			else
				// Not food, going down as it is.
				processing.Remove(currently_processing)
				currently_processing.forceMove(I)
				currently_processing = null

	// Choosing the next item to be digested.
	if(processing.len)
		currently_processing = processing[1]
		processing_time *= (currently_processing.get_storage_cost() * 10)
		next_processing = world.time + (processing_time * 1 SECOND)

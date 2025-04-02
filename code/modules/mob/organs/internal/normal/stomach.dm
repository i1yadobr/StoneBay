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
	var/list/ingesting = list()

/obj/item/organ/internal/stomach/Destroy()
	QDEL_NULL(ingested)
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

// 0 is empty, 100 is softcap, 200 is hardcap
/obj/item/organ/internal/stomach/proc/get_fullness()
	var/ret = 0
	for(obj/item/I in ingesting)
		ret += get_storage_cost()
	ret += ingested.total_volume

	return (ret / volume_softcap) * 100

// This call needs to be split out to make sure that all the ingested things are metabolised
// before the process call is made on any of the other organs
/obj/item/organ/internal/stomach/proc/metabolize()
	if(is_usable())
		ingested.metabolize()

#define STOMACH_VOLUME 65

/obj/item/organ/internal/stomach/think()
	..()

	if(!owner)
		return

	if(isundead(owner))
		return

	if(is_usable())
		for(var/mob/living/M in contents)
			if(M.is_ooc_dead())
				qdel(M)
				continue

			M.adjustBruteLoss(3)
			M.adjustFireLoss(3)
			M.adjustToxLoss(3)

	else if(world.time >= next_cramp)
		next_cramp = world.time + rand(200,800)
		owner.custom_pain("Your stomach cramps agonizingly!", 1)

	var/alcohol_volume = ingested.get_reagent_amount(/datum/reagent/ethanol)

	var/alcohol_threshold_met = alcohol_volume > STOMACH_VOLUME / 2
	if(alcohol_threshold_met && (owner.disabilities & EPILEPSY) && prob(20))
		owner.seizure()

	// Alcohol counts as double volume for the purposes of vomit probability
	var/effective_volume = ingested.total_volume + alcohol_volume

	// Just over the limit, the probability will be low. It rises a lot such that at double ingested it's 64% chance.
	var/vomit_probability = (effective_volume / STOMACH_VOLUME) ** 6
	if(prob(vomit_probability))
		owner.vomit()

#undef STOMACH_VOLUME

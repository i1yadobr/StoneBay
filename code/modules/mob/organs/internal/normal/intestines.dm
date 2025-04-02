/obj/item/organ/internal/intestines
	name = "intestines"
	desc = "A few meters of sausage casing."
	icon_state = "intestines"
	dead_icon = "intestines"
	organ_tag = BP_INTESTINES
	parent_organ = BP_GROIN
	min_bruised_damage = 25
	min_broken_damage = 60
	max_damage = 90
	relative_size = 60
	var/datum/reagents/metabolism/ingested

/obj/item/organ/internal/bladder/Destroy()
	QDEL_NULL(stored)
	. = ..()

/obj/item/organ/internal/bladder/New()
	..()
	stored = new /datum/reagents/metabolism(240, owner, CHEM_INGEST)
	if(!ingested.my_atom) ingested.my_atom = src

/obj/item/organ/internal/bladder/robotize()
	..()
	SetName("liquid waste storage")
	icon_state = "bladder-prosthetic"
	dead_icon = "bladder-prosthetic-br"

/obj/item/organ/internal/bladder/removed(mob/living/user, drop_organ = TRUE, detach = TRUE)
	. = ..()
	ingested.my_atom = src
	ingested.parent = null

/obj/item/organ/internal/bladder/replaced()
	. = ..()
	ingested.my_atom = owner
	ingested.parent = owner

/obj/item/organ/internal/bladder/think()
	..()

	if(!owner)
		return

	if(isundead(owner))
		return

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
	var/datum/reagents/metabolism/digested

/obj/item/organ/internal/intestines/Destroy()
	QDEL_NULL(digested)
	. = ..()

/obj/item/organ/internal/intestines/New()
	..()
	digested = new /datum/reagents/metabolism(240, owner, CHEM_DIGEST)
	if(!digested.my_atom)
		digested.my_atom = src

/obj/item/organ/internal/intestines/robotize()
	..()
	SetName("digestion unit")
	icon_state = "intestines-prosthetic"
	dead_icon = "intestines-prosthetic-br"

/obj/item/organ/internal/intestines/removed(mob/living/user, drop_organ = TRUE, detach = TRUE)
	. = ..()
	digested.my_atom = src
	digested.parent = null

/obj/item/organ/internal/intestines/replaced()
	. = ..()
	digested.my_atom = owner
	digested.parent = owner

/obj/item/organ/internal/intestines/proc/store_item(obj/item/I)
	if(QDELETED(I))
		return
	I.forceMove(src)

// This call needs to be split out to make sure that all the ingested things are metabolised
// before the process call is made on any of the other organs
/obj/item/organ/internal/intestines/proc/metabolize()
	if(is_usable())
		digested.metabolize()

/obj/item/organ/internal/intestines/think()
	..()

	if(!owner)
		return

	if(isundead(owner))
		return

	if(is_bruised() && prob(damage - min_broken_damage))
		var/messaged_already = FALSE
		for(var/obj/item/I in contents)
			if(I == food_organ)
				continue
			// Abdominal cavity here
			custom_pain("Your guts cramp agonizingly!", 20)


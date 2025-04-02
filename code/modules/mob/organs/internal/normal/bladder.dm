/obj/item/organ/internal/bladder
	name = "bladder"
	desc = "Water's transitional station on its way between glass and porcelain."
	icon_state = "bladder"
	dead_icon = "bladder"
	organ_tag = BP_BLADDER
	parent_organ = BP_GROIN
	min_bruised_damage = 25
	min_broken_damage = 45
	max_damage = 70
	relative_size = 25
	var/datum/reagents/stored

/obj/item/organ/internal/bladder/Destroy()
	QDEL_NULL(stored)
	. = ..()

/obj/item/organ/internal/bladder/New()
	..()
	stored = new /datum/reagents(HYDRATION_LIMIT, src)

/obj/item/organ/internal/bladder/robotize()
	..()
	SetName("liquid waste storage")
	icon_state = "bladder-prosthetic"
	dead_icon = "bladder-prosthetic-br"

/obj/item/organ/internal/bladder/think()
	..()

	if(!owner)
		return

	if(isundead(owner))
		return

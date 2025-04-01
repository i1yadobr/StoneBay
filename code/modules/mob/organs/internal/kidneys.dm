/obj/item/organ/internal/kidneys
	name = "kidneys"
	icon_state = "kidneys"
	gender = PLURAL
	organ_tag = BP_KIDNEYS
	parent_organ = BP_GROIN
	min_bruised_damage = 25
	min_broken_damage = 45
	max_damage = 70
	var/detox_efficiency = 0.25

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

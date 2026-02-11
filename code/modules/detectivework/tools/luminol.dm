/obj/item/reagent_containers/spray/luminol
	name = "luminol bottle"
	desc = "A bottle containing an odourless, colorless liquid."
	icon = 'icons/obj/forensics.dmi'
	item_icons = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/security_lefthand.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/security_righthand.dmi'
		)
	icon_state = "luminol"
	item_state = "luminol"
	amount_per_transfer_from_this = 10
	spray_size = 1
	possible_transfer_amounts = "10;25"
	volume = 0.5 LITERS

/obj/item/reagent_containers/spray/luminol/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/luminol, 0.5 LITERS)


/obj/item/reagent_containers/vessel/beaker
	name = "beaker"
	desc = "A beaker."
	icon = 'icons/obj/reagent_containers/chemical.dmi'
	item_icons = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/medical_lefthand.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/medical_righthand.dmi'
		)
	icon_state = "beaker"
	item_state = "beaker"
	center_of_mass = "x=17;y=10"
	force = 5.0
	mod_weight = 0.5
	mod_reach = 0.25
	mod_handy = 0.45
	matter = list(MATERIAL_GLASS = 2500)
	brittle = TRUE
	precise_measurement = TRUE

	volume = 0.3 LITERS
	amount_per_transfer_from_this = 25
	possible_transfer_amounts = "10;15;25;30;50;60;100;150;250;300" // Quite precise, but still requires syringes/droppers/vials for precise transfer.

	label_icon = TRUE
	overlay_icon = TRUE
	filling_states = "5;10;25;50;75;80;100"
	lid_type = /datum/vessel_lid/lid
	drop_sound = SFX_DROP_HELMET
	pickup_sound = SFX_PICKUP_HELMET

	rad_resist_type = /datum/rad_resist/beaker_large

/datum/rad_resist/beaker_large
	alpha_particle_resist = 11.8 MEGA ELECTRONVOLT
	beta_particle_resist = 0.8 MEGA ELECTRONVOLT
	hawking_resist = 1 ELECTRONVOLT

/obj/item/reagent_containers/vessel/beaker/large
	name = "large beaker"
	desc = "A large beaker."
	icon_state = "beakerlarge"
	item_state = "beakerlarge"
	center_of_mass = "x=17;y=10"
	force = 6.5
	mod_weight = 0.65
	mod_reach = 0.3
	mod_handy = 0.45
	matter = list(MATERIAL_GLASS = 5000)

	volume = 0.6 LITER
	amount_per_transfer_from_this = 25
	possible_transfer_amounts = "10;15;25;30;50;60;100;150;250;300;600"

	override_lid_state = LID_OPEN

/obj/item/reagent_containers/vessel/beaker/large/get_storage_cost()
	return ..() * 1.5

/obj/item/reagent_containers/vessel/beaker/plass
	name = "plass beaker"
	desc = "A beaker made of plass, it doesn't allow radiation to pass through."
	icon_state = "beaker_plass"
	item_state = "beaker_plass"
	matter = list(MATERIAL_PLASS = 2500)
	brittle = FALSE // Plass be strong
	rad_resist_type = /datum/rad_resist/beaker_plass

/datum/rad_resist/beaker_plass
	alpha_particle_resist = 48 MEGA ELECTRONVOLT
	beta_particle_resist = 22.2 MEGA ELECTRONVOLT
	hawking_resist = 1 ELECTRONVOLT

/obj/item/reagent_containers/vessel/beaker/noreact
	name = "cryostasis beaker"
	desc = "A cryostasis beaker that allows for chemical storage without reactions."
	icon_state = "beakernoreact"
	item_state = "beakernoreact"
	center_of_mass = "x=17;y=10"
	matter = list(MATERIAL_GLASS = 2500)
	brittle = FALSE
	atom_flags = ATOM_FLAG_NO_REACT
	override_lid_state = LID_OPEN


/obj/item/reagent_containers/vessel/beaker/bluespace
	name = "bluespace beaker"
	desc = "A bluespace beaker, powered by experimental bluespace technology."
	icon_state = "beakerbluespace"
	item_state = "beakerbluespace"
	center_of_mass = "x=17;y=10"
	force = 6.5
	mod_weight = 0.65
	mod_reach = 0.3
	mod_handy = 0.45
	matter = list(MATERIAL_STEEL = 1000, MATERIAL_GLASS = 5000)
	brittle = FALSE

	volume = 1.5 LITERS
	amount_per_transfer_from_this = 25
	possible_transfer_amounts = "10;25;30;50;60;100;150;200;300;600;1000;1500"

	override_lid_state = LID_OPEN

/obj/item/reagent_containers/vessel/beaker/vial
	name = "vial"
	desc = "A small glass vial."
	icon_state = "vial"
	item_state = "vial"
	center_of_mass = "x=16;y=10"
	force = 2.5
	mod_weight = 0.35
	mod_reach = 0.2
	mod_handy = 0.4
	matter = list(MATERIAL_GLASS = 1250)

	volume = 0.05 LITERS
	w_class = ITEM_SIZE_TINY
	amount_per_transfer_from_this = 5
	possible_transfer_amounts = "5;10;15;25;30;50"

	lid_type = /datum/vessel_lid/cork

/obj/item/reagent_containers/vessel/beaker/vial/reinforced
	name = "reinforced vial"
	desc = "A small reinforced glass vial."
	icon_state = "vialreinforced"
	item_state = "vialreinforced"
	matter = list(MATERIAL_STEEL = 250, MATERIAL_GLASS = 1250)
	brittle = FALSE

	volume = 0.08 LITERS
	possible_transfer_amounts = "5;10;15;25;40;50;80"

/obj/item/reagent_containers/vessel/beaker/vial/bluespace
	name = "bluespace vial"
	desc = "A small bluespace vial."
	icon_state = "vialbluespace"
	item_state = "vialbluespace"
	matter = list(MATERIAL_STEEL = 500, MATERIAL_GLASS = 2500)
	brittle = FALSE

	volume = 0.5 LITERS
	possible_transfer_amounts = "5;10;25;50;75;100;250;500"

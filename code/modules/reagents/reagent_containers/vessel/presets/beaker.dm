///
/// Presets for /obj/item/reagent_containers/vessel/beaker
///

/obj/item/reagent_containers/vessel/beaker/cryoxadone
	name = "cryoxadone beaker"
	desc = "Just put it into the nearest cryocell. Please."
	base_name = "beaker"
	base_desc = "A beaker."
	start_label = "cryoxadone"
	startswith = list(/datum/reagent/cryoxadone = 150)
	override_lid_state = LID_CLOSED

/obj/item/reagent_containers/vessel/beaker/sulphuric
	name = "sulphuric acid beaker"
	desc = "Suphuric acid is used for printing various circuits. Or melting down people's faces."
	base_name = "beaker"
	base_desc = "A beaker."
	start_label = "sulphuric acid"
	startswith = list(/datum/reagent/acid = 300)
	override_lid_state = LID_CLOSED

/obj/item/reagent_containers/vessel/beaker/vial/tricordrazine
	name = "tricordrazine vial"
	desc = "Tricordrazine vial is a highly potent stimulant. Can be used to treat a wide range of injuries."
	base_name = "vial"
	base_desc = "A small glass vial."
	startswith = list(/datum/reagent/tricordrazine = 50)

/obj/item/reagent_containers/vessel/beaker/vial/bluespace/adminordrazine
	name = "adminordrazine bluespace vial"
	desc = "It's magic vial. We don't have to explain it."
	base_name = "bluespace vial"
	base_desc = "A small bluespace vial."
	startswith = list(/datum/reagent/adminordrazine = 500)

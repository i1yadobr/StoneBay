// TODO: Add more medal variations
// Add special medals for awards from Central Command

/obj/item/clothing/accessory/medal
	name = "medal"
	desc = "A simple medal."
	icon_state = "bronze"
	item_state = "bronze"
	slot = ACCESSORY_SLOT_MEDAL
	coverage = 0.03 // Who said medals are useless?
	armor_values = alist(melee = 50, bullet = 90, laser = 120, energy = 65, bomb = 0, bio = 0)
	// Sprite used for medalbox
	var/medaltype = "medal"

/obj/item/clothing/accessory/medal/iron
	name = "iron medal"
	desc = "A simple iron medal."
	icon_state = "iron"
	item_state = "iron"
	medaltype = "medal-iron"

/obj/item/clothing/accessory/medal/bronze
	name = "bronze medal"
	desc = "A bronze medal."
	icon_state = "bronze"
	item_state = "bronze"

/obj/item/clothing/accessory/medal/bronze/heart
	name = "bronze heart medal"
	desc = "A bronze heart-shaped medal awarded for sacrifice. It is often awarded posthumously or for severe injury in the line of duty."
	icon_state = "bronze_heart"
	item_state = "bronze_heart"

/obj/item/clothing/accessory/medal/silver
	name = "silver medal"
	desc = "A silver medal."
	icon_state = "silver"
	item_state = "silver"
	medaltype = "medal-silver"

/obj/item/clothing/accessory/medal/gold
	name = "gold medal"
	desc = "A prestigious golden medal."
	icon_state = "gold"
	item_state = "gold"
	medaltype = "medal-gold"

/obj/item/clothing/accessory/medal/plasma
	name = "plasma medal"
	desc = "An eccentric medal made of plasma."
	icon_state = "plasma"
	item_state = "plasma"
	medaltype = "medal-plasma"

//NT medals!

/obj/item/clothing/accessory/medal/gold/nanotrasen
	name = "\improper NanoTrasen command medal"
	desc = "A gold medal awarded to NanoTrasen employees for service as the Captain of a NanoTrasen facility, station, or vessel."
	icon_state = "gold_nt"
	item_state = "gold_nt"

/obj/item/clothing/accessory/medal/silver/nanotrasen
	name = "\improper NanoTrasen service medal"
	desc = "A silver medal awarded to NanoTrasen employees for distinguished service in support of corporate interests."
	icon_state = "silver_nt"
	item_state = "silver_nt"

/obj/item/clothing/accessory/medal/bronze/nanotrasen
	name = "\improper NanoTrasen sciences medal"
	desc = "A bronze medal awarded to NanoTrasen employees for signifigant contributions to the fields of science or engineering."
	icon_state = "bronze_nt"
	item_state = "bronze_nt"

/obj/item/clothing/accessory/medal/iron/nanotrasen
	name = "\improper NanoTrasen merit medal"
	desc = "An iron medal awarded to NanoTrasen employees for merit."
	icon_state = "iron_nt"
	item_state = "iron_nt"

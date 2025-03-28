/*
 * Contains:
 *		Security
 *		Detective
 *		Head of Security
 */

/*
 * Security
 */
/obj/item/clothing/under/rank/security
	name = "security officer's jumpsuit"
	desc = "It's made of a slightly sturdier material than standard jumpsuits, to allow for robust protection."
	icon_state = "officer_red"
	item_state = "officer_red"
	armor = list(melee = 20, bullet = 20, laser = 20, energy = 0, bomb = 0, bio = 0)
	siemens_coefficient = 0.8

/obj/item/clothing/under/rank/security/skirt
	name = "security officer's jumpskirt"
	desc = "It's made of a slightly sturdier material than standard jumpskirt, to allow for robust protection."
	icon_state = "officer_red_skirt"
	item_state = "officer_red_skirt"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS

/obj/item/clothing/under/rank/warden
	name = "warden's jumpsuit"
	desc = "It's made of a slightly sturdier material than standard jumpsuits, to allow for more robust protection. It has the word \"Warden\" written on the shoulders."
	icon_state = "warden_red"
	item_state = "warden_red"
	armor = list(melee = 20, bullet = 20, laser = 20, energy = 0, bomb = 0, bio = 0)
	siemens_coefficient = 0.8

/obj/item/clothing/under/rank/warden/skirt
	name = "warden's jumpskirt"
	desc = "It's made of a slightly sturdier material than standard jumpskirt, to allow for more robust protection. It has the word \"Warden\" written on the shoulders."
	icon_state = "warden_red_skirt"
	item_state = "warden_red_skirt"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS

/obj/item/clothing/under/tactical
	name = "tactical jumpsuit"
	desc = "It's made of a slightly sturdier material than standard jumpsuits, to allow for robust protection."
	icon_state = "swatunder"
	item_state = "swatunder"
	armor = list(melee = 10, bullet = 5, laser = 5,energy = 0, bomb = 0, bio = 0)
	siemens_coefficient = 0.9

/obj/item/clothing/under/security_pants
	name = "security officer's trousers"
	desc = "Red pants made of a slightly sturdier material, to allow for robust protection."
	icon_state = "secpants"
	item_state = "secpants"
	gender = PLURAL
	body_parts_covered = LOWER_TORSO|LEGS
	armor = list(melee = 20, bullet = 20, laser = 20, energy = 0, bomb = 0, bio = 0)
	siemens_coefficient = 0.9

/obj/item/clothing/under/security_pants/equipped // Preequipped w/ a shirt
	starting_accessories = list(/obj/item/clothing/accessory/security_shirt)

/*
 * Detective
 */
/obj/item/clothing/under/rank/det
	name = "detective's suit"
	desc = "A rumpled white dress shirt paired with well-worn grey slacks."
	icon_state = "detective"
	item_state = "detective"
	armor = list(melee = 10, bullet = 5, laser = 5, energy = 0, bomb = 0, bio = 0)
	siemens_coefficient = 0.9
	starting_accessories = list(/obj/item/clothing/accessory/blue_clip)

/obj/item/clothing/under/rank/det/skirt
	name = "detective's skirt"
	desc = "A rumpled white dress shirt paired with well-worn grey skirt."
	icon_state = "detective_skirt"
	item_state = "detective_skirt"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS

/obj/item/clothing/under/rank/det/grey
	desc = "A serious-looking tan dress shirt paired with freshly-pressed black slacks."
	icon_state = "det_grey"
	item_state = "det_grey"
	starting_accessories = list(/obj/item/clothing/accessory/red_long)

/obj/item/clothing/under/rank/det/black
	desc = "An immaculate white dress shirt, paired with a pair of dark grey dress pants, a red tie, and a charcoal vest."
	icon_state = "det_black"
	item_state = "det_black"
	starting_accessories = list(/obj/item/clothing/accessory/red_long, /obj/item/clothing/accessory/toggleable/vest)

/*
 * Head of Security
 */
/obj/item/clothing/under/rank/head_of_security
	name = "head of security's jumpsuit"
	desc = "It's a jumpsuit worn by those few with the dedication to achieve the position of \"Head of Security\". It has additional armor to protect the wearer."
	icon_state = "hos_red"
	item_state = "hos_red"
	armor = list(melee = 20, bullet = 25, laser = 25, energy = 0, bomb = 0, bio = 0)
	siemens_coefficient = 0.7

/obj/item/clothing/under/rank/head_of_security/skirt
	name = "head of security's jumpskirt"
	desc = "It's a jumpskirt worn by those few with the dedication to achieve the position of \"Head of Security\". It has additional armor to protect the wearer."
	icon_state = "hos_red_skirt"
	item_state = "hos_red_skirt"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS

/obj/item/clothing/under/rank/head_of_security/jensen
	name = "head of security's jumpsuit"
	desc = "You never asked for anything that stylish."
	icon_state = "jensen"
	item_state = "jensen"
	siemens_coefficient = 0.6

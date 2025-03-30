//Alphabetical order of civilian jobs.

/obj/item/clothing/under/rank/bartender
	name = "bartender's uniform"
	desc = "It looks like it could use some more flair."
	icon_state = "ba_suit"
	item_state = "ba_suit"

/obj/item/clothing/under/rank/bartender/skirt //Essentially we already have a similar dress, but it's donated, so...
	name = "bartender's skirt"
	icon_state = "bartender_skirt"
	item_state = "bartender_skirt"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS

/obj/item/clothing/under/rank/captain //Alright, technically not a 'civilian' but its better then giving a .dm file for a single define.
	name = "captain's jumpsuit"
	desc = "It's a blue jumpsuit with some gold markings denoting the rank of \"Captain\"."
	icon_state = "captain"
	item_state = "captain"

/obj/item/clothing/under/rank/captain/skirt
	name = "captain's jumpskirt"
	desc = "It's a blue jumpskirt with some gold markings denoting the rank of \"Captain\"."
	icon_state = "captain_skirt"
	item_state = "captain_skirt"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS

/obj/item/clothing/under/rank/captain/alt //Kind of like a legacy version of the uniform
	name = "captain's old jumpsuit"
	desc = "It's a green jumpsuit with some gold markings denoting the rank of \"Captain\"."
	icon_state = "captain_alt"
	//item_state = "captain_alt"

/obj/item/clothing/under/rank/qm
	name = "quartermaster's jumpsuit"
	desc = "It's a jumpsuit worn by the quartermaster. It's specially designed to prevent back injuries caused by pushing paper."
	icon_state = "qm"
	item_state = "qm"

/obj/item/clothing/under/rank/qm/skirt
	name = "quartermaster's jumpsskirt"
	desc = "It's a jumpskirt worn by the quartermaster. It's specially designed to prevent back injuries caused by pushing paper."
	icon_state = "qm_skirt"
	item_state = "qm_skirt"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS

/obj/item/clothing/under/rank/cargotech
	name = "cargo technician's jumpsuit"
	desc = "Shooooorts! They're comfy and easy to wear!"
	icon_state = "cargo"
	item_state = "cargo"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS

/obj/item/clothing/under/rank/cargotech/skirt
	name = "cargo technician's jumpskirt"
	desc = "Skiiiiirts! They're comfy and easy to wear!"
	icon_state = "cargo_skirt"
	item_state = "cargo_skirt"

/obj/item/clothing/under/rank/miner
	name = "shaft miner's jumpsuit"
	desc = "It's a snappy jumpsuit with a sturdy set of overalls. It is very dirty."
	icon_state = "miner"
	item_state = "miner"

/obj/item/clothing/under/rank/miner/skirt
	name = "shaft miner's jumpskirt"
	desc = "It's a snappy jumpskirt with a sturdy set of vest. It is very dirty."
	icon_state = "miner_skirt"
	item_state = "miner_skirt"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS

/obj/item/clothing/under/rank/chaplain
	name = "chaplain's jumpsuit"
	desc = "It's a black jumpsuit, often worn by religious folk."
	icon_state = "chaplain"
	item_state = "chaplain"

/obj/item/clothing/under/rank/chaplain/skirt
	name = "chaplain's jumpskirt"
	desc = "It's a black jumpskirt, often worn by religious folk."
	icon_state = "chaplain_skirt"
	item_state = "chaplain_skirt"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS

/obj/item/clothing/under/rank/chef
	name = "chef's uniform"
	desc = "It's an apron which is given only to the most <b>hardcore</b> chefs in space."
	icon_state = "chef"
	item_state = "chef"

/obj/item/clothing/under/rank/chef/skirt
	name = "chef's skirt"
	icon_state = "chef_skirt"
	item_state = "chef_skirt"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS

/obj/item/clothing/under/rank/clown
	name = "clown suit"
	desc = "<i>'HONK!'</i>"
	icon_state = "clown"
	item_state = "clown"

/obj/item/clothing/under/rank/head_of_personnel
	name = "head of personnel's jumpsuit"
	desc = "It's a jumpsuit worn by someone who works in the position of \"Head of Personnel\"."
	icon_state = "hop"
	item_state = "hop"

/obj/item/clothing/under/rank/head_of_personnel/skirt
	name = "head of personnel's jumpskirt"
	desc = "It's a jumpskirt worn by someone who works in the position of \"Head of Personnel\"."
	icon_state = "hop_skirt"
	item_state = "hop_skirt"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS

/obj/item/clothing/under/rank/head_of_personnel/whimsy
	name = "head of personnel's suit"
	desc = "A blue jacket and red tie, with matching red cuffs! Snazzy. Wearing this makes you feel more important than your job title does."
	icon_state = "hopwhimsy"
	item_state = "hopwhimsy"

/obj/item/clothing/under/rank/hydroponics
	name = "botanist's jumpsuit"
	desc = "It's a jumpsuit designed to protect against minor plant-related hazards."
	icon_state = "hydroponics"
	item_state = "hydroponics"
	permeability_coefficient = 0.50

/obj/item/clothing/under/rank/hydroponics/skirt
	name = "botanist's jumpskirt"
	desc = "It's a jumpskirt designed to protect against minor plant-related hazards."
	icon_state = "hydroponics_skirt"
	item_state = "hydroponics_skirt"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS

/obj/item/clothing/under/rank/internalaffairs
	name = "Internal Affairs uniform"
	desc = "The plain, professional attire of an Internal Affairs Agent. The collar is <i>immaculately</i> starched."
	icon_state = "internalaffairs"
	item_state = "internalaffairs"
	starting_accessories = list(/obj/item/clothing/accessory/black)

/obj/item/clothing/under/rank/internalaffairs/skirt
	name = "Internal Affairs skirt"
	icon_state = "internalaffairs_skirt"
	item_state = "internalaffairs_skirt"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS

/obj/item/clothing/under/rank/janitor
	name = "janitor's jumpsuit"
	desc = "It's the official jumpsuit of the janitor. It has minor protection from biohazards."
	icon_state = "janitor"
	item_state = "janitor"
	armor = list(melee = 5, bullet = 5, laser = 5, energy = 0, bomb = 0, bio = 10)

/obj/item/clothing/under/rank/janitor/skirt
	name = "janitor's jumpskirt"
	desc = "It's the official jumpskirt of the janitor. It has minor protection from biohazards."
	icon_state = "janitor_skirt"
	item_state = "janitor_skirt"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS

/obj/item/clothing/under/lawyer
	name = "Lawyer suit"
	desc = "Slick threads."
	icon_state = "lawyer_black"
	item_state = "lawyer_black"

/obj/item/clothing/under/lawyer/black
	name = "black Lawyer suit"
	icon_state = "lawyer_black"
	item_state = "lawyer_black"

/obj/item/clothing/under/lawyer/female
	name = "black Lawyer suit"
	icon_state = "black_suit_fem"
	item_state = "black_suit_fem"

/obj/item/clothing/under/lawyer/red
	name = "red Lawyer suit"
	icon_state = "lawyer_red"
	item_state = "lawyer_red"

/obj/item/clothing/under/lawyer/blue
	name = "blue Lawyer suit"
	icon_state = "lawyer_blue"
	item_state = "lawyer_blue"

/obj/item/clothing/under/lawyer/bluesuit
	name = "Blue Suit"
	desc = "A classy suit."
	icon_state = "bluesuit"
	item_state = "bluesuit"
	starting_accessories = list(/obj/item/clothing/accessory/red)

/obj/item/clothing/under/lawyer/bluesuit/skirt
	name = "Blue Suit Skirt"
	desc = "A classy suit skirt."
	icon_state = "bluesuit_skirt"
	item_state = "bluesuit_skirt"

/obj/item/clothing/under/lawyer/purpsuit
	name = "Purple Suit"
	icon_state = "lawyer_purp"
	item_state = "lawyer_purp"

/obj/item/clothing/under/lawyer/oldman
	name = "Old Man's Suit"
	desc = "A classic suit for the older gentleman with built in back support."
	icon_state = "oldman"
	item_state = "oldman"

/obj/item/clothing/under/librarian
	name = "sensible suit"
	desc = "It's very... sensible."
	icon_state = "red_suit"
	item_state = "red_suit"

/obj/item/clothing/under/librarian/skirt
	name = "sensible skirt"
	icon_state = "librarian_skirt"
	item_state = "librarian_skirt"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS

/obj/item/clothing/under/rank/mime
	name = "mime's outfit"
	desc = "It's not very colourful."
	icon_state = "mime"
	item_state = "mime"

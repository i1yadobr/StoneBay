/obj/item/storage/lunchbox
	name = "rainbow lunchbox"
	desc = "A little lunchbox. This one is the colors of the rainbow!"
	icon = 'icons/obj/storage/lunch.dmi'
	icon_state = "lunchbox_rainbow"
	item_state = "toolbox_pink"
	w_class = ITEM_SIZE_NORMAL
	max_w_class = ITEM_SIZE_SMALL
	max_storage_space = 8 //slightly smaller than a toolbox
	attack_verb = "lunched"

	var/filled = FALSE

/obj/item/storage/lunchbox/New()
	..()
	if(filled)
		var/list/lunches = lunchables_lunches()
		var/lunch = lunches[pick(lunches)]
		new lunch(src)

		var/list/snacks = lunchables_snacks()
		var/snack = snacks[pick(snacks)]
		new snack(src)

		var/list/drinks = lunchables_drinks()
		var/drink = drinks[pick(drinks)]
		new drink(src)

/obj/item/storage/lunchbox/filled
	filled = TRUE

/obj/item/storage/lunchbox/heart
	name = "heart lunchbox"
	desc = "A little lunchbox. This one has cute little hearts on it!"
	icon_state = "lunchbox_lovelyhearts"
	item_state = "toolbox_pink"

/obj/item/storage/lunchbox/heart/filled
	filled = TRUE

/obj/item/storage/lunchbox/cat
	name = "cat lunchbox"
	desc = "A little lunchbox. This one has a cute little science cat from a popular show on it!"
	icon_state = "lunchbox_sciencecatshow"
	item_state = "toolbox_green"

/obj/item/storage/lunchbox/cat/filled
	filled = TRUE

/obj/item/storage/lunchbox/nt
	name = "NanoTrasen brand lunchbox"
	desc = "A little lunchbox. This one is branded with the Nanotrasen logo!"
	icon_state = "lunchbox_nanotrasen"
	item_state = "toolbox_blue"

/obj/item/storage/lunchbox/nt/filled
	filled = TRUE

/obj/item/storage/lunchbox/mars
	name = "\improper Mariner University lunchbox"
	desc = "A little lunchbox. This one is branded with the Mariner university logo!"
	icon_state = "lunchbox_marsuniversity"
	item_state = "toolbox_red"

/obj/item/storage/lunchbox/mars/filled
	filled = TRUE

/obj/item/storage/lunchbox/cti
	name = "\improper CTI lunchbox"
	desc = "A little lunchbox. This one is branded with the CTI logo!"
	icon_state = "lunchbox_cti"
	item_state = "toolbox_blue"

/obj/item/storage/lunchbox/cti/filled
	filled = TRUE

/obj/item/storage/lunchbox/nymph
	name = "\improper Diona nymph lunchbox"
	desc = "A little lunchbox. This one is an adorable Diona nymph on the side!"
	icon_state = "lunchbox_dionanymph"
	item_state = "toolbox_yellow"

/obj/item/storage/lunchbox/nymph/filled
	filled = TRUE

/obj/item/storage/lunchbox/syndicate
	name = "black and red lunchbox"
	desc = "A little lunchbox. This one is a sleek black and red, made of a durable steel!"
	icon_state = "lunchbox_syndie"
	item_state = "toolbox_syndi"

/obj/item/storage/lunchbox/syndicate/filled
	filled = TRUE

/obj/item/storage/lunchbox/TCC
	name = "\improper TCC lunchbox"
	desc = "A little lunchbox. This one is branded with the flag of the Terran Colonial Confederation!"
	icon_state = "lunchbox_tcc"
	item_state = "toolbox_syndi"

/obj/item/storage/lunchbox/syndicate/filled
	filled = TRUE

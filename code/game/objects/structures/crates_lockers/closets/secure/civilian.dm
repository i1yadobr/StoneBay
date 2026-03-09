/obj/structure/closet/secure_closet/mime
	name = "mime's locker"
	icon_state = "securemime1"
	icon_closed = "securemime"
	icon_locked = "securemime1"
	icon_opened = "securemimeopen"
	icon_off = "securemimeoff"
	req_access = list(access_mime)
	// It's silent!
	open_sound = null
	close_sound = null

/obj/structure/closet/secure_closet/mime/WillContain()
	return list(
		/obj/item/clothing/head/soft/mime,
		/obj/item/clothing/head/beret/mime,
		/obj/item/clothing/head/beret/mime/black,
		/obj/item/clothing/mask/gas/mime,
		/obj/item/clothing/mask/gas/sexymime,
		/obj/item/clothing/accessory/suspenders,
		/obj/item/clothing/under/rank/mime,
		/obj/item/clothing/under/rank/mime/skirt,
		/obj/item/clothing/under/rank/mime/sexy,
		/obj/item/clothing/gloves/white,
		/obj/item/clothing/shoes/laceup,
		/obj/item/clothing/shoes/mime,
		/obj/item/storage/backpack/mime,
		/obj/item/reagent_containers/vessel/bottle/bottleofnothing,
		/obj/item/cane
	)

/obj/structure/closet/secure_closet/clown
	name = "clown's locker"
	icon_state = "secureclown1"
	icon_closed = "secureclown"
	icon_locked = "secureclown1"
	icon_opened = "secureclownopen"
	icon_off = "secureclownoff"
	req_access = list(access_clown)

/obj/structure/closet/secure_closet/clown/WillContain()
	return list(
		/obj/item/storage/garment/clown,
		/obj/item/storage/backpack/clown,
		/obj/item/device/radio/headset,
		/obj/item/reagent_containers/spray/waterflower,
		/obj/item/seeds/bananaseed,
		/obj/item/bikehorn,
		/obj/item/pen/crayon/rainbow
	)

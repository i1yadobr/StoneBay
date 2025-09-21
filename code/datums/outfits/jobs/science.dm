/decl/hierarchy/outfit/job/science
	hierarchy_type = /decl/hierarchy/outfit/job/science
	l_ear = /obj/item/device/radio/headset/headset_sci
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	shoes = /obj/item/clothing/shoes/white
	pda_type = /obj/item/device/pda/science

/decl/hierarchy/outfit/job/science/New()
	..()
	BACKPACK_OVERRIDE_RESEARCH

/decl/hierarchy/outfit/job/science/rd
	name = OUTFIT_JOB_NAME("Глава Научного Отдела")
	l_ear = /obj/item/device/radio/headset/heads/rd
	uniform = /obj/item/clothing/under/rank/research_director
	shoes = /obj/item/clothing/shoes/brown
	l_hand = /obj/item/clipboard
	id_type = /obj/item/card/id/science/head
	pda_type = /obj/item/device/pda/heads/rd


/decl/hierarchy/outfit/job/science/senior
	name = OUTFIT_JOB_NAME("Старший Научный Сотрудник")
	uniform = /obj/item/clothing/under/rank/geneticist
	id_type = /obj/item/card/id/science
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/genetics


/decl/hierarchy/outfit/job/science/scientist
	name = OUTFIT_JOB_NAME("Научный сотрудник")
	uniform = /obj/item/clothing/under/rank/geneticist
	id_type = /obj/item/card/id/science
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/genetics

/decl/hierarchy/outfit/job/science/xenobiologist
	name = OUTFIT_JOB_NAME("Лабора")
	uniform = /obj/item/clothing/under/rank/geneticist
	id_type = /obj/item/card/id/science/xenobiologist
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/genetics

/decl/hierarchy/outfit/job/science/roboticist
	name = OUTFIT_JOB_NAME("Робототехник")
	uniform = /obj/item/clothing/under/rank/roboticist
	gloves = /obj/item/clothing/gloves/thick
	shoes = /obj/item/clothing/shoes/black
	belt = /obj/item/storage/belt/utility/full
	id_type = /obj/item/card/id/science/roboticist
	pda_slot = slot_r_store
	pda_type = /obj/item/device/pda/roboticist

/decl/hierarchy/outfit/job/science/roboticist/New()
	..()
	backpack_overrides.Cut()

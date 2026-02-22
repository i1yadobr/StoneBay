/decl/hierarchy/outfit/job/security/officer/corpse
	name = OUTFIT_JOB_NAME("Security Officer Corpse")
	mask = list(/obj/item/clothing/mask/balaclava, /obj/item/clothing/mask/gas/clear, /obj/item/clothing/mask/gas/old, null)
	glasses = list(/obj/item/clothing/glasses/hud/aviators/security, /obj/item/clothing/glasses/hud/aviators/security/active, /obj/item/clothing/glasses/hud/aviators/security/active, /obj/item/clothing/glasses/sunglasses)
	l_ear = list(/obj/item/device/radio/headset/headset_sec, /obj/item/device/radio/headset/headset_sec, /obj/item/clothing/ears/earmuffs, null)
	gloves = /obj/item/clothing/gloves/security
	shoes = list(/obj/item/clothing/shoes/jackboots, /obj/item/clothing/shoes/jackboots, /obj/item/clothing/shoes/black)
	uniform = list(/obj/item/clothing/under/rank/security, /obj/item/clothing/under/security_pants/equipped)
	suit = list(/obj/item/clothing/suit/armor/bulletproof, /obj/item/clothing/suit/armor/riot, /obj/item/clothing/suit/armor/laserproof, /obj/item/clothing/suit/space/void/security, /obj/item/clothing/suit/bomb_suit/security, /obj/item/clothing/suit/bio_suit/security, /obj/item/clothing/suit/armor/vest, null)
	head = list(/obj/item/clothing/head/soft/sec, /obj/item/clothing/head/beret/sec, /obj/item/clothing/head/beret/sec/corporate/officer, /obj/item/clothing/head/helmet/ballistic, /obj/item/clothing/head/helmet/ablative, /obj/item/clothing/head/helmet/riot, /obj/item/clothing/head/helmet/space/void/security, /obj/item/clothing/head/bio_hood/security,/obj/item/clothing/head/bomb_hood/security, /obj/item/clothing/head/helmet, null)
	l_pocket = null
	r_pocket = null
	flags = OUTFIT_NO_SURVIVAL
	back = list(/obj/item/gun/projectile/shotgun/pump, null)
	backpack_contents = null

/decl/hierarchy/outfit/job/security/warden/corpse
	name = OUTFIT_JOB_NAME("Warden Corpse")
	uniform = list(/obj/item/clothing/under/rank/warden)
	suit = list(/obj/item/clothing/suit/armor/vest/warden, /obj/item/clothing/suit/armor/vest/warden_heavy, /obj/item/clothing/suit/armor/bulletproof, /obj/item/clothing/suit/armor/riot, /obj/item/clothing/suit/armor/laserproof, null)
	head = list(/obj/item/clothing/head/warden/drill, /obj/item/clothing/head/warden, /obj/item/clothing/head/beret/sec/corporate/warden)
	back = list(/obj/item/gun/projectile/shotgun/pump, /obj/item/backwear/reagent/pepper, null)
	l_ear = list(/obj/item/device/radio/headset/headset_sec, /obj/item/device/radio/headset/tactical/sec)
	shoes = list(/obj/item/clothing/shoes/jackboots, /obj/item/clothing/shoes/jackboots, /obj/item/clothing/shoes/black)
	glasses = list(/obj/item/clothing/glasses/hud/aviators/security, /obj/item/clothing/glasses/hud/aviators/security/active, /obj/item/clothing/glasses/hud/aviators/security/active, /obj/item/clothing/glasses/sunglasses)
	l_pocket = null
	r_pocket = null
	flags = OUTFIT_NO_SURVIVAL
	backpack_contents = null

/decl/hierarchy/outfit/job/security/hos/corpse
	name = OUTFIT_JOB_NAME("Head of security Corpse")
	uniform = list(/obj/item/clothing/under/rank/head_of_security, /obj/item/clothing/under/rank/head_of_security/jensen)
	suit = list(/obj/item/clothing/suit/armor/hos/jensen, /obj/item/clothing/suit/armor/hos, /obj/item/clothing/suit/armor/vest/hos_heavy, /obj/item/clothing/suit/space/void/security/hos/prepared)
	l_ear = list(/obj/item/device/radio/headset/headset_sec, /obj/item/device/radio/headset/tactical/sec, /obj/item/device/radio/headset/heads/hos)
	mask = list(/obj/item/clothing/mask/balaclava, /obj/item/clothing/mask/gas/clear, /obj/item/clothing/mask/gas/old, null)
	shoes = list(/obj/item/clothing/shoes/jackboots, /obj/item/clothing/shoes/swat, /obj/item/clothing/shoes/swat)
	back = list(/obj/item/shield/riot, /obj/item/gun/energy/rifle/cheap, null)
	head = list(/obj/item/clothing/head/beret/sec/corporate/hos, /obj/item/clothing/head/HoS/dermal, /obj/item/clothing/head/HoS)
	glasses = list(/obj/item/clothing/glasses/hud/aviators/security, /obj/item/clothing/glasses/hud/aviators/security/active, /obj/item/clothing/glasses/hud/aviators/security/active, /obj/item/clothing/glasses/sunglasses)
	l_pocket = null
	r_pocket = null
	flags = OUTFIT_NO_SURVIVAL
	backpack_contents = null

/decl/hierarchy/outfit/job/cargo/qm/corpse
	name = OUTFIT_JOB_NAME("Quartermaster Corpse")
	gloves = list(/obj/item/clothing/gloves/thick, null)
	uniform = /obj/item/clothing/under/rank/qm
	shoes = list(/obj/item/clothing/shoes/jackboots, /obj/item/clothing/shoes/brown)
	glasses = /obj/item/clothing/glasses/sunglasses
	l_hand = /obj/item/clipboard
	flags = OUTFIT_NO_SURVIVAL

/decl/hierarchy/outfit/job/cargo/cargo_tech/corpse
	name = OUTFIT_JOB_NAME("Cargo technician Corpse")
	gloves = list(/obj/item/clothing/gloves/thick, null)
	shoes = list(/obj/item/clothing/shoes/jackboots, /obj/item/clothing/shoes/black)
	uniform = /obj/item/clothing/under/rank/cargotech
	suit = list(null, null, /obj/item/clothing/suit/armor/vest)
	flags = OUTFIT_NO_SURVIVAL

/decl/hierarchy/outfit/job/cargo/mining/corpse
	name = OUTFIT_JOB_NAME("Shaft miner Corpse")
	gloves = list(/obj/item/clothing/gloves/thick, null)
	shoes = list(/obj/item/clothing/shoes/jackboots, /obj/item/clothing/shoes/black, /obj/item/clothing/shoes/workboots)
	uniform = /obj/item/clothing/under/rank/miner
	backpack_contents = null
	belt = null
	flags = OUTFIT_NO_SURVIVAL

/obj/item/ammo_casing/a357
	caliber = CALIBER_357
	projectile_type = /obj/item/projectile/bullet/pistol/strong/revolver

/obj/item/ammo_casing/a50
	caliber = CALIBER_50AE
	projectile_type = /obj/item/projectile/bullet/pistol/strong

/obj/item/ammo_casing/a75
	caliber = CALIBER_20MM
	projectile_type = /obj/item/projectile/bullet/gyro

/obj/item/ammo_casing/c38
	caliber = CALIBER_38
	projectile_type = /obj/item/projectile/bullet/pistol

/obj/item/ammo_casing/c38/rubber
	caliber_bullet = CALIBER_BULLET_RUBBER
	projectile_type = /obj/item/projectile/bullet/pistol/rubber
	icon_state = "r-casing"
	spent_icon = "r-casing-spent"

/obj/item/ammo_casing/c38/spec
	caliber_bullet = CALIBER_BULLET_38_SPEC
	projectile_type = /obj/item/projectile/bullet/pistol/rubber
	icon_state = "s-casing"
	spent_icon = "s-casing-spent"

/obj/item/ammo_casing/c38/spec/nonlethal
	projectile_type = /obj/item/projectile/energy/electrode/c38

/obj/item/ammo_casing/c38/spec/lethal
	projectile_type = /obj/item/projectile/bullet/pistol/accelerated/c38

/obj/item/ammo_casing/c38/chem
	caliber_bullet = CALIBER_BULLET_38_CHEM
	projectile_type = /obj/item/projectile/energy/flash/c38
	icon_state = "empcasing"
	spent_icon = "s-casing-spent"

/obj/item/ammo_casing/c38/chem/nonlethal
	projectile_type = /obj/item/projectile/ion/c38

/obj/item/ammo_casing/c38/chem/lethal
	projectile_type = /obj/item/projectile/energy/c38

/obj/item/ammo_casing/c9mm
	caliber = CALIBER_9MM
	projectile_type = /obj/item/projectile/bullet/pistol

/obj/item/ammo_casing/c9mm/flash
	caliber_bullet = CALIBER_BULLET_FLASH
	projectile_type = /obj/item/projectile/energy/flash

/obj/item/ammo_casing/c9mm/rubber
	caliber_bullet = CALIBER_BULLET_RUBBER
	projectile_type = /obj/item/projectile/bullet/pistol/rubber
	icon_state = "r-casing"
	spent_icon = "r-casing-spent"

/obj/item/ammo_casing/c9mm/practice
	caliber_bullet = CALIBER_BULLET_PRACTICE
	projectile_type = /obj/item/projectile/bullet/pistol/practice

/obj/item/ammo_casing/c44
	caliber = CALIBER_44
	projectile_type = /obj/item/projectile/bullet/pistol/medium/revolver

/obj/item/ammo_casing/c44/rubber
	caliber_bullet = CALIBER_BULLET_RUBBER
	projectile_type = /obj/item/projectile/bullet/pistol/rubber
	icon_state = "r-casing"
	spent_icon = "r-casing-spent"

/obj/item/ammo_casing/c45
	caliber = CALIBER_45
	projectile_type = /obj/item/projectile/bullet/pistol/medium

/obj/item/ammo_casing/c45/practice
	caliber_bullet = CALIBER_BULLET_PRACTICE
	projectile_type = /obj/item/projectile/bullet/pistol/practice

/obj/item/ammo_casing/c45/rubber
	caliber_bullet = CALIBER_BULLET_RUBBER
	projectile_type = /obj/item/projectile/bullet/pistol/rubber
	icon_state = "r-casing"
	spent_icon = "r-casing-spent"

/obj/item/ammo_casing/c45/flash
	caliber_bullet = CALIBER_BULLET_FLASH
	projectile_type = /obj/item/projectile/energy/flash

/obj/item/ammo_casing/c45/stun
	projectile_type = /obj/item/projectile/energy/electrode/c45

/obj/item/ammo_casing/a10mm
	caliber = CALIBER_10MM
	projectile_type = /obj/item/projectile/bullet/pistol/medium/smg

/obj/item/ammo_casing/shotgun
	name = "shotgun slug shell"
	desc = "A 12 gauge slug shell."
	icon_state = "slshell"
	spent_icon = "slshell-spent"
	caliber = CALIBER_12G
	caliber_desc = FALSE
	projectile_type = /obj/item/projectile/bullet/shotgun
	matter = list(MATERIAL_STEEL = 360)
	fall_sounds = list('sound/effects/weapons/gun/shell_fall.ogg')

/obj/item/ammo_casing/shotgun/Initialize()
	. = ..()
	register_signal(src, SIGNAL_MOVED, nameof(/atom.proc/update_icon))

/obj/item/ammo_casing/shotgun/on_update_icon()
	if(spent_icon && is_spent)
		icon_state = spent_icon
	else
		icon_state = initial(icon_state)
	icon_state = "[icon_state][isturf(loc)? "-world" : ""]"

/obj/item/ammo_casing/shotgun/pellet
	name = "shotgun pellet shell"
	desc = "A 12 gauge pellet shell."
	icon_state = "gshell"
	spent_icon = "gshell-spent"
	projectile_type = /obj/item/projectile/bullet/pellet/shotgun
	matter = list(MATERIAL_STEEL = 360)

/obj/item/ammo_casing/shotgun/blank
	name = "shotgun blank shell"
	desc = "A 12 gauge blank shell."
	icon_state = "blshell"
	spent_icon = "blshell-spent"
	projectile_type = /obj/item/projectile/bullet/blank
	matter = list(MATERIAL_STEEL = 90)

/obj/item/ammo_casing/shotgun/practice
	name = "shotgun practice shell"
	desc = "A 12 gauge practice shell."
	icon_state = "pshell"
	spent_icon = "pshell-spent"
	projectile_type = /obj/item/projectile/bullet/shotgun/practice
	matter = list(MATERIAL_STEEL = 90)

/obj/item/ammo_casing/shotgun/beanbag
	name = "shotgun beanbag shell"
	desc = "A 12 gauge beanbag shell."
	icon_state = "bshell"
	spent_icon = "bshell-spent"
	projectile_type = /obj/item/projectile/bullet/shotgun/beanbag
	matter = list(MATERIAL_STEEL = 180)

//Can stun in one hit if aimed at the head, but
//is blocked by clothing that stops tasers and is vulnerable to EMP
/obj/item/ammo_casing/shotgun/stunshell
	name = "shotgun stun shell"
	desc = "A 12 gauge taser cartridge."
	icon_state = "stunshell"
	spent_icon = "stunshell-spent"
	projectile_type = /obj/item/projectile/energy/electrode/stunshot
	leaves_residue = 0
	matter = list(MATERIAL_STEEL = 360, MATERIAL_GLASS = 720)

/obj/item/ammo_casing/shotgun/stunshell/emp_act(severity)
	if(prob(100/severity))
		is_spent = TRUE
	update_icon()

//Does not stun, only blinds, but has area of effect.
/obj/item/ammo_casing/shotgun/flash
	name = "flash shell"
	desc = "A chemical shell used to signal distress or provide illumination."
	icon_state = "fshell"
	spent_icon = "fshell-spent"
	projectile_type = /obj/item/projectile/energy/flash/flare
	matter = list(MATERIAL_STEEL = 90, MATERIAL_GLASS = 90)

/obj/item/ammo_casing/a556
	caliber = CALIBER_556
	projectile_type = /obj/item/projectile/bullet/rifle/a556
	icon_state = "rifle-casing"
	spent_icon = "rifle-casing-spent"

/obj/item/ammo_casing/a145
	icon_state = "lcasing"
	spent_icon = "lcasing-spent"
	caliber = CALIBER_145
	projectile_type = /obj/item/projectile/bullet/rifle/a145
	matter = list(MATERIAL_STEEL = 1250)

/obj/item/ammo_casing/a145/apds
	caliber_bullet = CALIBER_BULLET_145_APDS
	projectile_type = /obj/item/projectile/bullet/rifle/a145/apds

/obj/item/ammo_casing/a762
	caliber = CALIBER_762
	projectile_type = /obj/item/projectile/bullet/rifle/a762
	icon_state = "rifle-casing"
	spent_icon = "rifle-casing-spent"

/obj/item/ammo_casing/a762/practice
	caliber_bullet = CALIBER_BULLET_PRACTICE
	projectile_type = /obj/item/projectile/bullet/rifle/a762/practice

/obj/item/ammo_casing/a792
	caliber = CALIBER_792
	projectile_type = /obj/item/projectile/bullet/rifle/a792
	icon_state = "rifle-casing"
	spent_icon = "rifle-casing-spent"

/obj/item/ammo_casing/rocket
	name = "rocket shell"
	desc = "A high explosive designed to be fired from a launcher."
	icon_state = "rocketshell"
	w_class = ITEM_SIZE_NORMAL
	projectile_type = /obj/item/missile
	caliber = CALIBER_ROCKET
	caliber_desc = FALSE

/obj/item/ammo_casing/cap
	caliber = CALIBER_TOY_CAPS
	color = "#ff0000"
	projectile_type = /obj/item/projectile/bullet/pistol/cap

// EMP ammo.
/obj/item/ammo_casing/c38/emp
	icon_state = "empcasing"
	caliber_bullet = CALIBER_BULLET_EMP
	projectile_type = /obj/item/projectile/ion/small
	matter = list(MATERIAL_STEEL = 130, MATERIAL_URANIUM = 100)

/obj/item/ammo_casing/c44/emp
	icon_state = "empcasing"
	caliber_bullet = CALIBER_BULLET_EMP
	projectile_type = /obj/item/projectile/ion/small
	matter = list(MATERIAL_STEEL = 130, MATERIAL_URANIUM = 100)

/obj/item/ammo_casing/c45/emp
	icon_state = "empcasing"
	caliber_bullet = CALIBER_BULLET_EMP
	projectile_type = /obj/item/projectile/ion/small
	matter = list(MATERIAL_STEEL = 130, MATERIAL_URANIUM = 100)

/obj/item/ammo_casing/a10mm/emp
	icon_state = "empcasing"
	caliber_bullet = CALIBER_BULLET_EMP
	projectile_type = /obj/item/projectile/ion/small
	matter = list(MATERIAL_STEEL = 130, MATERIAL_URANIUM = 100)

/obj/item/ammo_casing/shotgun/emp
	name = "haywire slug"
	desc = "A 12-gauge shotgun slug fitted with a single-use ion pulse generator."
	icon_state = "empshell"
	spent_icon = "empshell-spent"
	projectile_type  = /obj/item/projectile/ion
	matter = list(MATERIAL_STEEL = 260, MATERIAL_URANIUM = 200)

//TODO: '/obj/item/underwear' requires global refactor

/* New refactor order:
 1. Pull accessories (fingers, wrists, neck, etc.) out of underwear, make their own /obj/item/accessory type
	as they have minimal behavior and don't really need to be a subtype of clothing.
	Store in human.accessories and make helper procs to iterate over them and render.
	Basically current underwear system becomes accessories system.
	Accessories can be rendered on whatever layer they like, should define per item if they want to override
	the default, e.g. cross or aquila that is worn over space suit.
	Default layer for accessories is just above underwear layer.

 2. Make explicit slots under human defines for 4 underwear types: socks, top, bottom, undershirt.
	Put underwear in those slots, render on a signle unified underwear level.
	For equipping and unequipping underwear check the specific slot for occupancy.
	Make sure loadout system knows how to put underwear in the correct slots, currently
	all underwear is equipped through a single proc so this will need some refactoring.

 3. Change underwear type path to /obj/item/clothing/underwear.
	Semantically conflicts with /obj/item/clothing/under, but there's a TODO to change that to clothing/uniform.
	All procs that iterate over clothing were checked to not have any severe side effects for underwear becoming
	clothing. There are 2-3 instances where this is affected: operating table will start removing underwear too,
	temperature effect checks will also take underwear into account, and underwear may potentially affect armor,
	so all clothing vars like armor, thickness etc should be basically zero for underwear unless explicitly
	intended to have an effect. Most procs in the codebase iterate over specific slots instead of contents though,
	so if underwear is to become effective, additional checks for new slots will have to be added.

 4. After above steps are done, make underwear and accessories drop on limb cutoffs/gibs,
	can be triggered from /obj/item/organ/external/removed() proc on limbs.

	Hands/wrists:
	Accessories will have to check for fingers and rings slots. If they can choose side, anything equipped on the
	side where the limb is removed should drop.
	Worn accessories should no longer be able to swap sides if the opposite limb is missing, and should equip only
	to the present limb by default.

	Legs:
	Socks slot underwear should drop just like shoes and gloves do when any of the legs/feet are removed.
	This is an intended simplification for now. When there a system in place to render just one half of the clothing
	if another limb is missing, the check can be replaced to dropping on both limbs missing.

	Lower body:
	Same as socks, lower underwear should drop of lower body is removed.

 5. Final checks:
	- [ ] loadout offers correct selection of underwear clothing
	- [ ] /datum/category_collection/underwear correctly handles new type paths
	- [ ] loadout correctly renders accessories on their respective slots when previewing
	- [ ] accessories that are spawned at roundstart are automatically equipped to correct slots or placed in storage
	- [ ] underwear that is spawned at roundstart is automatically equipped to correct slots or placed in storage
	- [ ] /obj/structure/undies_wardrobe works correctly
	- [ ] committer of this refactoring is happy as they did a good job
*/
#define UNDERWEAR_SLOT_FREE       0

#define UNDERWEAR_SLOT_SOCKS      0x1
#define UNDERWEAR_SLOT_TOP        0x2
#define UNDERWEAR_SLOT_BOTTOM     0x4
#define UNDERWEAR_SLOT_UNDERSHIRT 0x8

#define UNDERWEAR_SLOT_L_WRIST    0x10
#define UNDERWEAR_SLOT_R_WRIST    0x20
#define UNDERWEAR_SLOT_NECK       0x40
#define UNDERWEAR_SLOT_WRISTS     (UNDERWEAR_SLOT_L_WRIST|UNDERWEAR_SLOT_R_WRIST)

/obj/item/underwear
	w_class = ITEM_SIZE_TINY
	icon = 'icons/inv_slots/hidden/icon.dmi'
	item_icons = list(
		slot_l_hand_str = 'icons/mob/inhands/clothing/hidden/hand_l_default.dmi',
		slot_r_hand_str = 'icons/mob/inhands/clothing/hidden/hand_r_default.dmi'
		)
	var/required_slot_flags
	var/required_free_body_parts
	var/mob_wear_layer = HO_UNDERWEAR_LAYER
	var/underwear_slot = UNDERWEAR_SLOT_FREE

/obj/item/underwear/afterattack(atom/target, mob/user, proximity)
	if(!proximity)
		return // Might as well check
	DelayedEquipUnderwear(user, target)

/obj/item/underwear/MouseDrop(atom/target)
	DelayedEquipUnderwear(usr, target)

/obj/item/underwear/proc/CanEquipUnderwear(mob/user, mob/living/carbon/human/H, silent = FALSE)
	if(!CanAdjustUnderwear(user, H, "put on"))
		return FALSE
	if(!(H.species && (H.species.species_appearance_flags & HAS_UNDERWEAR)))
		if(!silent)
			to_chat(user, SPAN("warning", "\The [H]'s species cannot wear underwear of this nature."))
		return FALSE

	for(var/obj/item/underwear/UW in H.worn_underwear)
		if(!UW.underwear_slot) // Yay, boundless underwear!
			if(UW.type == type) // ...but dare you not wear multiple instances of the same item.
				if(!silent)
					if(user == H)
						to_chat(user, SPAN("warning", "You are already wearing underwear of this nature."))
					else
						to_chat(user, SPAN("warning", "\The [H] is already wearing underwear of this nature."))
				return FALSE

			continue

		else if(UW.underwear_slot & underwear_slot)
			if(!silent)
				if(user == H)
					to_chat(user, SPAN("warning", "You are already wearing underwear of this nature."))
				else
					to_chat(user, SPAN("warning", "\The [H] is already wearing underwear of this nature."))
			return FALSE

	return TRUE

/obj/item/underwear/proc/CanRemoveUnderwear(mob/user, mob/living/carbon/human/H)
	if(!CanAdjustUnderwear(user, H, "remove"))
		return FALSE
	if(!(src in H.worn_underwear))
		to_chat(user, SPAN("warning", "\The [H] isn't wearing \the [src]."))
		return FALSE
	return TRUE

/obj/item/underwear/proc/CanAdjustUnderwear(mob/user, mob/living/carbon/human/H, adjustment_verb)
	if(!istype(H))
		return FALSE
	if(user != H && !CanPhysicallyInteractWith(user, H))
		return FALSE

	var/list/covering_items = H.get_covering_equipped_items(required_free_body_parts)
	if(covering_items.len)
		var/obj/item/I = covering_items[1]
		var/datum/gender/G = gender_datums[I.gender]
		if(adjustment_verb)
			to_chat(user, SPAN("warning", "Cannot [adjustment_verb] \the [src]. [english_list(covering_items)] [covering_items.len == 1 ? G.is : "are"] in the way."))
		return FALSE

	return TRUE

/obj/item/underwear/proc/DelayedRemoveUnderwear(mob/user, mob/living/carbon/human/H)
	if(!CanRemoveUnderwear(user, H))
		return
	if(user != H)
		visible_message(SPAN("danger", "\The [user] is trying to remove \the [H]'s [name]!"))
		if(!do_after(user, HUMAN_STRIP_DELAY, H))
			return FALSE
	. = RemoveUnderwear(user, H)
	if(. && user != H)
		user.visible_message(SPAN("warning", "\The [user] has removed \the [src] from \the [H]."), SPAN("notice", "You have removed \the [src] from \the [H]."))
		admin_attack_log(user, H, "Removed \a [src]", "Had \a [src] removed.", "removed \a [src] from")

/obj/item/underwear/proc/DelayedEquipUnderwear(mob/user, mob/living/carbon/human/H)
	if(!CanEquipUnderwear(user, H))
		return
	if(user != H)
		user.visible_message(SPAN("warning", "\The [user] has begun putting on \a [src] on \the [H]."), SPAN("notice", "You begin putting on \the [src] on \the [H]."))
		if(!do_after(user, HUMAN_STRIP_DELAY, H))
			return FALSE
	. = EquipUnderwear(user, H)
	if(. && user != H)
		user.visible_message(SPAN("warning", "\The [user] has put \the [src] on \the [H]."), SPAN("notice", "You have put \the [src] on \the [H]."))
		admin_attack_log(user, H, "Put on \a [src]", "Had \a [src] put on.", "put on \a [src] on")

/obj/item/underwear/proc/EquipUnderwear(mob/user, mob/living/carbon/human/H)
	if(!CanEquipUnderwear(user, H))
		return FALSE
	if(!user.drop(src))
		return FALSE
	return ForceEquipUnderwear(H)

/obj/item/underwear/proc/ForceEquipUnderwear(mob/living/carbon/human/H, update_icons = TRUE)
	// No matter how forceful, we still don't allow multiples of the same underwear type
	for(var/obj/item/underwear/UW in H.worn_underwear)
		if(!UW.underwear_slot) // Yay, boundless underwear!
			if(UW.type == type) // ...but dare you not wear multiple instances of the same item.
				return FALSE
			continue
		else if(UW.underwear_slot & underwear_slot)
			return FALSE

	H.worn_underwear += src
	forceMove(H)

	if(update_icons)
		H.update_underwear()

	return TRUE

/obj/item/underwear/proc/RemoveUnderwear(mob/user, mob/living/carbon/human/H)
	if(!CanRemoveUnderwear(user, H))
		return FALSE

	H.worn_underwear -= src
	user.pick_or_drop(src)
	H.update_underwear()

	return TRUE

/obj/item/underwear/verb/RemoveSocks()
	set name = "Remove Underwear"
	set category = "Object"
	set src in usr

	RemoveUnderwear(usr, usr)

/obj/item/underwear/socks
	required_free_body_parts = FEET
	underwear_slot = UNDERWEAR_SLOT_SOCKS

/obj/item/underwear/top
	required_free_body_parts = UPPER_TORSO
	underwear_slot = UNDERWEAR_SLOT_TOP

/obj/item/underwear/bottom
	required_free_body_parts = FEET|LEGS|LOWER_TORSO
	underwear_slot = UNDERWEAR_SLOT_BOTTOM

/obj/item/underwear/undershirt
	required_free_body_parts = UPPER_TORSO
	underwear_slot = UNDERWEAR_SLOT_UNDERSHIRT

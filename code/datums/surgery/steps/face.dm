#define FACE_SPEED_MOFIFIER 1.25

/**
 * Generic face surgry step, does nothing.
 */
/datum/surgery_step/face
	priority = 2

/datum/surgery_step/face/check_zone(mob/living/carbon/human/target, target_zone)
	return (..() && target_zone == BP_MOUTH)

/datum/surgery_step/face/check_parent_organ(obj/item/organ/external/parent_organ, mob/living/carbon/human/target, obj/item/tool, atom/user)
	. = ..()
	if(!.)
		return

	if(BP_IS_ROBOTIC(parent_organ))
		return FALSE

	return !parent_organ.is_stump()

/**
 * Facial tissue cutting step.
 */
/datum/surgery_step/face/cut_face
	duration = CUT_DURATION * FACE_SPEED_MOFIFIER

	allowed_tools = list(
		/obj/item/scalpel = 100,
		/obj/item/material/knife = 75,
		/obj/item/material/shard = 50
		)

	preop_sound = 'sound/surgery/scalpel1.ogg'
	success_sound = 'sound/surgery/scalpel2.ogg'
	failure_sound = 'sound/weapons/bladeslice.ogg'

/datum/surgery_step/face/cut_face/check_parent_organ(obj/item/organ/external/parent_organ, mob/living/carbon/human/target, obj/item/tool, atom/user)
	return target.surgery_status.face == 0

/datum/surgery_step/face/cut_face/initiate(obj/item/organ/external/parent_organ, obj/item/organ/target_organ, mob/living/carbon/human/target, obj/item/tool, mob/user)
	announce_preop(user,
		"[user] starts to cut open [target]'s face and neck with \the [tool].",
		"You start to cut open [target]'s face and neck with \the [tool]."
		)
	return ..()

/datum/surgery_step/face/cut_face/success(obj/item/organ/external/parent_organ, obj/item/organ/target_organ, mob/living/carbon/human/target, obj/item/tool, mob/user)
	announce_success(user,
		"[user] has cut open [target]'s face and neck with \the [tool].",
		"You have cut open [target]'s face and neck with \the [tool]."
		)
	target.surgery_status.face = 1

/datum/surgery_step/face/cut_face/failure(obj/item/organ/external/parent_organ, obj/item/organ/target_organ, mob/living/carbon/human/target, obj/item/tool, mob/user)
	announce_failure(user,
		"[user]'s hand slips, slicing [target]'s throat wth \the [tool]!",
		"Your hand slips, slicing [target]'s throat wth \the [tool]!"
		)
	parent_organ.take_external_damage(
		40,
		0,
		(DAM_SHARP|DAM_EDGE),
		used_weapon = tool
		)
	target.losebreath += 10

/**
 * Vaocal mending step.
 */
/datum/surgery_step/face/mend_vocal
	duration = CLAMP_DURATION * FACE_SPEED_MOFIFIER

	allowed_tools = list(
		/obj/item/hemostat = 100,
		/obj/item/stack/cable_coil = 75,
		/obj/item/device/assembly/mousetrap = 10
		)

	preop_sound = 'sound/surgery/hemostat1.ogg'
	success_sound = 'sound/surgery/hemostat.ogg'
	failure_sound = 'sound/surgery/hatchet.ogg'

/datum/surgery_step/face/mend_vocal/check_parent_organ(obj/item/organ/external/parent_organ, mob/living/carbon/human/target, obj/item/tool, atom/user)
	return (..() && target.surgery_status.face == 1)

/datum/surgery_step/face/mend_vocal/initiate(obj/item/organ/external/parent_organ, obj/item/organ/target_organ, mob/living/carbon/human/target, obj/item/tool, mob/user)
	announce_preop(user,
		"[user] starts mending [target]'s vocal cords with \the [tool].",
		"You start mending [target]'s vocal cords with \the [tool]."
		)
	return ..()

/datum/surgery_step/face/mend_vocal/success(obj/item/organ/external/parent_organ, obj/item/organ/target_organ, mob/living/carbon/human/target, obj/item/tool, mob/user)
	announce_success(user,
		"[user] mends [target]'s vocal cords with \the [tool].",
		"You mend [target]'s vocal cords with \the [tool]."
		)
	target.surgery_status.face = 2

/datum/surgery_step/face/mend_vocal/failure(obj/item/organ/external/parent_organ, obj/item/organ/target_organ, mob/living/carbon/human/target, obj/item/tool, mob/user)
	announce_failure(user,
		"[user]'s hand slips, clamping [target]'s trachea shut for a moment with \the [tool]!",
		"Your hand slips, clamping [user]'s trachea shut for a moment with \the [tool]!"
		)
	target.losebreath += 10

/**
 * Facial reconstruction step.
 */
/datum/surgery_step/face/fix_face
	duration = RETRACT_DURATION * 1.25

	allowed_tools = list(
		/obj/item/retractor = 100,
		/obj/item/crowbar = 55,
		/obj/item/material/kitchen/utensil/fork = 75
		)

	preop_sound = 'sound/surgery/retractor1.ogg'
	success_sound = 'sound/surgery/retractor.ogg'
	failure_sound = 'sound/weapons/bladeslice.ogg'

/datum/surgery_step/face/fix_face/check_parent_organ(obj/item/organ/external/parent_organ, mob/living/carbon/human/target, obj/item/tool, atom/user)
	return (..() && target.surgery_status.face == 2)

/datum/surgery_step/face/fix_face/initiate(obj/item/organ/external/parent_organ, obj/item/organ/target_organ, mob/living/carbon/human/target, obj/item/tool, mob/user)
	announce_preop(user,
		"[user] starts pulling the skin on [target]'s face back in place with \the [tool].",
		"You start pulling the skin on [target]'s face back in place with \the [tool].")
	return ..()

/datum/surgery_step/face/fix_face/success(obj/item/organ/external/parent_organ, obj/item/organ/target_organ, mob/living/carbon/human/target, obj/item/tool, mob/user)
	announce_success(user,
		"[user] pulls the skin on [target]'s face back in place with \the [tool].",
		"You pull the skin on [target]'s face back in place with \the [tool]."
		)
	target.surgery_status.face = 3

/datum/surgery_step/face/fix_face/failure(obj/item/organ/external/parent_organ, obj/item/organ/target_organ, mob/living/carbon/human/target, obj/item/tool, mob/user)
	announce_failure(user,
		"[user]'s hand slips, tearing skin on [target]'s face with \the [tool]!",
		"Your hand slips, tearing skin on [target]'s face with \the [tool]!"
		)
	parent_organ.take_external_damage(
		10,
		0,
		(DAM_SHARP|DAM_EDGE),
		used_weapon = tool
		)

/**
 * Facial cauterization step.
 */
/datum/surgery_step/face/cauterize
	duration = CAUTERIZE_DURATION * FACE_SPEED_MOFIFIER

	allowed_tools = list(
		/obj/item/cautery = 100,
		/obj/item/clothing/mask/smokable/cigarette = 75,
		/obj/item/flame/lighter = 50,
		/obj/item/weldingtool = 25,
		/obj/item/hothands = 20
		)

	preop_sound = 'sound/surgery/cautery1.ogg'
	success_sound = 'sound/surgery/cautery2.ogg'
	failure_sound = 'sound/surgery/cautery.ogg'

/datum/surgery_step/face/cauterize/check_parent_organ(obj/item/organ/external/parent_organ, mob/living/carbon/human/target, obj/item/tool, atom/user)
	return (..() && target.surgery_status.face > 0)

/datum/surgery_step/face/cauterize/initiate(obj/item/organ/external/parent_organ, obj/item/organ/target_organ, mob/living/carbon/human/target, obj/item/tool, mob/user)
	announce_preop(user,
		"[user] is beginning to cauterize the incision on [target]'s face and neck with \the [tool].",
		"You are beginning to cauterize the incision on [target]'s face and neck with \the [tool]."
		)
	return ..()

/datum/surgery_step/face/cauterize/success(obj/item/organ/external/parent_organ, obj/item/organ/target_organ, mob/living/carbon/human/target, obj/item/tool, mob/user)
	announce_success(user,
		"[user] cauterizes the incision on [target]'s face and neck with \the [tool].",
		"You cauterize the incision on [target]'s face and neck with \the [tool]."
		)
	if(target.surgery_status.face == 3)
		var/obj/item/organ/external/head/H = parent_organ
		H.status &= ~ORGAN_DISFIGURED
		H.deformities = 0
	target.surgery_status.face = 0
	target.update_deformities()

/datum/surgery_step/face/cauterize/failure(obj/item/organ/external/parent_organ, obj/item/organ/target_organ, mob/living/carbon/human/target, obj/item/tool, mob/user)
	announce_failure(user,
		"[user]'s hand slips, leaving a small burn on [target]'s face with \the [tool]!",
		"Your hand slips, leaving a small burn on [target]'s face with \the [tool]!"
		)
	parent_organ.take_external_damage(0, 4, used_weapon = tool)

/**
 * Tooth insertion starting step
 */
/datum/surgery_step/face/drill_jaw
	duration = DRILL_DURATION * FACE_SPEED_MOFIFIER

	allowed_tools = list(
		/obj/item/surgicaldrill = 100,
		/obj/item/screwdriver = 50
		)

	preop_sound = list(
		/obj/item/surgicaldrill = 'sound/surgery/surgicaldrill.ogg',
		/obj/item/screwdriver = 'sound/effects/fighting/crunch1.ogg'
	)
	success_sound = 'sound/surgery/organ2.ogg'
	failure_sound = 'sound/effects/fighting/crunch2.ogg'

/datum/surgery_step/face/drill_jaw/check_parent_organ(obj/item/organ/external/parent_organ, mob/living/carbon/human/target, obj/item/tool, atom/user)
	return (..() && target.surgery_status.jaw == 0)

/datum/surgery_step/face/drill_jaw/initiate(obj/item/organ/external/parent_organ, obj/item/organ/target_organ, mob/living/carbon/human/target, obj/item/tool, mob/user)
	var/obj/item/organ/external/head/H = parent_organ
	if(H.get_teeth() >= H.max_teeth)
		to_chat(user, SPAN_NOTICE("There is no more space for another one tooth"))
		return

	announce_preop(user,
		"[user] starts to drill [target]'s jaw bones with \the [tool].",
		"You start to drill [target]'s jaw bones with \the [tool]."
		)

	target.custom_pain(
		"The pain in your mouth is living hell!",
		1,
		affecting = target_organ
		)
	return ..()

/datum/surgery_step/face/drill_jaw/success(obj/item/organ/external/parent_organ, obj/item/organ/target_organ, mob/living/carbon/human/target, obj/item/tool, mob/user)
	announce_success(user,
		"[user] makes some space for tooth in [target]'s jaw with \the [tool].",
		"You make some space for tooth in [target]'s jaw with \the [tool]."
		)
	target.surgery_status.jaw = 1

/datum/surgery_step/face/drill_jaw/failure(obj/item/organ/external/parent_organ, obj/item/organ/target_organ, mob/living/carbon/human/target, obj/item/tool, mob/user)
	announce_failure(user,
		"[user]'s hand slips, scraping around inside [target]'s mouth with \the [tool]!",
		"Your hand slips, scraping around inside [target]'s mouth with \the [tool]!"
		)
	parent_organ.take_external_damage(
		40,
		0,
		(DAM_SHARP|DAM_EDGE),
		used_weapon = tool
		)
	target.losebreath += 10

/**
 * Inserting tooth
 */
/datum/surgery_step/face/insert_tooth
	duration = ATTACH_DURATION * FACE_SPEED_MOFIFIER

	allowed_tools = list(
		/obj/item/stack/teeth = 100
		)

	preop_sound = 'sound/surgery/organ1.ogg'
	success_sound = 'sound/effects/squelch1.ogg'
	failure_sound = 'sound/effects/fighting/crunch1.ogg'

/datum/surgery_step/face/insert_tooth/check_parent_organ(obj/item/organ/external/parent_organ, mob/living/carbon/human/target, obj/item/tool, atom/user)
	return (..() && target.surgery_status.jaw == 1)

/datum/surgery_step/face/insert_tooth/initiate(obj/item/organ/external/parent_organ, obj/item/organ/target_organ, mob/living/carbon/human/target, obj/item/tool, mob/user)
	if(!istype(tool, target.species.teeth_type))
		to_chat(user, SPAN_NOTICE("A tooth of this kind won't fit here."))
		return

	announce_preop(user,
		"[user] starts inserting \the [tool] inside [target]'s jaw.",
		"You start inserting \the [tool] inside [target]'s jaw."
		)
	target.custom_pain(
		"The pain in your mouth is living hell!",
		1,
		affecting = parent_organ
		)
	return ..()

/datum/surgery_step/face/insert_tooth/success(obj/item/organ/external/parent_organ, obj/item/organ/target_organ, mob/living/carbon/human/target, obj/item/tool, mob/user)
	var/obj/item/organ/external/head/H = parent_organ
	var/obj/item/stack/teeth/T = tool

	if(!H.teeth_list.len)
		var/obj/item/stack/teeth/new_tooth = T.split(1)
		H.teeth_list += new_tooth
		H.contents += new_tooth
	else
		var/success = FALSE
		for(var/obj/item/stack/teeth/current_teeth in H.teeth_list)
			if(success)
				break
			if(!current_teeth.add(1))
				continue
			T.use(1)
			success = TRUE

	announce_success(user,
		"[user] inserts \the [tool] inside [target]'s jaw.",
		"You insert \the [tool] inside [target]'s jaw."
		)
	target.surgery_status.jaw = 0

/datum/surgery_step/face/insert_tooth/failure(obj/item/organ/external/parent_organ, obj/item/organ/target_organ, mob/living/carbon/human/target, obj/item/tool, mob/user)
	announce_failure(user,
		"[user]'s hand slips, scraping around inside [target]'s mouth with \the [tool]!",
		"Your hand slips, scraping around inside [target]'s mouth with \the [tool]!"
		)
	parent_organ.take_external_damage(
		20,
		0,
		(DAM_SHARP|DAM_EDGE),
		used_weapon = tool
		)

#undef FACE_SPEED_MOFIFIER

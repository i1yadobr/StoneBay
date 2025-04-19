/datum/emote/synth/beep
	key = "beep"

	message_1p = "You beep."
	message_3p = "beeps."

	message_impaired_production = "makes a weak noise."
	message_impaired_reception = "flickers."

	message_miming = "makes synth noises."
	message_muzzled = "makes a weak noise."

	message_type = AUDIBLE_MESSAGE

	sound = 'sound/signals/ping7.ogg'

	state_checks = EMOTE_CHECK_CONSCIOUS | EMOTE_CHECK_IS_SYNTH_OR_ROBOT

	statpanel_proc = /mob/living/proc/beep_emote

/mob/living/proc/beep_emote()
	set name = "Beep"
	set category = "Emotes"
	emote("beep", intentional = TRUE)


/datum/emote/synth/ping
	key = "ping"

	message_1p = "You ping."
	message_3p = "pings."

	message_impaired_production = "makes a weak noise."
	message_impaired_reception = "flickers."

	message_miming = "makes synth noises."
	message_muzzled = "makes a weak noise."

	message_type = AUDIBLE_MESSAGE

	sound = 'sound/signals/ping1.ogg'

	state_checks = EMOTE_CHECK_CONSCIOUS | EMOTE_CHECK_IS_SYNTH_OR_ROBOT

	statpanel_proc = /mob/living/proc/ping_emote

/mob/living/proc/ping_emote()
	set name = "Ping"
	set category = "Emotes"
	emote("ping", intentional = TRUE)


/datum/emote/synth/buzz
	key = "buzz"

	message_1p = "You buzz."
	message_3p = "buzzes."

	message_impaired_production = "makes a weak noise."
	message_impaired_reception = "flickers."

	message_miming = "makes synth noises."
	message_muzzled = "makes a weak noise."

	message_type = AUDIBLE_MESSAGE

	sound = 'sound/signals/warning2.ogg'

	state_checks = EMOTE_CHECK_CONSCIOUS | EMOTE_CHECK_IS_SYNTH_OR_ROBOT

	statpanel_proc = /mob/living/proc/buzz_emote

/mob/living/proc/buzz_emote()
	set name = "Buzz"
	set category = "Emotes"
	emote("buzz", intentional = TRUE)


/datum/emote/synth/deny
	key = "deny"

	message_1p = "You emit a negative blip."
	message_3p = "emits a negative blip."

	message_impaired_production = "makes a weak noise."
	message_impaired_reception = "flickers."

	message_miming = "makes synth noises."
	message_muzzled = "makes a weak noise."

	message_type = AUDIBLE_MESSAGE

	sound = 'sound/signals/warning7.ogg'

	state_checks = EMOTE_CHECK_CONSCIOUS | EMOTE_CHECK_IS_SYNTH_OR_ROBOT

	statpanel_proc = /mob/living/proc/deny_emote

/mob/living/proc/deny_emote()
	set name = "Deny"
	set category = "Emotes"
	emote("deny", intentional = TRUE)


/datum/emote/synth/confirm
	key = "confirm"

	message_1p = "You emit an affirmative blip."
	message_3p = "emits an affirmative blip."

	message_impaired_production = "makes a weak noise."
	message_impaired_reception = "flickers."

	message_miming = "makes synth noises."
	message_muzzled = "makes a weak noise."

	message_type = AUDIBLE_MESSAGE

	sound = 'sound/signals/ping5.ogg'

	state_checks = EMOTE_CHECK_CONSCIOUS | EMOTE_CHECK_IS_SYNTH_OR_ROBOT

	statpanel_proc = /mob/living/proc/confirm_emote

/mob/living/proc/confirm_emote()
	set name = "Confirm"
	set category = "Emotes"
	emote("confirm", intentional = TRUE)


/datum/emote/synth/law
	key = "law"

	message_1p = "You show your legal authorization barcode."
	message_3p = "shows it's legal authorization barcode."

	message_impaired_production = "makes a noise."
	message_impaired_reception = "flickers."

	message_miming = "makes synth noises."
	message_muzzled = "makes a noise."

	message_type = AUDIBLE_MESSAGE

	sound = 'sound/voice/biamthelaw.ogg'

	state_checks = EMOTE_CHECK_CONSCIOUS | EMOTE_CHECK_ROBOT_SEC_MODULE

	statpanel_proc = /mob/living/proc/law_emote

/mob/living/proc/law_emote()
	set name = "Law"
	set category = "Emotes"
	emote("law", intentional = TRUE)


/datum/emote/synth/halt
	key = "halt"

	message_1p = "You skreech with your speakers, \"Halt! Security!\""
	message_3p = "skreeches with it's skeapers, \"Halt! Security!\""

	message_impaired_production = "makes a loud noise."
	message_impaired_reception = "flickers with red."

	message_miming = "makes loud synth noises."
	message_muzzled = "makes a loud noise."

	message_type = AUDIBLE_MESSAGE

	sound = 'sound/voice/halt.ogg'

	state_checks = EMOTE_CHECK_CONSCIOUS | EMOTE_CHECK_ROBOT_SEC_MODULE

	statpanel_proc = /mob/living/proc/halt_emote

/mob/living/proc/halt_emote()
	set name = "Halt"
	set category = "Emotes"
	emote("halt", intentional = TRUE)

/datum/emote/synth/meow
	key = "meow"

	message_1p = "You meowed happily."
	message_3p = "meowed happily."

	message_impaired_production = "makes a noise."
	message_impaired_reception = "flickers."

	message_miming = "makes synth noises."
	message_muzzled = "makes a noise."

	message_type = AUDIBLE_MESSAGE

	sound = SFX_KERFUR_MEOW

	cooldown = 3 SECONDS

	state_checks = EMOTE_CHECK_CONSCIOUS

	statpanel_proc = /mob/living/proc/meow_emote

/datum/emote/synth/meow/can_emote(mob/user, intentional)
	if(!has_robot_module_hull("Kerfur", user, intentional) && !has_robot_module_hull("Kerfur-O", user, intentional))
		if(intentional)
			to_chat(user, SPAN_NOTICE("You do not have the required hull for this emote."))
		return FALSE

	return ..()

/datum/emote/synth/meow/do_emote(mob/user, emote_key, intentional)
	. = ..()
	INVOKE_ASYNC(src, nameof(.proc/meow_emote_animation), user)

#define EMOTE_TIMER 20

/datum/emote/synth/meow/proc/meow_emote_animation(mob/user)
	var/mob/living/silicon/robot/R = user
	var/icon_state_ea = R.module_hulls[R.icontype].icon_state_ea
	var/animation_ea = "[R.module_hulls[R.icontype].icon_state_ea]-meow"

	R.CutOverlays(emissive_appearance(R.icon, R.module_hulls[R.icontype].icon_state_ea))
	R.AddOverlays(emissive_appearance(R.icon, "[R.module_hulls[R.icontype].icon_state_ea]-meow"))
	R.ImmediateOverlayUpdate()
	flick("[R.module_hulls[R.icontype].icon_state]-meow", R)
	R.set_next_think_ctx("meow", world.time + EMOTE_TIMER)

#undef EMOTE_TIMER

/mob/living/proc/meow_emote()
	set name = "Meow"
	set category = "Emotes"
	emote("meow", intentional = TRUE)

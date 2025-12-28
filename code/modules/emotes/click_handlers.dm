/datum/click_handler/emotes/target_emote
	handler_name = "Target emote"

/datum/click_handler/emotes/target_emote/OnClick(atom/target)
	user.prepare_target_emote(target, parameters)
	user.PopClickHandler()
	return

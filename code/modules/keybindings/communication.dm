/datum/keybinding/client/communication
	category = CATEGORY_COMMUNICATION

/datum/keybinding/client/communication/say
	hotkey_keys = list("T", "F3")
	name = "say"
	full_name = "IC Say"

/datum/keybinding/client/communication/say/down(client/user)
	user.mob.say_wrapper()
	return TRUE

/datum/keybinding/client/communication/ooc
	hotkey_keys = list("O", "F2")
	name = "ooc"
	full_name = "Out Of Character Say (OOC)"

/datum/keybinding/client/communication/ooc/down(client/user)
	user.ooc()
	return TRUE

/datum/keybinding/client/communication/looc
	hotkey_keys = list("L")
	name = "looc"
	full_name = "Local Out Of Character Say (LOOC)"

/datum/keybinding/client/communication/looc/down(client/user)
	user.looc()
	return TRUE

/datum/keybinding/client/communication/me
	hotkey_keys = list("M", "F4")
	name = "me"
	full_name = "Emote"

/datum/keybinding/client/communication/me/down(client/user)
	user.mob.me_wrapper()
	return TRUE

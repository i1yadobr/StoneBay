/datum/keybinding/movement
	category = CATEGORY_MOVEMENT

/datum/keybinding/movement/north
	hotkey_keys = list("W", "North")
	name = "north"
	full_name = "Move North"
	description = "Moves your character north"

/datum/keybinding/movement/south
	hotkey_keys = list("S", "South")
	name = "south"
	full_name = "Move South"
	description = "Moves your character south"

/datum/keybinding/movement/west
	hotkey_keys = list("A", "West")
	name = "west"
	full_name = "Move West"
	description = "Moves your character left"

/datum/keybinding/movement/east
	hotkey_keys = list("D", "East")
	name = "east"
	full_name = "Move East"
	description = "Moves your character east"

/datum/keybinding/movement/prevent_movement
	hotkey_keys = list("Ctrl")
	name = "block_movement"
	full_name = "Block movement"
	description = "Prevents you from moving"

/datum/keybinding/movement/prevent_movement/down(client/user)
	user.movement_locked = TRUE
	return TRUE

/datum/keybinding/movement/prevent_movement/up(client/user)
	user.movement_locked = FALSE
	return TRUE

/datum/keybinding/movement/move_up
	hotkey_keys = list(",")
	name = "move_up"
	full_name = "Move Up"
	description = "Makes you go up"

/datum/keybinding/movement/move_up/down(client/user)
	user.mob.up()
	return TRUE

/datum/keybinding/movement/move_down
	hotkey_keys = list(".")
	name = "move_down"
	full_name = "Move Down"
	description = "Makes you go down"

/datum/keybinding/movement/move_down/down(client/user)
	user.mob.down()
	return TRUE

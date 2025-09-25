#define MODEFLAG_TERMINAL_ACCOUNT "ACCOUNT"
#define MODEFLAG_TERMINAL_AMOUNT "AMOUNT"
#define MODEFLAG_TERMINAL_PIN "PIN"

/obj/item/device/payment_terminal
	name = "Terminal NanoTrasen Payment"
	desc = "Advanced terminal for financial transactions. Supports direct card payments."
	icon = 'icons/obj/device.dmi'
	icon_state = "paypos"
	var/machine_id
	var/machine_name
	var/mode = MODEFLAG_TERMINAL_AMOUNT
	var/datum/money_account/linked_account
	var/input_price
	var/input_pin
	var/input_account
	var/account_paying
	var/emag_tax = 0
	var/static/image/price_overlay = image(icon = 'icons/obj/device.dmi', icon_state = "paypos_price")
	maptext_y = 25
	maptext_width = 40
	maptext_x = -3

/obj/item/device/payment_terminal/AIAltClick(mob/user)
	interact_mode_account(user)

/obj/item/device/payment_terminal/attack_ai(mob/user)
	interact_mode_amount(user)

/obj/item/device/payment_terminal/BorgAltClick(mob/user)
	interact_mode_account(user)

/obj/item/device/payment_terminal/attack_robot(mob/user)
	interact_mode_amount(user)

/obj/item/device/payment_terminal/attack_hand(mob/user)
	if(user.a_intent != I_GRAB)
		interact_mode_amount(user)
	else
		if(!anchored)
			set_mode(MODEFLAG_TERMINAL_ACCOUNT, user)
			SStgui.update_uis(src)
			dir = SOUTH
			..()
		else
			to_chat(user, SPAN_WARNING("[src] is secured."))
			dir = reverse_direction(user.dir)

/obj/item/device/payment_terminal/proc/interact_mode_amount(mob/user)
	set_mode(MODEFLAG_TERMINAL_AMOUNT, user)
	tgui_interact(user)

/obj/item/device/payment_terminal/proc/interact_mode_account(mob/user)
	set_mode(MODEFLAG_TERMINAL_ACCOUNT, user)
	tgui_interact(user)

/obj/item/device/payment_terminal/attackby(obj/item/W, mob/user)
	if(isWrench(W) && isturf(src.loc))
		playsound(src.loc, 'sound/items/Ratchet.ogg', 30)
		anchored = !anchored
		if (!anchored)
			to_chat(user, SPAN_INFO("[src] can now be moved."))
		else
			to_chat(user, SPAN_WARNING("[src] is now secured."))
		return
		
	..()

	var/obj/item/card/id/I = W.get_id_card()
	if(I)
		if(src.loc == user)
			input_account = I.associated_account_number
			set_new_account(user)
		else
			if(isnull(input_price) || input_price <= 0)
				return
			if(!process_payment(I.associated_account_number, user))
				playsound(src, SFX_USE_TERMINAL_DENY, 70)
		return

	return ..()

/obj/item/device/payment_terminal/attack_self(mob/user)
	interact_mode_account(user)

/obj/item/device/payment_terminal/update_icon()
	. = ..()
	ClearOverlays()
	if(isnull(linked_account) || input_price <= 0)
		maptext = null
		set_light(0)
	else
		AddOverlays(price_overlay)
		set_light(0.2, 0.5, 0.8, 1.1, "#3a9100")
		maptext = MAPTEXT("<div style=\"font-size: 7px; color: #00AA00; text-shadow: 0 0 5px #00FF00, 0 0 8px #00FF00; font-family: 'Courier New', Courier, monospace; text-align: center; -dm-text-outline: 1px #008a0077;\">[input_price]C</div>")

/obj/item/device/payment_terminal/proc/set_mode(new_mode, mob/user)
	input_pin = null
	if(!isnull(linked_account))
		input_account = linked_account.account_number
	if(new_mode != mode)
		mode = new_mode
		for(var/datum/tgui/ui in SStgui.open_uis)
			if(ui.src_object == src && ui.user != user)
				ui.close()

/obj/item/device/payment_terminal/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "PaymentTerminal")
		ui.open()

/obj/item/device/payment_terminal/tgui_data(mob/user)
	var/list/data = list()
	data["display"] = get_temp_message()
	data["status"] = get_status_message()
	data["title"] = isnull(machine_id) ? name : machine_id
	data["mode"] = mode
	return data

/obj/item/device/payment_terminal/proc/clear_input(mob/user)
	switch(mode)
		if(MODEFLAG_TERMINAL_ACCOUNT)
			linked_account = null
			input_account = null
			set_new_account(user)
		if(MODEFLAG_TERMINAL_AMOUNT)
			input_price = null
		if(MODEFLAG_TERMINAL_PIN)
			input_pin = null

/obj/item/device/payment_terminal/proc/input_num(value)
	switch(mode)
		if(MODEFLAG_TERMINAL_AMOUNT)
			input_price = sanitize_num(input_price, 7) * 10 + value
		if(MODEFLAG_TERMINAL_ACCOUNT)
			input_account = sanitize_num(input_account, 6) * 10 + value
		if(MODEFLAG_TERMINAL_PIN)
			input_pin = sanitize_num(input_pin, 4) * 10 + value

/obj/item/device/payment_terminal/proc/sanitize_num(value, max_len)
	var/input = "[value]"
	if (length(input) >= max_len)
		return text2num(copytext("[input]", 2))
	return value

/obj/item/device/payment_terminal/proc/get_temp_message()
	switch(mode)
		if(MODEFLAG_TERMINAL_AMOUNT)
			return "[input_price]"
		if(MODEFLAG_TERMINAL_ACCOUNT)
			return "[input_account]"
		if(MODEFLAG_TERMINAL_PIN)
			return repeat_string(length("[input_pin]"), "*")

/obj/item/device/payment_terminal/proc/input_enter(mob/user)
	switch(mode)
		if(MODEFLAG_TERMINAL_ACCOUNT)
			set_new_account(user)
		if(MODEFLAG_TERMINAL_PIN)
			if(!process_payment(account_paying, user))
				playsound(src, SFX_USE_TERMINAL_DENY, 70)

	for(var/datum/tgui/ui in SStgui.open_uis)
		if(ui.src_object == src && ui.user == user)
			ui.close()

/obj/item/device/payment_terminal/proc/set_new_account(mob/user)
	var/datum/money_account/D = get_account(input_account)
	if(D)
		to_chat(user, SPAN_INFO("[src] is set new account."))
		linked_account = D
		playsound(src, SFX_USE_TERMINAL_ACCESS, 70)
	else
		to_chat(user, SPAN_WARNING("[src] is reset account."))
		linked_account = null
		input_account = null
		playsound(src, SFX_USE_TERMINAL_DENY, 70)
	update_icon()
	generate_machine_id()
	SStgui.update_uis(src)

/obj/item/device/payment_terminal/proc/generate_machine_id()
	if(isnull(linked_account))
		machine_id = name
		machine_name = name
	else if(emag_tax > 0)
		var/first = pick(GLOB.first_parts_name_terminal)
		var/second = pick(GLOB.second_parts_name_terminal)
		machine_name = "[first] [second]"
		machine_id = "Terminal [machine_name]"
	else
		machine_name = "[linked_account.account_number]"
		machine_id = "Terminal #[machine_name]"

/obj/item/device/payment_terminal/tgui_act(action, params)
	. = ..()
	if(.)
		return TRUE

	playsound(src, SFX_PIP_TERMINAL, 40)
	switch(action)
		if("press")
			var/value = params["value"]
			if(isnum(value))
				input_num(value)
		if("submit")
			input_enter(usr)
		if("clear")
			clear_input(usr)
	update_icon()
	return TRUE

/obj/item/device/payment_terminal/proc/get_status_message()
	switch(mode)
		if(MODEFLAG_TERMINAL_AMOUNT)
			return "Enter amount (C)"
		if(MODEFLAG_TERMINAL_PIN)
			return "Enter PIN"
		if(MODEFLAG_TERMINAL_ACCOUNT)
			return "Enter account #"
	return "Not ready"

/obj/item/device/payment_terminal/proc/process_payment(account_number, mob/user)
	if(!linked_account)
		visible_message(SPAN_WARNING("\icon[src] \The [src] displayed: The account is not linked."))
		return FALSE

	if(!account_number)
		visible_message(SPAN_WARNING("\icon[src] \The [src] displayed: Account number not found on chip."))
		return FALSE

	account_paying = account_number
	var/datum/money_account/customer_account = get_account(account_paying)
	if(isnull(customer_account))
		visible_message(SPAN_WARNING("\icon[src] \The [src] displayed: Account number not found in NT system."))
		account_paying = null
		return FALSE

	if(customer_account.security_level != 0)
		if(isnull(input_pin))
			set_mode(MODEFLAG_TERMINAL_PIN, user)
			tgui_interact(user)
			return TRUE
		else
			customer_account = attempt_account_access(account_paying, input_pin, 2)
			if(!customer_account)
				visible_message(SPAN_WARNING("\icon[src] \The [src] displayed: Unable to access account, incorrect credentials."))
				input_pin = null
				if(!process_payment(account_paying, user))
					playsound(src, SFX_USE_TERMINAL_DENY, 70)
				return FALSE

	var/correct_amout = input_price + round(input_price * emag_tax / 100)
	if(customer_account.money < correct_amout)
		visible_message(SPAN_WARNING("\icon[src] \The [src] displayed: Insufficient funds."))
		account_paying = null
		return FALSE

	var/datum/transaction/T = new(
		"[emag_tax > 0 ? machine_name : linked_account.owner_name]",
		"Transfer of funds",
		-correct_amout,
		machine_id
	)
	customer_account.do_transaction(T)

	T = new(
		"[emag_tax > 0 ? machine_name : customer_account.owner_name]",
		"Transfer of funds",
		correct_amout,
		machine_id
	)
	linked_account.do_transaction(T)

	account_paying = null
	input_pin = null
	playsound(src, 'sound/items/payment/chek.ogg', 70)
	print_receipt(input_price, customer_account, linked_account)
	visible_message(SPAN_INFO("\icon[src] \The [src] chimes."))
	return TRUE

/obj/item/device/payment_terminal/proc/print_receipt(amount, datum/money_account/sender, datum/money_account/receiver)
	var/obj/item/paper/receipt = new()

	var/receipt_text = "<center><b>NanoTrasen Banking Division</b></center><hr>"
	receipt_text += "<b>Machine:</b> [machine_id]<br>"
	receipt_text += "<b>Date:</b> [stationdate2text()] [stationtime2text()]<br><hr>"
	receipt_text += "<b>From:</b> [sender.account_number]<br>"
	receipt_text += "<b>To:</b> [emag_tax > 0 ? machine_id : receiver.account_number]<br><hr>"
	receipt_text += "<b>Amount:</b> [amount] credit[amount != 1 ? "s" : ""]<br>"

	receipt_text += "<small>Thank you for choosing NanoTrasen!</small>"

	receipt.name = "receipt #[rand(1000,9999)]"
	receipt.desc = "Payment receipt for [amount] credits"
	receipt.info = receipt_text
	receipt.info_links = receipt.info + receipt.info_links
	receipt.icon_state = "chek"
	receipt.Move(get_turf(loc))
	receipt.randpixel = 0
	if(dir == NORTH || dir == SOUTH)
		receipt.pixel_y = pixel_y + (dir == NORTH ? 10 : -10)
		receipt.pixel_x = pixel_x
	else
		receipt.pixel_x = pixel_x + (dir == EAST ? 10 : -10)
		receipt.pixel_y = pixel_y

/obj/item/device/payment_terminal/emag_act(remaining_charges, mob/user)
	if(emag_tax == 100 || remaining_charges <= 0)
		return FALSE

	emag_tax = min(emag_tax + 15, 100)

	playsound(src, SFX_USE_TERMINAL_ACCESS, 70)
	generate_machine_id()
	SStgui.update_uis(src)
	if(prob(emag_tax))
		visible_message(SPAN_INFO("\icon[src] \The [src] displayed: \"It's just business.\""))
	else
		visible_message(SPAN_INFO("\icon[src] \The [src] displayed: \"A small tax never killed anyone.\""))
	return TRUE

/obj/item/device/payment_terminal/dropped(mob/user)
	set_mode(MODEFLAG_TERMINAL_AMOUNT, user)
	SStgui.update_uis(src)
	if(user)
		dir = user.dir

GLOBAL_LIST_INIT(first_parts_name_terminal, list(
	"Charity Fund",
	"Community",
	"Association",
	"Protection League",
	"Committee on",
	"Movement",
	"Organization",
	"Council",
	"Brotherhood",
	"Coalition",
	"Alliance",
	"Liberation Front",
	"Union",
	"Party",
	"Union",
	"Support Group",
	"Academy",
	"Institute",
	"Trust",
	"Consortium"
))

GLOBAL_LIST_INIT(second_parts_name_terminal, list(
	"red fire extinguishers",
	"Tayarian orphans",
	"broken destructors",
	"lost carp",
	"freed borgs",
	"hairy unaths",
	"closed dorms",
	"fired captains",
	"drunk cargo technicians",
	"anonymous metroids",
	"former xenos",
	"shock victims",
	"trapped in brig",
	"disconnected AIs",
	"forgotten in space",
	"underpaid miners",
	"barricaded engineers",
	"innocent clowns",
	"lost nuclear disks",
	"forgotten in cryo"
))

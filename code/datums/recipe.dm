/* * * * * * * * * * * * * * * * * * * * * * * * * *
 * /datum/recipe by rastaf0            13 apr 2011 *
 * * * * * * * * * * * * * * * * * * * * * * * * * *
 * This is powerful and flexible recipe system.
 * It exists not only for food.
 * supports both reagents and objects as prerequisites.
 * In order to use this system you have to define a deriative from /datum/recipe
 * * reagents are reagents. Acid, milc, booze, etc.
 * * items are objects. Fruits, tools, circuit boards.
 * * result is type to create as new object
 * * time is optional parameter, you shall use in in your machine,
 * * default /datum/recipe/ procs does not rely on this parameter.
 *
 *  Functions you need:
 *  /datum/recipe/proc/make(var/obj/container as obj)
 *    Creates result inside container,
 *    deletes prerequisite reagents,
 *    transfers reagents from prerequisite objects,
 *    deletes all prerequisite objects (even not needed for recipe at the moment).
 *
 *  /proc/select_recipe(list/datum/recipe/avaiable_recipes, obj/obj as obj, exact = 1)
 *    Wonderful function that select suitable recipe for you.
 *    obj is a machine (or magik hat) with prerequisites,
 *    exact = 0 forces algorithm to ignore superfluous stuff.
 *
 *
 *  Functions you do not need to call directly but could:
 *  /datum/recipe/proc/check_reagents(var/datum/reagents/avail_reagents)
 *  /datum/recipe/proc/check_items(var/obj/container as obj)
 *
 * */

/datum/recipe
	var/list/reagents // example: = list(/datum/reagent/drink/juice/berry = 5) // do not list same reagent twice
	var/list/items    // example: = list(/obj/item/crowbar, /obj/item/welder) // place /foo/bar before /foo
	var/list/fruit    // example: = list("fruit" = 3)
	var/result        // example: = /obj/item/reagent_containers/food/donut/normal
	var/time = 100    // 1/10 part of second
	var/amount = 1    // number of 'result' instances to spawn

/datum/recipe/proc/check_reagents(datum/reagents/avail_reagents)
	. = 1
	for (var/r_r in reagents)
		var/aval_r_amnt = avail_reagents.get_reagent_amount(r_r)
		if (!(abs(aval_r_amnt - reagents[r_r])<0.5)) //if NOT equals
			if (aval_r_amnt>reagents[r_r])
				. = 0
			else
				return -1
	if ((reagents?(reagents.len):(0)) < avail_reagents.reagent_list.len)
		return 0
	return .

/datum/recipe/proc/check_fruit(obj/container)
	. = 1
	if(LAZYLEN(fruit))
		var/list/checklist = list()
		 // You should trust Copy().
		checklist = fruit.Copy()
		for(var/obj/item/reagent_containers/food/grown/G in container.InsertedContents())
			if(!G.seed || !G.seed.kitchen_tag || isnull(checklist[G.seed.kitchen_tag]))
				continue
			checklist[G.seed.kitchen_tag]--
		for(var/ktag in checklist)
			if(!isnull(checklist[ktag]))
				if(checklist[ktag] < 0)
					. = 0
				else if(checklist[ktag] > 0)
					. = -1
					break
	return .

/datum/recipe/proc/check_items(obj/container as obj)
	. = 1
	if(length(items))
		var/list/checklist = list()
		checklist = items.Copy() // You should really trust Copy
		for(var/obj/item/I in container.InsertedContents())
			if(istype(I,/obj/item/reagent_containers/food/grown))
				continue // Fruit is handled in check_fruit().
			var/found = 0
			for(var/i in 1 to length(checklist))
				var/item_type = checklist[i]
				if(istype(I.return_item(),item_type))
					checklist.Cut(i, i+1)
					found = 1
					break
			if (!found)
				. = 0
		if (checklist.len)
			. = -1
	return .

//general version
/datum/recipe/proc/make(obj/container)
	var/obj/result_obj = new result(container)
	for(var/obj/item/I in (container.InsertedContents() - result_obj))
		I.return_item().reagents.trans_to_obj(result_obj, I.return_item().reagents.total_volume)
		qdel(I)
	container.reagents.clear_reagents()
	return result_obj

// Old version of the proc, adds up all the reagents (except nutriments) from the ingredients to the resulting food item.
/datum/recipe/proc/make_food_legacy(obj/container)
	if(!result)
		log_error(SPAN("danger", "Recipe [type] is defined without a result, please bug this."))

		return
	var/obj/result_obj = new result(container)
	for(var/obj/item/I in (container.InsertedContents() - result_obj))
		var/obj/item/O = I.return_item()
		if (O.reagents)
			O.reagents.del_reagent(/datum/reagent/nutriment)
			O.reagents.update_total()
			O.reagents.trans_to_obj(result_obj, O.reagents.total_volume)
		if(istype(I, /obj/item/holder/))
			var/obj/item/holder/H = I
			H.destroy_all()
		qdel(I)
	container.reagents.clear_reagents()
	return result_obj

// New version, only adds up "extra" reagents.
/datum/recipe/proc/make_food(obj/container)
	if(!result)
		log_error(SPAN("danger", "Recipe [type] is defined without a result, please bug this."))
		return

	var/list/result_reagents = list()
	var/list/result_objs = list()
	for(var/i = 1; i <= amount; i++)
		result_objs.Add(new result(container))

	if(result_objs[1].reagents?.reagent_list)
		for(var/datum/reagent/R in result_objs[1].reagents.reagent_list)
			result_reagents[R.type] = R.volume * amount

	var/datum/reagents/add_up_reagents = new /datum/reagents(100 LITERS, GLOB.temp_reagents_holder)
	for(var/obj/item/I in (container.InsertedContents() - result_objs))
		var/obj/item/O = I.return_item()
		if(O.reagents)
			for(var/datum/reagent/R in O.reagents.reagent_list)
				if(istype(R, /datum/reagent/nutriment/protein))
					var/datum/reagent/nutriment/protein/P = R
					add_up_reagents.add_reagent((P.cooked_path ? P.cooked_path : P.type), P.volume)
				else if(R.type != /datum/reagent/nutriment) // Fuck basic nutriments, child types are okay.
					add_up_reagents.add_reagent(R.type, R.volume)
		if(istype(I, /obj/item/holder))
			var/obj/item/holder/H = I
			H.destroy_all()
		qdel(I)

	for(var/datum/reagent/R in add_up_reagents.reagent_list)
		if(result_reagents[R.type] && result_reagents[R.type] >= R.volume)
			continue
		for(var/obj/result_obj in result_objs)
			add_up_reagents.trans_type_to(result_obj, R.type, round((R.volume - result_reagents[R.type]) / amount, 0.1))

	qdel(add_up_reagents)
	container.reagents.clear_reagents()
	return result_objs

/proc/select_recipe(list/datum/recipe/avaiable_recipes, obj/obj as obj, exact)
	var/list/datum/recipe/possible_recipes = new
	var/target = exact ? 0 : 1
	for (var/datum/recipe/recipe in avaiable_recipes)
		if((recipe.check_reagents(obj.reagents) < target) || (recipe.check_items(obj) < target) || (recipe.check_fruit(obj) < target))
			continue
		possible_recipes |= recipe
	if (possible_recipes.len==0)
		return null
	else if (possible_recipes.len==1)
		return possible_recipes[1]
	else //okay, let's select the most complicated recipe
		var/highest_count = 0
		. = possible_recipes[1]
		for (var/datum/recipe/recipe in possible_recipes)
			var/count = ((recipe.items)?(recipe.items.len):0) + ((recipe.reagents)?(recipe.reagents.len):0) + ((recipe.fruit)?(recipe.fruit.len):0)
			if (count >= highest_count)
				highest_count = count
				. = recipe
		return .

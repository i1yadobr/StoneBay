/////////////////////////////////////////
//Material Rings
/obj/item/clothing/ring/material
	icon = 'icons/obj/clothing/rings.dmi'
	icon_state = "material"
	var/material_name
	var/material/material

/obj/item/clothing/ring/material/New(newloc)
	..(newloc)
	if(!material_name)
		material_name = MATERIAL_STEEL
	material = get_material_by_name(material_name)
	if(!istype(material))
		qdel(src)
		return
	name = "[material.display_name] ring"
	desc = "A ring made from [material.display_name]."
	color = material.icon_colour

/obj/item/clothing/ring/material/get_material()
	return initial(material)

/obj/item/clothing/ring/material/wood
	material_name = MATERIAL_WOOD

/obj/item/clothing/ring/material/plastic
	material_name = MATERIAL_PLASTIC

/obj/item/clothing/ring/material/steel
	material_name = MATERIAL_STEEL

/obj/item/clothing/ring/material/silver
	material_name = MATERIAL_SILVER

/obj/item/clothing/ring/material/gold
	material_name = MATERIAL_GOLD

/obj/item/clothing/ring/material/platinum
	material_name = MATERIAL_PLATINUM

/obj/item/clothing/ring/material/bronze
	material_name = MATERIAL_BRONZE

/obj/item/clothing/ring/material/glass
	material_name = MATERIAL_GLASS

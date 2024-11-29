extends Button

var clickable = false
var this_item;

func _item_texture(item, naym):
	get_child(0).texture = item.texture
	if naym == "Body_Items":
		var color = ItemLibrary._get_pet_equip_library()[4].name
		get_child(0).self_modulate = color
	if naym == "Eyes_Items":
		get_child(0).hframes = 9
		get_child(0).vframes = 1
		get_child(0).frame = 2
	if naym == "Mouth_Items":
		get_child(0).hframes = 15
		get_child(0).vframes = 1
		get_child(0).frame = 2
	if naym == "Color_Items":
		get_child(0).self_modulate = item.name
	this_item = item
	


func _update_pet_equip_database(item):
	var child_id = DataManager._get_child_database()[0].id
	
	if item.type == "body":
		Singleton.database.update_rows("pet", "id = %d" %child_id, {"body_id" : item.id})
	elif item.type == "eye":
		Singleton.database.update_rows("pet", "id = %d" %child_id, {"eyes_id" : item.id})
	elif item.type == "mouth":
		Singleton.database.update_rows("pet", "id = %d" %child_id, {"mouth_id" : item.id})
	elif item.type == "hat":
		Singleton.database.update_rows("pet", "id = %d" %child_id, {"hat_id" : item.id})
	elif item.type == "color":
		Singleton.database.update_rows("pet", "id = %d" %child_id, {"color_id" : item.id})
	get_parent()._get_item(this_item)
	


func _on_pressed():
	SoundPlayer.button_sfx();
	_update_pet_equip_database(this_item)
	
	pass # Replace with function body.

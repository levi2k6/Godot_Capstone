extends Control

var clickable = false
var this_item;


func _input(event):
	if clickable and Input.is_action_just_pressed("click"):
		_update_pet_equip_database(this_item)


func _item_texture(item, naym):
	get_child(0).texture = item.texture
	if naym == "Eyes_Items":
		get_child(0).hframes = 9
		get_child(0).vframes = 1
		get_child(0).frame = 2
	if naym == "Mouth_Items":
		get_child(0).hframes = 15
		get_child(0).vframes = 1
		get_child(0).frame = 2
	this_item = item
	

func _update_pet_equip_database(item):
	var child = DataManager._get_child_database()
	
	print(item.name, "one1")
	
	if item.type == "body":
		Singleton.database.update_rows("pet", "id = %d" %child[0].id, {"name" :"bunkey" , "body_id" : item.id})
	elif item.type == "eye":
			Singleton.database.update_rows("pet", "id = %d" %child[0].id, {"name" :"bunkey" , "eyes_id" : item.id})
	elif item.type == "mouth":
			Singleton.database.update_rows("pet", "id = %d" %child[0].id, {"name" :"bunkey" , "mouth_id" : item.id})
	elif item.type == "hat":
			Singleton.database.update_rows("pet", "id = %d" %child[0].id, {"name" :"bunkey" , "hat_id" : item.id})
	get_parent()._get_item(this_item)

func _on_mouse_entered():
	clickable = true
	#print(clickable)
	pass # Replace with function body.


func _on_mouse_exited():
	clickable = false
	#print(clickable)
	pass # Replace with function body.




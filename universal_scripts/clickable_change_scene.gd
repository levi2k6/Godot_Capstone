extends Button



func _ready():
	text = name
	pass


func _on_pressed():
	if name == "Collection_Button":
		get_tree().change_scene_to_file("res://systems/collection/collection.tscn")
	elif name == "Shop_Button":
		get_tree().change_scene_to_file("res://systems/shop/shop.tscn")
	elif name == "Main_Hub_Button":
		_button_functions()
		get_tree().change_scene_to_file("res://systems/main_hub/world.tscn")
	elif name == "Create_Child_Button":
		get_tree().change_scene_to_file("res://systems/create_child/create_child.tscn")
	elif name == "Create_Pet_Button":
		_button_functions()
		get_tree().change_scene_to_file("res://systems/create_pet/create_pet.tscn")

func _button_functions():
	var child = ItemLibrary._get_child_database()
	
	if get_tree().get_current_scene().name == "Create_Child":
		var fname = get_tree().get_current_scene().get_child(0).text
		var lname = get_tree().get_current_scene().get_child(1).text
		Singleton.database.update_rows("child", "id = %s" %child[0].id, {"fname": fname, "lname": lname})
		print("worked!")
	
	if get_tree().get_current_scene().name == "Create_Pet":
		var child_id = ItemLibrary._get_child_database()
		var pet_item = []
		for item in ItemLibrary._get_pet_equip_library():
			Singleton.database.insert_row("collection", {"child_id":child_id[0].id,  "item_id": item.id, })
	


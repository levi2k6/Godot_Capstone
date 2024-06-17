extends ColorRect

@onready var text_edit = $TextEdit

func _on_create_pet_button_up():
	var child = DataManager._get_child_database()
	var equip_library = ItemLibrary._get_pet_equip_library()
	var collection_library = ItemLibrary._get_collection_library()
	var n = 0

	if equip_library.size() > 3:
		print("PET INCOMPLETE!")
	elif equip_library.size() == 3:
		if  text_edit.text == "":
			print("NAME IS BLANK!")
			return
		else:
			Singleton.database.update_rows("pet", " id = %s"%child[0].id, {"name": text_edit.text})
		for item in equip_library:
			for collection in collection_library:
				n += 1
				print(n)
				if item.id == collection.id:
					print("(",item.id, " is the same with ", collection.id,")")
					break
				if n == collection_library.size():
					print(n," was not found so insert the item")
					Singleton.database.insert_row("collection", {"child_id": child[0].id, "item_id": item.id})
			n = 0
		get_tree().change_scene_to_file("res://systems/main_hub/main_hub.tscn")

	
	pass # Replace with function body.

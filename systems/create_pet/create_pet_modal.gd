extends Panel

@onready var text_edit = $TextEdit

var able = true;

func _on_create_pet_button_up():
	var child = DataManager._get_current_child();
	var equip_library = ItemLibrary._get_pet_equip_library(child[0].id);
	var collection_library = ItemLibrary._get_collection_library();
	var n = 0
	if equip_library.size() < 3:
		print("PET INCOMPLETE!")
	elif equip_library.size() >= 3:
		if  text_edit.text == "":
			print("NAME IS BLANK!");
			return
		else:
			Singleton.database.update_rows("pet", " id = %s"%child[0].id, {"name": text_edit.text});
			print("is thsi even working?");
			
		if collection_library.size() == 0:
			if able:
				able = false;
				print("nothing inside")
				for item in equip_library:
					if item == null:
						continue;
					Singleton.database.insert_row("collection", {"child_id": child[0].id, "item_id": item.id})
				await transition();
				GameData.transition_disappear = true;
				get_tree().change_scene_to_file("res://systems/main_hub/main_hub.tscn")
		else:
			if able:
				able = false;
				for item in equip_library:
					for collection in collection_library:
						n += 1
						print(n)
						if item == null:
							continue;
						if item.id == collection.id:
							break;
						if n == collection_library.size():
							print(n," was not found so insert the item")
							Singleton.database.insert_row("collection", {"child_id": child[0].id, "item_id": item.id})
					n = 0
				await transition();
				GameData.transition_disappear = true;
				get_tree().change_scene_to_file("res://systems/main_hub/main_hub.tscn")


func _input(event):
	if text_edit.has_focus():
		if event is InputEventKey and event.is_pressed():
			if event.keycode == KEY_ENTER:
				get_viewport().set_input_as_handled();


func transition():
	var transition_layer = get_tree().current_scene.get_transition_layer();
	await transition_layer.appear();

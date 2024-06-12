extends Sprite2D



func _input(event): 
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if get_rect().has_point(to_local(event.position)):
			_change()
			

   
func _change():
	if get_parent().name == "Character_Costumize":
		get_tree().change_scene_to_file("res://scenes/costumize_pet/character_costumize.tscn")
	elif get_parent().name == "Main_Hub":
		get_tree().change_scene_to_file("res://scenes/main_hub/world.tscn")
	elif get_parent().name == "Game1":
		get_tree().change_scene_to_file("res://scenes/world.tscn")

extends Button



func _ready():
	text = name
	pass

func _on_pressed():
	if name == "Collection_Button":
		get_tree().change_scene_to_file("res://systems/collection/collection.tscn");
	elif name == "Shop_Button":
		get_tree().change_scene_to_file("res://systems/shop/shop.tscn");
	elif name == "Main_Hub_Button":
		get_tree().change_scene_to_file("res://systems/main_hub/main_hub.tscn");
	elif name == "Create_Child_Button":
		get_tree().change_scene_to_file("res://systems/create_child/create_child.tscn");
	elif name == "Create_Pet_Button":
		get_tree().change_scene_to_file("res://systems/create_pet/create_pet.tscn");
	elif name == "Games_Button":
		get_tree().change_scene_to_file("res://systems/games/games.tscn");
	elif name == "Game1_Button":
		get_tree().change_scene_to_file("res://systems/games/game1/game1.tscn");
	elif name == "Game2_Button":
		get_tree().change_scene_to_file("res://systems/games/game2/game2.tscn");
	elif name == "Game3_Button":
		get_tree().change_scene_to_file("res://systems/games/game3/game3.tscn");
	elif name == "Settings_Button":
		get_tree().change_scene_to_file("res://systems/settings/settings.tscn");
	elif name == "Stats_Button":
		get_tree().change_scene_to_file("res://systems/Stats/Stats.tscn");
	elif name == "Time_Played_Button":
		get_tree().change_scene_to_file("res://systems/stats/time_played/time_played.tscn");
	elif name == "Milestone_Button":
		get_tree().change_scene_to_file("res://systems/stats/milestone/milestone.tscn");

extends Button;


@export var sprite : Texture2D;


func _ready():
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
	elif name == "Game_Preference_Button":
		get_tree().change_scene_to_file("res://systems/stats/game_preference/game_preference.tscn");
	elif name == "Performance_Chart_Button":
		get_tree().change_scene_to_file("res://systems/stats/performance_chart/improvement_chart2.tscn");
	elif name == "Milestone_Button":
		get_tree().change_scene_to_file("res://systems/stats/milestone/milestone.tscn");
	
	

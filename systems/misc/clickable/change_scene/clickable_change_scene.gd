extends Button;


@export var sprite : Texture2D;


var able = true;

func _ready():
	
	pass

func _on_pressed():
	if able:
		able = false;
		if name == "Collection_Button":
			await transition();
			GameData.transition_disappear = true;
			get_tree().change_scene_to_file("res://systems/collection/collection.tscn");
		elif name == "Shop_Button":
			await transition();
			GameData.transition_disappear = true;
			get_tree().change_scene_to_file("res://systems/shop/shop.tscn");
		elif name == "Main_Hub_Button":
			await transition();
			GameData.transition_disappear = true;
			get_tree().change_scene_to_file("res://systems/main_hub/main_hub.tscn");
		elif name == "Create_Child_Button":
			await transition();
			GameData.transition_disappear = true;
			get_tree().change_scene_to_file("res://systems/create_child/create_child.tscn");
		elif name == "Create_Pet_Button":
			await transition();
			GameData.transition_disappear = true;
			get_tree().change_scene_to_file("res://systems/create_pet/create_pet.tscn");
		elif name == "Games_Button":
			await transition();
			GameData.transition_disappear = true;
			get_tree().change_scene_to_file("res://systems/games/games.tscn");
		elif name == "Game1_Button":
			await transition();
			GameData.transition_disappear = true;
			get_tree().change_scene_to_file("res://systems/games/game1/game1.tscn");
		elif name == "Game2_Button":
			await transition();
			GameData.transition_disappear = true;
			get_tree().change_scene_to_file("res://systems/games/game2/game2.tscn");
		elif name == "Game3_Button":
			await transition();
			GameData.transition_disappear = true;
			get_tree().change_scene_to_file("res://systems/games/game3/game3.tscn");
		elif name == "Settings_Button":
			await transition();
			GameData.transition_disappear = true;
			get_tree().change_scene_to_file("res://systems/settings/settings.tscn");
		elif name == "Stats_Button":
			await transition();
			GameData.transition_disappear = true;
			get_tree().change_scene_to_file("res://systems/Stats/Stats.tscn");
		elif name == "Game_Preference_Button":
			await transition();
			GameData.transition_disappear = true;
			get_tree().change_scene_to_file("res://systems/stats/game_preference/game_preference.tscn");
		elif name == "Performance_Chart_Button":
			await transition();
			GameData.transition_disappear = true;
			get_tree().change_scene_to_file("res://systems/stats/performance_chart/performance_chart.tscn");
		elif name == "Milestone_Button":
			await transition();
			GameData.transition_disappear = true;
			get_tree().change_scene_to_file("res://systems/stats/milestone/milestone.tscn");
	


func transition():
	var transition_layer = get_tree().current_scene.get_transition_layer();
	await transition_layer.appear();

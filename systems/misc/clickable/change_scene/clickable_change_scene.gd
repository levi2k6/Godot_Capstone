extends Button;

@onready var audio = $Auidio;
@export var sprite : Texture2D;

var able = true;

func _ready():
	pass

func _on_pressed():
	if able:
		able = false;
		if name == "Game_Menu_Button":
			SoundPlayer.button_sfx();
			await transition();
			GameData.transition_disappear = true;
			get_tree().change_scene_to_file("res://systems/game_menu/game_menu.tscn");
		elif name == "Collection_Button":
			SoundPlayer.button_sfx();;
			await transition();
			GameData.transition_disappear = true;
			get_tree().change_scene_to_file("res://systems/collection/collection.tscn");
		elif name == "Shop_Button":
			SoundPlayer.button_sfx();
			await transition();
			GameData.transition_disappear = true;
			get_tree().change_scene_to_file("res://systems/shop/shop.tscn");
		elif name == "Child_Dashboard_Button":
			SoundPlayer.button_sfx();
			await transition();
			GameData.transition_disappear = true;
			get_tree().change_scene_to_file("res://systems/child_dashboard/child_dashboard.tscn");
		elif name == "Main_Hub_Button":
			SoundPlayer.button_sfx();
			await transition();
			GameData.transition_disappear = true;
			get_tree().change_scene_to_file("res://systems/main_hub/main_hub.tscn");
		elif name == "Create_Child_Button":
			SoundPlayer.button_sfx();
			await transition();
			GameData.transition_disappear = true;
			get_tree().change_scene_to_file("res://systems/create_child/create_child.tscn");
		elif name == "Create_Pet_Button":
			SoundPlayer.button_sfx();
			await transition();
			GameData.transition_disappear = true;
			get_tree().change_scene_to_file("res://systems/create_pet/create_pet.tscn");
		elif name == "Games_Button":
			SoundPlayer.button_sfx();
			await transition();
			GameData.transition_disappear = true;
			get_tree().change_scene_to_file("res://systems/games/games.tscn");
		elif name == "Game1_Button":
			SoundPlayer.button_sfx();
			await transition();
			GameData.transition_disappear = true;
			get_tree().change_scene_to_file("res://systems/games/game1/game1.tscn");
		elif name == "Game2_Button":
			SoundPlayer.button_sfx();
			await transition();
			GameData.transition_disappear = true;
			get_tree().change_scene_to_file("res://systems/games/game2/game2.tscn");
		elif name == "Game3_Button":
			SoundPlayer.button_sfx();
			await transition();
			GameData.transition_disappear = true;
			get_tree().change_scene_to_file("res://systems/games/game3/game3.tscn");
		elif name == "Settings_Button":
			SoundPlayer.button_sfx();
			await transition();
			GameData.transition_disappear = true;
			get_tree().change_scene_to_file("res://systems/settings/settings.tscn");
		elif name == "Login_Button":
			SoundPlayer.button_sfx();
			await transition();
			GameData.transition_disappear = true;
			get_tree().change_scene_to_file("res://systems/login/login.tscn");
		elif name == "Stats_Button":
			SoundPlayer.button_sfx();
			await transition();
			GameData.transition_disappear = true;
			get_tree().change_scene_to_file("res://systems/stats/stats.tscn");
		elif name == "Game_Preference_Button":
			SoundPlayer.button_sfx();
			await transition();
			GameData.transition_disappear = true;
			get_tree().change_scene_to_file("res://systems/stats/game_preference/game_preference.tscn");
		elif name == "Performance_Chart_Button":
			SoundPlayer.button_sfx();
			await transition();
			GameData.transition_disappear = true;
			get_tree().change_scene_to_file("res://systems/stats/performance_chart/performance_chart.tscn");
		elif name == "Milestone_Button":
			SoundPlayer.button_sfx();
			await transition();
			GameData.transition_disappear = true;
			get_tree().change_scene_to_file("res://systems/stats/milestone/milestone.tscn");
		elif name == "Parent_Dashboard_Button":
			SoundPlayer.button_sfx();
			await transition();
			GameData.transition_disappear = true;
			get_tree().change_scene_to_file("res://systems/parent_dashboard/parent_dashboard.tscn");
		elif name == "Child_Settings_Button":
			SoundPlayer.button_sfx();
			await transition();
			GameData.transition_disappear = true;
			get_tree().change_scene_to_file("res://systems/child_settings/child_settings.tscn");
		elif name == "Restriction_Button":
			SoundPlayer.button_sfx();
			await transition();
			GameData.transition_disappear = true;
			get_tree().change_scene_to_file("res://systems/restriction/restriction.tscn");
		elif name == "Choose_Child_Button":
			SoundPlayer.button_sfx();
			await transition();
			GameData.transition_disappear = true;
			get_tree().change_scene_to_file("res://systems/choose_child/choose_child.tscn");
		elif name == "Change_Password_Button":
			SoundPlayer.button_sfx();
			await transition();
			GameData.transition_disappear = true;
			get_tree().change_scene_to_file("res://systems/change_password/change_password.tscn");

func transition():
	var transition_layer = get_tree().current_scene.get_transition_layer();
	await transition_layer.appear();



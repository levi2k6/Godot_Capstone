extends Button

func _ready():
	
	pass

var able = true;

func _on_pressed():
	#print_debug(GameData.last_scene);
	if able:
		able = false;
		if get_tree().current_scene.name == "Settings":
			SoundPlayer.button_sfx();
			await transition();
			GameData.transition_disappear = true;
			print("BEFORE", GameData.last_scene);
			get_tree().change_scene_to_file(GameData.last_scene);
		elif get_tree().current_scene.name == "Stats":
			SoundPlayer.button_sfx();
			await transition();
			GameData.transition_disappear = true;
			get_tree().change_scene_to_file("res://systems/settings/settings.tscn");
		elif get_tree().current_scene.name == "GamePreference" || get_tree().current_scene.name == "ImprovementChart" || get_tree().current_scene.name == "Milestone":
			SoundPlayer.button_sfx();
			await transition();
			GameData.transition_disappear = true;
			get_tree().change_scene_to_file("res://systems/stats/stats.tscn");
		
	pass # Replace with function body.


func transition():
	var transition_layer = get_tree().current_scene.get_transition_layer();
	await transition_layer.appear();
	

extends Button

func _ready():
	
	pass

func _on_pressed():
	print(GameData.last_scene);
	
	if get_tree().current_scene.name == "Settings":
		get_tree().change_scene_to_file(GameData.last_scene);
	elif get_tree().current_scene.name == "Stats":
		get_tree().change_scene_to_file("res://systems/settings/settings.tscn");
	elif get_tree().current_scene.name == "GamePreference" || get_tree().current_scene.name == "ImprovementChart" || get_tree().current_scene.name == "Milestone":
		get_tree().change_scene_to_file("res://systems/stats/stats.tscn");
	
	pass # Replace with function body.
	

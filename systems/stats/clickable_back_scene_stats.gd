extends Button

func _on_pressed():
	if get_tree().current_scene.name == "Stats":
		get_tree().change_scene_to_file("res://systems/settings/settings.tscn");
	elif get_tree().current_scene.name == "TimePlayed" || get_tree().current_scene.name == "MileStone":
		get_tree().change_scene_to_file("res://systems/stats/stats.tscn");
	pass # Replace with function body.

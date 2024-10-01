extends Control

func _on_settings_button_pressed():
	visible = true;
	pass # Replace with function body.

func _on_button_pressed():
	visible = false;
	pass # Replace with function body.

func _on_stats_pressed():
	get_tree().change_scene_to_file("res://systems/stats/stats.tscn");
	pass # Replace with function body.
		

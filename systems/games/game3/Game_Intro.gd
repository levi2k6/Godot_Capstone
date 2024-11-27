extends Control
@onready var animator = $"../../Animator"
@onready var game = $"../../Game"
@onready var highest_level = $Highest_Level

var start = true;


func display_highest_level():
	var game_data = DataManager._get_game_dynamic("timing_game");
	if game_data.size() == 0:
		return;
	var highest_level_db = game_data[0].highest_level;
	highest_level.text = "Highest Level: %s" %highest_level_db;
	pass
	highest_level.visible = true;

func _on_normal_button_up():
	highest_level.visible = false;
	await animator.ship_leave();
	game.difficulty = "normal";
	game.start();
	pass # Replace with function body.


func _on_hard_button_up():
	highest_level.visible = false;
	await animator.ship_leave();
	game.difficulty = "hard";
	game.start();
	pass # Replace with function body.

extends Control
@onready var animator = $"../../Animator"
@onready var game = $"../../Game"
@onready var highest_level_container = $Highest_Level_Container;
@onready var highest_level_n = $Highest_Level_Container/Highest_LevelN;
@onready var highest_level_h = $Highest_Level_Container/Highest_LevelH;


var start = true;


func display_highest_level():
	var game_data = DataManager._get_game_dynamic("timing_game");
	if game_data.size() == 0:
		return;
	
	var highest_normal = str(DataManager._get_game_highest_normal("timing")[0].highest);
	var highest_hard = str(DataManager._get_game_highest_hard("timing")[0].highest);
	if highest_normal == "<null>":
		highest_normal = "0";
	if highest_hard == "<null>":
		highest_hard = "0";
	highest_level_n.text = "Highest Level Normal: %s" %highest_normal;
	highest_level_h.text = "Highest Level Hard: %s" %highest_hard;
	
	highest_level_container.visible = true;

func _on_normal_button_up():
	SoundPlayer.button_sfx();
	highest_level_container.visible = false;
	await animator.ship_leave();
	game.difficulty = "normal";
	game.start();
	pass # Replace with function body.


func _on_hard_button_up():
	SoundPlayer.button_sfx();
	highest_level_container.visible = false;
	await animator.ship_leave();
	game.difficulty = "hard";
	game.start();
	pass # Replace with function body.

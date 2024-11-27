extends TextureRect
@onready var intro_control = $"..";
@onready var game_intro = $".";
@onready var highest_level = $Highest_Level;

@onready var animator = $"../../../../Animator";
@onready var game = $"../..";



var start = true;

func _ready():
	display_highest_level();

func display_highest_level():
	var game_datas = DataManager._get_game_dynamic("sequence_game");
	if game_datas.size() == 0:
		return
	
	var highest_level_db = str(game_datas[0].highest_level);
	highest_level.text = "Highest Level: %s" %highest_level_db;
	
	pass

func _on_normal_button_up():
	await animator.game_intro_leave();
	game.difficulty = "normal";
	game.start();
	pass # Replace with function body.

func _on_hard_button_up():
	await animator.game_intro_leave();
	game.difficulty = "hard";
	game.start();
	pass # Replace with function body.

extends Control
@onready var animator = $"../../../Animator"
@onready var game = $"../../../Game"
@onready var difficulties = $"../../Monitor1/Difficulties"
@onready var label = $Label
@onready var title = $"../../Monitor1/Title"
@onready var games_button = $Games_Button
@onready var play = $Play
@onready var highest_level = $"../../Highest_Level"

var start = true;

func _ready():
	display_highest_level();

func display_highest_level():
	games_button.disabled = false;
	play.disabled = false;
	if !start:
		play.text = "Again";
	
	
	var game_data = DataManager._get_game_dynamic("number_memory_game");
	
	if game_data.size() == 0:
		return
	
	var highest_level_db = str(game_data[0].highest_level);
	highest_level.text = "Highest Level: %s" %highest_level_db;
	
	highest_level.visible = !highest_level.visible;
	pass

func _on_normal_button_up():
	difficulties.visible = false;
	highest_level.visible = false;
	game.difficulty = "normal";
	animator.intro();
	pass # Replace with function body.

func _on_hard_button_up():
	games_button.disabled = true;
	difficulties.visible = false;
	highest_level.visible = false;
	game.difficulty = "hard";
	animator.intro();
	pass # Replace with function body.
	

func _on_play_button_up():
	games_button.disabled = true;
	play.disabled = true;
	label.text = "";
	title.visible = false;
	difficulties.visible = true;
	pass # Replace with function body.



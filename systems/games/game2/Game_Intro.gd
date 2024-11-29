extends Control
@onready var animator = $"../../../Animator";
@onready var game = $"../../../Game";
@onready var difficulties = $"../../Monitor1/Difficulties";
@onready var label = $Label;
@onready var title = $"../../Monitor1/Title";
@onready var games_button = $Games_Button;
@onready var play = $Play;
@onready var highest_level_container = $"../../Highest_Level_Container"
@onready var highest_level_n = $"../../Highest_Level_Container/Highest_LevelN"
@onready var highest_level_h = $"../../Highest_Level_Container/Highest_LevelH"


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
	
	var highest_normal = str(DataManager._get_game_highest_normal("number_memory")[0].highest);
	var highest_hard = str(DataManager._get_game_highest_hard("number_memory")[0].highest);
	if highest_normal == "<null>":
		highest_normal = "0";
	if highest_hard == "<null>":
		highest_hard = "0";
	highest_level_n.text = "Highest Level Normal: %s" %highest_normal;
	highest_level_h.text = "Highest Level Hard: %s" %highest_hard;
	highest_level_container.visible = true;
	pass

func _on_normal_button_up():
	SoundPlayer.button_sfx();
	games_button.disabled = true;
	difficulties.visible = false;
	highest_level_container.visible = false;
	game.difficulty = "normal";
	animator.intro();
	pass # Replace with function body.

func _on_hard_button_up():
	SoundPlayer.button_sfx();
	games_button.disabled = true;
	difficulties.visible = false;
	highest_level_container.visible = false;
	game.difficulty = "hard";
	animator.intro();
	pass # Replace with function body.
	

func _on_play_button_up():
	SoundPlayer.button_sfx();
	#games_button.disabled = true;
	play.disabled = true;
	label.text = "";
	title.visible = false;
	difficulties.visible = true;
	pass # Replace with function body.



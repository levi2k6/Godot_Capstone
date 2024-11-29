extends TextureRect
@onready var intro_control = $"..";
@onready var game_intro = $".";
@onready var highest_level_n = $Highest_Level_Container/Highest_LevelN
@onready var highest_level_h = $Highest_Level_Container/Highest_LevelH

@onready var animator = $"../../../../Animator";
@onready var game = $"../..";



var start = true;

func _ready():
	display_highest_level();

func display_highest_level():
	var game_datas = DataManager._get_game_dynamic("sequence_game"); 
	if game_datas.size() == 0:
		return
	
	var highest_normal = str(DataManager._get_game_highest_normal("sequence")[0].highest);
	var highest_hard = str(DataManager._get_game_highest_hard("sequence")[0].highest);
	if highest_normal == "<null>":
		highest_normal = "0";
	if highest_hard == "<null>":
		highest_hard = "0";
	highest_level_n.text = "Highest Level Normal: %s" %highest_normal;
	highest_level_h.text = "Highest Level Hard: %s" %highest_hard;
	pass

func _on_normal_button_up():
	SoundPlayer.button_sfx();
	await animator.game_intro_leave();
	game.difficulty = "normal";
	game.start();
	pass # Replace with function body.

func _on_hard_button_up():
	SoundPlayer.button_sfx();
	await animator.game_intro_leave();
	game.difficulty = "hard";
	game.start();
	pass # Replace with function body.

extends Control
@onready var animator = $"../../../Animator"
@onready var game = $"../../../Game"
@onready var difficulties = $"../../Monitor1/Difficulties"
@onready var label = $Label
@onready var title = $"../../Monitor1/Title"
@onready var play = $Play

var start = true;

func _ready():
	change();

func change():
	play.disabled = false;
	if !start:
		play.text = "Again";
	pass

func _on_normal_button_up():
	difficulties.visible = false;
	game.difficulty = "normal";
	animator.intro();
	pass # Replace with function body.

func _on_hard_button_up():
	difficulties.visible = false;
	game.difficulty = "hard";
	animator.intro();
	pass # Replace with function body.
	

func _on_play_button_up():
	play.disabled = true;
	label.text = "";
	title.visible = false;
	difficulties.visible = true;
	pass # Replace with function body.

func _on_back_button_up():
	get_tree().change_scene_to_file("res://systems/games/games.tscn");
	pass # Replace with function body.

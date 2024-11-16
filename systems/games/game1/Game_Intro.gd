extends TextureRect

@onready var animator = $"../../Animator"
@onready var game = $".."
@onready var label = $Label
var start = true;

func _ready():
	change();

func change():
	pass

func _on_normal_button_up():
	await animator.game_intro_leave();
	game.difficulty = "normal";
	get_parent().start();
	pass # Replace with function body.

func _on_hard_button_up():
	await animator.game_intro_leave();
	game.difficulty = "hard";
	get_parent().start();
	pass # Replace with function body.

extends Control
@onready var animator = $"../../Animator"
@onready var game = $"../../Game"

var start = true;

func _ready():
	change();

func change():
	pass
	

func _on_normal_button_up():
	await animator.ship_leave();
	game.difficulty = "normal";
	game.start();
	pass # Replace with function body.


func _on_hard_button_up():
	await animator.ship_leave();
	game.difficulty = "hard";
	game.start();
	pass # Replace with function body.

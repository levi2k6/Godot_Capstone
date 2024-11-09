extends Node2D
@onready var animator = $"../../Animator"
@onready var game = $"../../Game"

var start = true;

func _ready():
	change();

func change():
	pass
	

func _on_normal_button_up():
	await animator.ship_leave();
	game.start();
	pass # Replace with function body.


func _on_hard_button_up():
	await animator.ship_leave();
	game.start();
	pass # 

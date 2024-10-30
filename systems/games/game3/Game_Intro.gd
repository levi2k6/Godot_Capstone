extends Control

@onready var game = $"../../Game"

var start = true;

func _ready():
	change();

func change():
	if start:
		$Label.text = "Meteor Rush";
		$Play.text = "Play";
	else:
		$Label.text = "Game Over";
		$Play.text = "Again"
		

func _on_play_button_up():
	visible = false;
	game.start();
	pass # Replace with function body.

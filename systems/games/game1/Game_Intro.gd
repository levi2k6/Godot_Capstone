extends ColorRect
@onready var game = $".."
@onready var label = $Label
var start = true;

func _ready():
	change();

func change():
	if start:
		color = "2166e7";
		$Label.text = "Sequence Game";
		
	else:
		color = "c8284f";
		$Label.text = "Game Over";

func _on_normal_button_up():
	visible = false;
	game.difficulty = "normal";
	get_parent().start();
	pass # Replace with function body.

func _on_hard_button_up():
	game.difficulty = "hard";
	visible = false;
	get_parent().start();
	pass # Replace with function body.

extends Control
@onready var animator = $"../../Animator";

var start = true;

func _ready():
	change();

func change():
	if start:
		
		$Label.text = "Number Memory Game";
		$Play.text = "Play";
	else:
		
		$Label.text = "Game Over";
		$Play.text = "Again"
		

func _on_play_button_up():
	visible = false;
	animator.intro();
	pass # Replace with function body.

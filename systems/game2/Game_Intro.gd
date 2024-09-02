extends ColorRect

var start = true;

func _ready():
	change();

func change():
	if start:
		color = "2166e7";
		$Label.text = "Sequence Game";
		$Play.text = "Play";
	else:
		color = "c8284f";
		$Label.text = "Game Over";
		$Play.text = "Again"
		

func _on_play_button_up():
	visible = false;
	get_parent().start();
	pass # Replace with function body.

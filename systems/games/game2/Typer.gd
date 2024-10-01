extends Control
@onready var control = $".."
@onready var label = $"../Label"
var able = false;

func key_input(key:String):
	if able:
		if label.text == "What Was The Number?":
			label.text = "";
		label.text += key;

func finalize_input():
	if able:
		control.compare()

func _on_submit_button_down():
	finalize_input();
	pass # Replace with function body.

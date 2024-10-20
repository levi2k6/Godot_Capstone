extends Control

@onready var game = $"../../../Game"
@onready var monitor_2_output = $"../../Monitor2/Monitor2_Output"


var able = false;

func key_input(key:String):
		if monitor_2_output.text == "What was the number?":
			monitor_2_output.text = "";
		monitor_2_output.text += key;

func finalize_input():
	game.compare()

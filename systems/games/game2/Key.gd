extends TextureButton
@onready var typer = $".."
@onready var monitor_2_output = $"../../../Monitor2/Monitor2_Output"
@onready var key_sound = $"../Key_Sound"

func _on_button_down():
	key_sound.play();
	if !typer.able:
		return;
	get_child(0).frame = 1;
	if name == "Enter":
		print("enter");
		typer.finalize_input();
		return;
	if name == "Back":
		var monitor_text = monitor_2_output.text;
		if monitor_text == "What was the number?":
			monitor_2_output.text = "";
			return
		if monitor_text.length() > 0:
			monitor_2_output.text = monitor_text.substr(0, monitor_text.length() - 1);
		return;
	
	typer.key_input(name);
	
	
	pass # Replace with function body.

func _on_button_up():
	get_child(0).frame = 0;
	pass # Replace with function body.

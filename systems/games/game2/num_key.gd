extends Button

@onready var typer = $"../.."

func _on_button_down():
	
	typer.key_input(name);
	pass # Replace with function body.

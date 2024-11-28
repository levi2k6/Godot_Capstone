extends Panel
@onready var exit_modal = $"."


func _on_no_button_up():
	get_tree().quit();
	pass # Replace with function body.


func _on_no_button_down():
	exit_modal.visible = false;
	pass # Replace with function body.

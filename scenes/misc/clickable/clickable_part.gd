extends Control

var clickable = false


func _input(event):
	if clickable and Input.is_action_just_pressed("click"):
		get_parent()._get_part(get_child(0).texture)


func _on_mouse_entered():
	clickable = true
	print(clickable)
	pass # Replace with function body.


func _on_mouse_exited():
	clickable = false
	print(clickable)
	pass # Replace with function body.




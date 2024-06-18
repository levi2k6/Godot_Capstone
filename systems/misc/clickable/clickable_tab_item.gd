extends TextureRect
signal change_tab(naym)

var clickable = false



func _input(event):
	if clickable and Input.is_action_just_pressed("click"):
		emit_signal("change_tab", name)

func _change_texture():
	
	pass

func _on_mouse_entered():
	clickable = true
	#print(clickable)
	pass # Replace with function body.


func _on_mouse_exited():
	clickable = false
	#print(clickable)
	pass # Replace with function body.

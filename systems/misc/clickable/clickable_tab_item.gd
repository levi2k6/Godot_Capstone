extends Button
signal change_tab(naym)

var clickable = false



func _on_pressed():
	print("TEXTURE_BUTTON")
	emit_signal("change_tab", name)
	

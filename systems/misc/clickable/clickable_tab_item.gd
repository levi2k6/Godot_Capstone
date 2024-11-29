extends Button
signal change_tab(naym)

var clickable = false


func _on_pressed():
	SoundPlayer.button_sfx();
	emit_signal("change_tab", name);
	

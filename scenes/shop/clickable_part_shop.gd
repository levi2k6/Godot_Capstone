extends Control

var clickable = false
var this_part;

func _input(event):
	if clickable and Input.is_action_just_pressed("click"):
		get_parent()._get_part(this_part)


func _part_texture(part, naym):
	
	get_child(0).texture = part.texture
	if naym == "Eyes_Parts":
		get_child(0).hframes = 9
		get_child(0).vframes = 1
		get_child(0).frame = 2
	if naym == "Mouth_Parts":
		get_child(0).hframes = 15
		get_child(0).vframes = 1
		get_child(0).frame = 2
	
	this_part = part
	


func _on_mouse_entered():
	clickable = true
	#print(clickable)
	pass # Replace with function body.


func _on_mouse_exited():
	clickable = false
	#print(clickable)
	pass # Replace with function body.




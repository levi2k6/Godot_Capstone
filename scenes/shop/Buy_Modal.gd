extends ColorRect

var this_part;

@onready var body_parts = $"../Body_Picker/ScrollContainer/ColorRect/Body_Parts"
@onready var eyes_parts = $"../Body_Picker/ScrollContainer/ColorRect/Eyes_Parts"
@onready var mouth_parts = $"../Body_Picker/ScrollContainer/ColorRect/Mouth_Parts"
@onready var hat_parts = $"../Body_Picker/ScrollContainer/ColorRect/Hat_Parts"




func _modal_func(part):
	$Sprite2D.texture = part.texture
	this_part = part
	visible = !visible
	


func _on_button_button_up():
	Singleton.database.query(
		"SELECT * FROM child"
	)
	var child_id = Singleton.database.query_result
	var part_id = this_part.id
	
	Singleton.database.insert_row("collection", {"child_id": child_id[0].id, "part_id": this_part.id })
	print("check database if inserted")
	
	_refresh()
	pass # Replace with function body.

func _refresh():
	body_parts._ready()
	eyes_parts._ready()
	mouth_parts._ready()
	hat_parts._ready()

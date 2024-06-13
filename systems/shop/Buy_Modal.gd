extends ColorRect

var this_item;

@onready var body_items = $"../Body_Picker/ScrollContainer/ColorRect/Body_Items"
@onready var eyes_items = $"../Body_Picker/ScrollContainer/ColorRect/Eyes_Items"
@onready var mouth_items = $"../Body_Picker/ScrollContainer/ColorRect/Mouth_Items"
@onready var hat_items = $"../Body_Picker/ScrollContainer/ColorRect/Hat_Items"


func _modal_func(item):
	$Sprite2D.texture = item.texture
	this_item = item
	visible = !visible


func _on_button_button_up():
	Singleton.database.query(
		"SELECT * FROM child"
	)
	var child_id = Singleton.database.query_result
	var item_id = this_item.id
	
	Singleton.database.insert_row("collection", {"child_id": child_id[0].id, "item_id": item_id })
	print("check database if inserted")
	_delete_owned_item_shop()
	visible = !visible
	pass # Replace with function body.

func _delete_owned_item_shop():
	if this_item.type == "body":
		for node in body_items.get_children():
			if node.this_item.id == this_item.id:
				node.queue_free()
				print(this_item.name, " ", "DELETED")
	if this_item.type == "eye":
		for node in eyes_items.get_children():
			if node.this_item.id == this_item.id:
				node.queue_free()
				print(this_item.name, " ", "DELETED")
	if this_item.type == "mouth":
		for node in mouth_items.get_children():
			if node.this_item.id == this_item.id:
				node.queue_free()
				print(this_item.name, " ", "DELETED")
	if this_item.type == "hat":
		for node in hat_items.get_children():
			if node.this_item.id == this_item.id:
				node.queue_free()
				print(this_item.name, " ", "DELETED")
	

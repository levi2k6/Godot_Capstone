extends ColorRect

var this_item;

@onready var body_items = $"../Picker/ScrollContainer/ColorRect/Body_Items"
@onready var eyes_items = $"../Picker/ScrollContainer/ColorRect/Eyes_Items"
@onready var mouth_items = $"../Picker/ScrollContainer/ColorRect/Mouth_Items"
@onready var hat_items = $"../Picker/ScrollContainer/ColorRect/Hat_Items"
@onready var color_items = $"../Picker/ScrollContainer/ColorRect/Color_Items"

@onready var money_display = $"../Money"



func _modal_func(item):
	$Sprite2D.texture = item.texture
	if item.type == "body" or item.type == "hat":
		$Sprite2D.hframes = 1
		$Sprite2D.vframes = 1
		$Sprite2D.frame = 0
		$Sprite2D.self_modulate = Color(1, 1, 1, 1)
		#print(item.type)
	if item.type == "eye":
		$Sprite2D.hframes = 9
		$Sprite2D.vframes = 1
		$Sprite2D.frame = 2
		$Sprite2D.self_modulate = Color(1, 1, 1, 1)
		#print(item.type)
	if item.type == "mouth":
		$Sprite2D.hframes = 15
		$Sprite2D.vframes = 1
		$Sprite2D.frame = 2
		$Sprite2D.self_modulate = Color(1, 1, 1, 1)
		#print(item.type)
	if item.type == "color":
		$Sprite2D.hframes = 1
		$Sprite2D.vframes = 1
		$Sprite2D.frame = 0
		$Sprite2D.self_modulate = item.name
	this_item = item
	visible = true


func _on_button_button_up():
	
	var child_id = DataManager._get_child_database()
	var item_id = this_item.id
	
	var money = DataManager._get_money_database()[0].money
	
	if money >= 100:
		Singleton.database.insert_row("collection", {"child_id": child_id[0].id, "item_id": item_id })
		print("check database if inserted")
		_delete_owned_item_shop()
		
		var deduction = money - 100
		DataManager._update_money_database(deduction)
		money_display._display_money()
		visible = !visible
	elif money < 100:
		print("NOT ENOUGH MONEY!")
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
	if this_item.type == "color":
		for node in color_items.get_children():
			if node.this_item.id == this_item.id:
				node.queue_free()
				print(this_item.name, " ", "DELETED")
	


func _on_close_pressed():
	visible = false
	pass # Replace with function body.

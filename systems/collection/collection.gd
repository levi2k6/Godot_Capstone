extends Node2D

@onready var body_items = $Control/Picker/ScrollContainer/ColorRect/Body_Items
@onready var eyes_items = $Control/Picker/ScrollContainer/ColorRect/Eyes_Items
@onready var mouth_items = $Control/Picker/ScrollContainer/ColorRect/Mouth_Items
@onready var hat_items = $Control/Picker/ScrollContainer/ColorRect/Hat_Items
@onready var color_items = $Control/Picker/ScrollContainer/ColorRect/Color_Items


@onready var h_box_container = $Control/Picker/HBoxContainer
@onready var color_rect = $Control/Picker/ScrollContainer/ColorRect



func _ready():
	#_resolution()
	
	for child in h_box_container.get_children():
		child.change_tab.connect(_change_tab)
	
	for child in color_rect.get_children():
		child.send_texture.connect(_change_item)
	
	_change_tab("Tab_Bodies")

#func _resolution():
	#var view_port = get_viewport().size
	#var center_x = view_port.x / 2 
	#var center_y = view_port.y / 1.50
	#
	#$Control.size = view_port
	#$Pet.position = Vector2(center_x, center_y)

func _change_tab(naym):
	for child in color_rect.get_children():
		child.visible = false
		if naym == "Tab_Bodies":
			body_items.visible = true
			pass
		elif naym == "Tab_Eyes":
			eyes_items.visible = true
			pass
		elif naym == "Tab_Mouths":
			mouth_items.visible = true
			pass
		elif naym == "Tab_Hats":
			hat_items.visible = true
			pass
		elif naym == "Tab_Colors":
			color_items.visible = true
			pass

func _change_item(item, naym):
	$Pet._fashion()
	pass




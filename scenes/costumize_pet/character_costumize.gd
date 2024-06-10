extends Node2D

@onready var body_parts = $Body_Picker/ScrollContainer/ColorRect/Body_Parts


@onready var eyes_parts = $Body_Picker/ScrollContainer/ColorRect/Eyes_Parts
@onready var mouth_parts = $Body_Picker/ScrollContainer/ColorRect/Mouth_Parts
@onready var hat_parts = $Body_Picker/ScrollContainer/ColorRect/Hat_Parts

@onready var grid_container = $MarginContainer/GridContainer
@onready var color_rect = $Body_Picker/ScrollContainer/ColorRect





func _ready():
	
	for child in grid_container.get_children():
		child.change_tab.connect(_change_tab)
	
	for child in color_rect.get_children():
		child.send_texture.connect(_change_part)
	
	_change_tab("Tab_Bodies")

func _change_tab(naym):
	for child in color_rect.get_children():
		child.visible = false
		if naym == "Tab_Bodies":
			body_parts.visible = true
			pass
		elif naym == "Tab_Eyes":
			eyes_parts.visible = true
			pass
		elif naym == "Tab_Mouths":
			mouth_parts.visible = true
			pass
		elif naym == "Tab_Hats":
			hat_parts.visible = true
			pass
			

func _change_part(texture, naym):
	if naym == "Body_Parts":
		get_child(0).properties.body = texture
		get_child(0)._fashion()
	elif naym == "Eyes_Parts":
		get_child(0).properties.eyes = texture
		get_child(0)._fashion()
	elif naym == "Mouth_Parts":
		get_child(0).properties.mouth = texture
		get_child(0)._fashion()
	elif naym == "Hat_Parts":
		get_child(0).properties.hat = texture
		get_child(0)._fashion()





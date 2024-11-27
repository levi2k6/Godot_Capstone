extends Node2D
@onready var pet = $Control/Pet_Control/Pet

@onready var body_items = $Control/Picker/ScrollContainer/ColorRect/Body_Items
@onready var eyes_items = $Control/Picker/ScrollContainer/ColorRect/Eyes_Items
@onready var mouth_items = $Control/Picker/ScrollContainer/ColorRect/Mouth_Items
@onready var hat_items = $Control/Picker/ScrollContainer/ColorRect/Hat_Items
@onready var color_items = $Control/Picker/ScrollContainer/ColorRect/Color_Items

@onready var h_box_container = $Control/Picker/HBoxContainer
@onready var color_rect = $Control/Picker/ScrollContainer/ColorRect
@onready var transition_layer = $Transition_Layer

func get_transition_layer():
	return transition_layer;

func _ready():
	#_resolution()
	for child in h_box_container.get_children():
		child.change_tab.connect(_change_tab);
	_change_tab("Tab_Bodies");

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




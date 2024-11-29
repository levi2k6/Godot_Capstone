extends Node2D
@onready var pet = $Control/Pet_Control/Pet

@onready var body_items = $Control/Picker/ScrollContainer/ColorRect/Body_Items
@onready var eyes_items = $Control/Picker/ScrollContainer/ColorRect/Eyes_Items
@onready var mouth_items = $Control/Picker/ScrollContainer/ColorRect/Mouth_Items
@onready var color_items = $Control/Picker/ScrollContainer/ColorRect/Color_Items

@onready var h_box_container = $Control/Picker/HBoxContainer
@onready var color_rect = $Control/Picker/ScrollContainer/ColorRect

@onready var create_pet_modal = $Control/Create_Pet_Modal
@onready var transition_layer = $Transition_Layer

func get_transition_layer():
	return transition_layer;

func _ready():
	for child in h_box_container.get_children():
		child.change_tab.connect(_change_tab)
	
	for child in color_rect.get_children():
		child.send_texture.connect(_change_item)
	
	_change_tab("Tab_Bodies")


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
		elif naym == "Tab_Colors":
			color_items.visible = true
			pass
	button_highlight_disabler(naym);

func button_highlight_disabler(naym):
	for child in h_box_container.get_children():
		if naym == child.name:
			continue;
		child.button_pressed = false;

func _change_item(item, naym):
	#print(naym)
	pet._fashion()
	pass

func _on_submit_pressed():
	SoundPlayer.button_sfx();
	create_pet_modal.visible = !create_pet_modal.visible
	pass # Replace with function body.

func _on_back_button_up():
	SoundPlayer.button_sfx();
	create_pet_modal.visible = false;
	pass # Replace with function body.

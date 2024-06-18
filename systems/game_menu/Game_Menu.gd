extends Node2D

@onready var main_hub_button = $Control/Main_Hub_Button
@onready var create_child_button = $Control/Create_Child_Button
@onready var create_pet_button = $Control/Create_Pet_Button



func _ready():
	var child = DataManager._get_child_database()
	var pet_equip = ItemLibrary._get_pet_equip_library()
	
	if child.size() == 0:
		main_hub_button.visible = false
		create_child_button.visible = true
		create_pet_button.visible = false
	elif pet_equip.size() < 3:
		main_hub_button.visible = false
		create_child_button.visible = false
		create_pet_button.visible = true
	else:
		main_hub_button.visible = true
		create_child_button.visible = false
		create_pet_button.visible = false














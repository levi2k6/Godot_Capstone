extends Node2D

@onready var body_items = $Body_Picker/ScrollContainer/ColorRect/Body_Items
@onready var eyes_items = $Body_Picker/ScrollContainer/ColorRect/Eyes_Items
@onready var mouth_items = $Body_Picker/ScrollContainer/ColorRect/Mouth_Items
@onready var hat_items = $Body_Picker/ScrollContainer/ColorRect/Hat_Items

@onready var grid_container = $MarginContainer/GridContainer
@onready var color_rect = $Body_Picker/ScrollContainer/ColorRect


func _ready():
	if get_tree().get_current_scene().name == "Create_Pet":
		Singleton.database.query("SELECT * FROM pet")
		var pet = Singleton.database.query_result
		var child = ItemLibrary._get_child_database()
		
		if pet.size() == 0:
			Singleton.database.insert_row("pet", {"id":child[0].id, "name": "", "body_id": 0, "eyes_id": 0, "mouth_id":0, "hat_id": 0})
		else:
			print("pet already exist")
		
	for child in grid_container.get_children():
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
		elif naym == "Tab_Hats":
			hat_items.visible = true
			pass
			

func _change_item(item, naym):
	$Pet._fashion()
	pass





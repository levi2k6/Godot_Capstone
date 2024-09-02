extends Node2D

@onready var fname = $Control/HBoxContainer/VBoxContainer1/Fname
@onready var lname = $Control/HBoxContainer/VBoxContainer2/Lname




func _ready():
	_resolution()
	DataManager._create_child_database();
	DataManager._create_pet_database();
	

func _resolution():
	var view_port = get_viewport().size
	$Control.size = view_port
	
	
	

func _on_button_button_up():
	var child_id = DataManager._get_child_database()[0].id
	
	if fname.text == "" or lname.text == "":
		print("please complete name")
	else:
		Singleton.database.update_rows("child", "id = %s" %child_id, {"fname": fname.text, "lname": lname.text})
		get_tree().change_scene_to_file("res://systems/create_pet/create_pet.tscn")
	
	pass # Replace with function body.

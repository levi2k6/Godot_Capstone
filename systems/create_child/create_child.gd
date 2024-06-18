extends Node2D


func _ready():
	DataManager._create_child_database()
	DataManager._create_pet_database()
	


func _on_button_button_up():
	var child = DataManager._get_child_database()
	
	var fname = $Fname.text
	var lname = $Lname.text
	
	if fname == "" or lname == "":
		print("please complete name")
	else:
		Singleton.database.update_rows("child", "id = %s" %child[0].id, {"fname": fname, "lname": lname})
		get_tree().change_scene_to_file("res://systems/create_pet/create_pet.tscn")
	
	pass # Replace with function body.

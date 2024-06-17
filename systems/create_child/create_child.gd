extends Node2D


func _ready():
	
	var child = DataManager._get_child_database()
	
	if child.size() == 0:
		Singleton.database.insert_row("child", {"fname": "", "lname": ""})
	else: 
		print("child already exist")
	


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

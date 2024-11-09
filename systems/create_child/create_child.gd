extends Node2D

@onready var fname = $Control/HBoxContainer/VBoxContainer1/Fname
@onready var lname = $Control/HBoxContainer/VBoxContainer2/Lname

func _ready():
	#_resolution()
	
	create_child_database();

func create_child_database():
	var child = DataManager._get_child_database();
	
	if child.size() == 0:
		Singleton.database.insert_row("child", {"fname": "", "lname": "", "pet_id": 0, "datas_id": 0});
		print("child appended");
	else: 
		print("child already exist");
		return;
	var child_id = DataManager._get_child_database()[0].id;
	
	Singleton.database.update_rows("child", "id = %d" %child_id, {"pet_id": child_id, "datas_id": child_id});
	Singleton.database.insert_row("pet", {"id":child_id, "name": "", "body_id": 3,"hunger": 50, "eyes_id": 11, "mouth_id":21, "hat_id": 0, "color_id": 41});
	Singleton.database.insert_row("datas", {"id": child_id, "money": 10, "sequence_game_id": child_id, "number_memory_game_id": child_id, "timing_game_id": child_id });
	Singleton.database.insert_row("sequence_game", {"id": child_id, "total_session": 0, "highest_level": 0});
	Singleton.database.insert_row("number_memory_game", {"id": child_id, "total_session": 0, "highest_level": 0});
	Singleton.database.insert_row("timing_game", {"id": child_id, "total_session": 0, "highest_level": 0});
	Singleton.database.insert_row("milestone",{"id": child_id, "total_time": 0, "total_collection": 0, "total_pet_fully_fed": 0, "total_games_played": 0, "total_days_played": 0, "total_money_earned": 0});


func _on_button_button_up():
	var child_id = DataManager._get_child_database()[0].id
	
	if fname.text == "" or lname.text == "":
		print("please complete name")
	else:
		Singleton.database.update_rows("child", "id = %s" %child_id, {"fname": fname.text, "lname": lname.text})
		get_tree().change_scene_to_file("res://systems/create_pet/create_pet.tscn")
	
	pass # Replace with function body.

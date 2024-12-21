extends Node2D
@onready var fname = $Control/Panel/VBoxContainer/HBoxContainer/VBoxContainer1/Fname;
@onready var lname = $Control/Panel/VBoxContainer/HBoxContainer/VBoxContainer2/Lname;
@onready var transition_layer = $Transition_Layer;
@onready var message = $Control/Message;

func get_transition_layer():
	return transition_layer;

func _ready():
	pass

func child_create():
	Singleton.database.insert_row("child", {"fname": fname.text, "lname": lname.text, "pet_id": 0, "datas_id": 0, "status_id": 0, "disabled": 0});
	print("child appended");
	
	var child_id = Singleton.database.last_insert_rowid;
	
	print(child_id);
	
	Singleton.database.update_rows("child", "id = %d" %child_id, {"pet_id": child_id, "datas_id": child_id, "status_id": child_id, "disabled": 0});
	Singleton.database.insert_row("pet", {"id":child_id, "name": "", "body_id": 3,"hunger": 50, "eyes_id": 11, "mouth_id":21, "hat_id": 0, "color_id": 41});
	Singleton.database.insert_row("datas", {"id": child_id, "money": 0, "sequence_game_id": child_id, "number_memory_game_id": child_id, "timing_game_id": child_id });
	Singleton.database.insert_row("sequence_game", {"id": child_id, "total_session": 0, "highest_level": 0});
	Singleton.database.insert_row("number_memory_game", {"id": child_id, "total_session": 0, "highest_level": 0});
	Singleton.database.insert_row("timing_game", {"id": child_id, "total_session": 0, "highest_level": 0});
	Singleton.database.insert_row("milestone",{"id": child_id, "total_time": 0, "total_collection": 0, "total_pet_fully_fed": 0, "total_games_played": 0, "total_days_played": 0, "total_money_earned": 0});
	Singleton.database.insert_row("status", {"id": child_id, "redeem_status": 0, "fully_fed_status": 0});
	DataManager._update_milestone_total_days_played(child_id);

var able = true;

func _on_button_button_up():
	SoundPlayer.button_sfx();
	var child_id = Singleton.database.last_insert_rowid;
	
	if fname.text == "" or lname.text == "":
		message.text = "please complete name";
	else:
		if able:
			able = false;
			child_create()
			#Singleton.database.update_rows("child", "id = %s" %child_id, {"fname": fname.text, "lname": lname.text})
			await transition();
			GameData.transition_disappear = true;
			get_tree().change_scene_to_file("res://systems/child_settings/child_settings.tscn");
		
	pass # Replace with function body.

func transition():
	var transition_layer = get_tree().current_scene.get_transition_layer();
	await transition_layer.appear();

func _input(event):
	if fname.has_focus() || lname.has_focus():
		if event is InputEventKey and event.is_pressed():
			if event.keycode == KEY_ENTER:
				get_viewport().set_input_as_handled();







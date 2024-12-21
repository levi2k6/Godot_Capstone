extends Node2D


@onready var password = $Control/Panel/VBoxContainer/HBoxContainer/VBoxContainer1/Password
@onready var cpassword = $Control/Panel/VBoxContainer/HBoxContainer/VBoxContainer2/Cpassword

@onready var button = $Control/Panel/VBoxContainer/Button
@onready var message = $Control/Message
@onready var transition_layer = $Transition_Layer

func get_transition_layer():
	return transition_layer;

func _ready():
	#print(DataManager._get_parent_database());
	var parent = DataManager._get_parent_database();
	print(parent.size());
	if parent.size() == 0:
		Singleton.database.insert_row("parent", {"password": ""});
	else:
		print("parent already exists");


var able = true;

func _on_button_button_up():
	if password.text == "" || cpassword.text == "":
		message.text = "You need to fill up all of the text field.";
		return;
	
	if password.text == cpassword.text:
		if able:
			able = false;
			var parent_id = DataManager._get_parent_database()[0].id;
			Singleton.database.update_rows("parent", "id = %d" %parent_id, {"password": password.text});
			
			SoundPlayer.button_sfx();
			await transition();
			GameData.transition_disappear = true;
			get_tree().change_scene_to_file("res://systems/parent_dashboard/parent_dashboard.tscn");
	else:
		message.text = "Passwords are not identical.";
	pass # Replace with function body.

func transition():
	var transition_layer = get_tree().current_scene.get_transition_layer();
	await transition_layer.appear();

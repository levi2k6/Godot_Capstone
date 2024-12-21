extends Node2D

@onready var password = $Control/Panel/VBoxContainer/HBoxContainer/VBoxContainer1/Password

@onready var button = $Control/Panel/VBoxContainer/Button
@onready var message = $Control/Message
@onready var transition_layer = $Transition_Layer

func get_transition_layer():
	return transition_layer;

func _ready():
	pass

func _on_button_button_up():
	if password.text == "" :
		message.text = "You need to fill up all of the text field.";
		return;
	
	var parent = DataManager._get_parent_database();
	
	if password.text == parent[0].password:
		var parent_id = DataManager._get_parent_database()[0].id;
		Singleton.database.update_rows("parent", "id = %d" %parent_id, {"password": password.text});
		
		SoundPlayer.button_sfx();
		await transition();
		GameData.transition_disappear = true;
		get_tree().change_scene_to_file("res://systems/parent_dashboard/parent_dashboard.tscn");
	else:
		message.text = "Invalid Credentials.";

func transition():
	var transition_layer = get_tree().current_scene.get_transition_layer();
	await transition_layer.appear();
	pass # Replace with function body.

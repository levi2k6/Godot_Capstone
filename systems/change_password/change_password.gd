extends Node2D

@onready var password = $Control/Panel/VBoxContainer/HBoxContainer/VBoxContainer1/Password
@onready var cpassword = $Control/Panel/VBoxContainer/HBoxContainer/VBoxContainer2/Cpassword

@onready var button = $Control/Panel/VBoxContainer/Button
@onready var message = $Control/Message

@onready var transition_layer = $Transition_Layer

func get_transition_layer():
	return transition_layer;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_button_button_up():
	if password.text == "" || cpassword.text == "":
		message.text = "You need to fill up all of the text field.";
		return;
	
	if password.text == cpassword.text:
		var parent_id = DataManager._get_parent_database()[0].id;
		Singleton.database.update_rows("parent", "id = %d" %parent_id, {"password": password.text});
		message.text = "Password successfully changed.";
	else:
		message.text = "Passwords are not identical.";
	pass # Replace with function body.

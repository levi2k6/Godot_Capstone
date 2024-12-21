extends Panel
@onready var child_settings = $"../.."
@onready var options_modal = $"."

@onready var name_label = $VBoxContainer/Name_Label
@onready var fname = $VBoxContainer/VBoxContainer/Fname
@onready var lname = $VBoxContainer/VBoxContainer/Lname
@onready var rename = $VBoxContainer/VBoxContainer/Rename;
@onready var disable = $VBoxContainer/VBoxContainer/Disable;
@onready var delete = $VBoxContainer/VBoxContainer/Delete;
@onready var back = $VBoxContainer/VBoxContainer/Back
@onready var message = $Message;
@onready var delete_modal = $"../DeleteModal";


var child_data;




func child_data_append(id):
	var child = DataManager._get_child_database(id)[0];
	child_data = child;
	name_label.text ="%s %s"%[child_data.fname, child_data.lname];
	
	if child.disabled == 1:
		disable.text = "Enable";
	elif child.disabled == 0:
		disable.text = "Disable";

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_rename_button_down():
	if fname.text == "" || lname.text == "":
		message.text = "Don't leave any fields blank.";
		return
	
	Singleton.database.update_rows("child", "id = %s"%child_data.id, {"fname": fname.text, "lname": lname.text});
	message.text = "Name changed successfully.";
	var child = DataManager._get_child_database(child_data.id)[0];
	name_label.text = "%s %s"%[child.fname, child.lname];
	child_settings.populate_child_panels();
	pass # Replace with function body.
	

func _on_disable_button_up():
	var child = DataManager._get_child_database(child_data.id)[0];
	if child.disabled == 1:
		Singleton.database.update_rows("child", "id = %s"%child_data.id, {"disabled": 0});
		print(child.disabled);
		disable.text = "Disable";
		message.text = "Child enabled.";
	elif child.disabled == 0:
		Singleton.database.update_rows("child", "id = %s"%child_data.id, {"disabled": 1});
		print(child.disabled);
		disable.text = "Enable";
		message.text = "Child disabled.";
	
	pass # Replace with function body.

func _on_delete_button_up():
	delete_modal.visible = true;
	delete_modal.child_id = child_data.id;
	
	pass # Replace with function body.

func _on_back_button_down():
	child_data = null;
	options_modal.visible = false;
	pass # Replace with function body.

extends Node2D

@onready var panel = $Control/Panel
@onready var h_box_container = $Control/Panel/HBoxContainer
@onready var child_panel_hbox = $Control/Panel/HBoxContainer/child_panel_hbox
const CHILD_PANEL = preload("res://systems/child_settings/child_panel.tscn")
@onready var transition_layer = $Transition_Layer


func get_transition_layer():
	return transition_layer;

func _ready():
	populate_child_panels();

func populate_child_panels():
	var child_panels = child_panel_hbox.get_children();
	for child_panel in child_panels:
		child_panel.queue_free();
		
	
	var children = DataManager._get_all_child_database();
	print(children);
	for i in range(children.size()):
		var child_data = children[i];
		h_box_container.size.y += 120;
		var child_panel = CHILD_PANEL.instantiate();
		child_panel_hbox.add_child(child_panel);
		child_panel.toggle_options.connect(toggle_options);
		child_panel.id = i;
		child_panel.child_id = child_data.id;
		var ui_children = child_panel.get_ui_children();
		ui_children.label.text = child_data.fname +  " " + child_data.lname;


@onready var options_modal = $Control/OptionsModal
func toggle_options(child_id):
	options_modal.child_data_append(child_id);
	options_modal.visible = !options_modal.visible;

var able = true;

func _on_add_child_button_up():
	if able:
		able = false;
		SoundPlayer.button_sfx();
		await transition();
		GameData.transition_disappear = true;
		get_tree().change_scene_to_file("res://systems/create_child/create_child.tscn");
		pass # Replace with function body.

func transition():
	var transition_layer = get_tree().current_scene.get_transition_layer();
	await transition_layer.appear();


extends Node2D

@onready var panel = $Control/Panel;
@onready var child_panel_hbox = $Control/Panel/HBoxContainer/child_panel_hbox;
const CHILD_PANEL = preload("res://systems/choose_child/child_panel.tscn");
@onready var transition_layer = $Transition_Layer;

func get_transition_layer():
	return transition_layer;

func _ready():
	print("is this even the scene?");
	var children = DataManager._get_all_child_database();
	print(children);
	for i in range(children.size()):
		var child_data = children[i];
		panel.size.y += 120;
		var child_panel = CHILD_PANEL.instantiate();
		child_panel_hbox.add_child(child_panel);
		child_panel.id = i;
		child_panel.child_id = child_data.id;
		var ui_children = child_panel.get_ui_children();
		ui_children.label.text = child_data.fname +  " " + child_data.lname;
		
	var child_panels = child_panel_hbox.get_children();
	if child_panels.size() == 0:
		print("returning");
		return;
	for child_panel in child_panels:
		child_panel.change_to_stats.connect(change_to_stats);
		
	pass # Replace with function body.

var able = true;
func change_to_stats(child_id):
	if able:
		able = false;
		GameData.current_child_id = child_id;
		GameData.child_starts_playing();
		print(child_id);
		print(GameData.current_child_id);
		
		SoundPlayer.button_sfx();
		await transition();
		GameData.transition_disappear = true;
		get_tree().change_scene_to_file("res://systems/stats/stats.tscn");


func transition():
	var transition_layer = get_tree().current_scene.get_transition_layer();
	await transition_layer.appear();

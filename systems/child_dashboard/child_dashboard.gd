extends Node2D
@onready var panel = $Control/Panel;
@onready var child_panel_hbox = $Control/Panel/HBoxContainer/child_panel_hbox;
@onready var time = $Control/Time;
const CHILD_PANEL = preload("res://systems/child_dashboard/child_panel.tscn")
@onready var transition_layer = $Transition_Layer

func get_transition_layer():
	return transition_layer;

func _ready():
	check_time_limit();

func check_time_limit():
	var time_limit_data = DataManager._get_time_limit_database()[0];
	print(time_limit_data);
	if time_limit_data.start_time == "" || time_limit_data.end_time == "":
		populate_child_panel(false)
		return;
	
	var within_state = Modules.get_restriction().is_time_within_range(time_limit_data.start_time, time_limit_data.end_time);
	if within_state:
		time.show_time();
	else:
		print("time is not within");
	populate_child_panel(within_state);

func populate_child_panel(within_state):
	var children = DataManager._get_all_child_database();
	for i in range(children.size()):
		var child_data = children[i];
		panel.size.y += 120;
		var child_panel = CHILD_PANEL.instantiate();
		child_panel_hbox.add_child(child_panel);
		child_panel.id = i;
		child_panel.child_id = child_data.id;
		if within_state:
			child_panel.get_ui_children().button.disabled = true;
		if child_data.disabled == 1:
			child_panel.get_ui_children().button.disabled = true;
		var ui_children = child_panel.get_ui_children();
		ui_children.label.text = child_data.fname +  " " + child_data.lname;
		
	var child_panels = child_panel_hbox.get_children();
	if child_panels.size() == 0:
		print("returning");
		return;
	for child_panel in child_panels:
		child_panel.play_game.connect(play_game);
	pass # Replace with function body.

var able = true;

func play_game(child_id):
	
	GameData.current_child_id = child_id;
	GameData.child_starts_playing();
	print(child_id);
	print(GameData.current_child_id);
	
	var current_pet = DataManager._get_current_pet()[0];
	if current_pet.name == "":
		if able:
			able = false;
			SoundPlayer.button_sfx();
			await transition();
			GameData.transition_disappear = true;
			get_tree().change_scene_to_file("res://systems/create_pet/create_pet.tscn");
			return;
	
	if able:
		able = false;
		SoundPlayer.button_sfx();
		await transition();
		GameData.transition_disappear = true;
		get_tree().change_scene_to_file("res://systems/main_hub/main_hub.tscn");

func transition():
	var transition_layer = get_tree().current_scene.get_transition_layer();
	await transition_layer.appear();

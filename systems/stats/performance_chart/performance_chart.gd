extends Node2D

@onready var stats_panel_container = $Control/Stats_Chart/VBoxContainer/HBoxContainer/StatsPanelContainer
@onready var panel = $Control/Stats_Chart/VBoxContainer/HBoxContainer/StatsPanelContainer/Panel

@onready var line_2d_all = $Control/Stats_Chart/VBoxContainer/HBoxContainer/StatsPanelContainer/Panel/Line2D_All
@onready var line_2d_normal = $Control/Stats_Chart/VBoxContainer/HBoxContainer/StatsPanelContainer/Panel/Line2D_Normal
@onready var line_2d_hard = $Control/Stats_Chart/VBoxContainer/HBoxContainer/StatsPanelContainer/Panel/Line2D_Hard

@onready var points_all = $Control/Stats_Chart/VBoxContainer/HBoxContainer/StatsPanelContainer/Panel/Points_All
@onready var points_normal = $Control/Stats_Chart/VBoxContainer/HBoxContainer/StatsPanelContainer/Panel/Points_Normal
@onready var points_hard = $Control/Stats_Chart/VBoxContainer/HBoxContainer/StatsPanelContainer/Panel/Points_Hard

@onready var right_scroll_container = $Control/Stats_Chart/VBoxContainer/RightScrollContainer
@onready var right_numbers = $Control/Stats_Chart/VBoxContainer/RightScrollContainer/RightNumbers

@onready var drawer = $drawer;
@onready var up_drawer = $Control/Stats_Chart/VBoxContainer/HBoxContainer/UpScrollContainer/UpDrawer
@onready var right_drawer = $Control/Stats_Chart/VBoxContainer/RightScrollContainer/RightDrawer

@onready var all_visible = $Control/Difficulty_Info/Difficulty_Filter/AllContainer/All_Visible
@onready var visible_icon_1 = $Control/Difficulty_Info/Difficulty_Filter/AllContainer/All_Visible/Visible_Icon1

@onready var normal_visible = $Control/Difficulty_Info/Difficulty_Filter/NormalContainer/Normal_Visible
@onready var visible_icon_2 = $Control/Difficulty_Info/Difficulty_Filter/NormalContainer/Normal_Visible/Visible_Icon2

@onready var hard_visible = $Control/Difficulty_Info/Difficulty_Filter/HardContainer/Hard_Visible
@onready var visible_icon_3 = $Control/Difficulty_Info/Difficulty_Filter/HardContainer/Hard_Visible/Visible_Icon3

@onready var soda_tiles = $Control/Games/SodaTiles
@onready var digit_hack = $"Control/Games/Digit Hack"
@onready var meteor_rush = $"Control/Games/Meteor Rush"

var scroll_moving = false;

@onready var zoom_in = $Control/Stats_Chart/above_panel/Zoom/ZoomIn
@onready var zoom_out = $Control/Stats_Chart/above_panel/Zoom/ZoomOut

@onready var transition_layer = $Transition_Layer

func get_transition_layer():
	return transition_layer;

func _ready():
	zoom_in.disabled = true;
	zoom_out.disabled = true;
	normal_hard_disable(true);
	pass

func _process(delta):
	if right_scroll_container.scroll_horizontal != stats_panel_container.scroll_horizontal:
		right_scroll_container.scroll_horizontal = stats_panel_container.scroll_horizontal; 


func _on_zoom_in_button_down():
	SoundPlayer.button_sfx();
	if panel.custom_minimum_size.x != 450:
		panel.custom_minimum_size.x -= 50;
		right_numbers.custom_minimum_size.x = panel.custom_minimum_size.x;
		drawer.create_origin();
		right_drawer.create_origin();
	pass # Replace with function body.


func _on_zoom_out_button_down():
	SoundPlayer.button_sfx();
	panel.custom_minimum_size.x += 50;
	right_numbers.custom_minimum_size.x = panel.custom_minimum_size.x;
	drawer.create_origin();
	right_drawer.create_origin();
	#print_debug("panel: " , panel.custom_minimum_size.x);
	#print_debug("right_numbers: ", right_numbers.custom_minimum_size.x);
	
	pass # Replace with function body.


func _panel_size_reset():
	panel.custom_minimum_size.x = 450;
	right_numbers.custom_minimum_size.x = 450;

#games////////////////////////////////////////////////
func _on_sequence_mix_button_down():
	SoundPlayer.button_sfx();
	_panel_size_reset();
	drawer.current_game = "game1";
	right_drawer.current_game = "game1";
	up_drawer.current_game = "game1";
	drawer.create_origin();
	right_drawer.create_origin();
	up_drawer.create_origin();
	button_pressed_state();
	pass # Replace with function body.

func _on_digit_hack_button_down():
	SoundPlayer.button_sfx();
	_panel_size_reset();
	drawer.current_game = "game2";
	right_drawer.current_game = "game2";
	up_drawer.current_game = "game2";
	drawer.create_origin();
	right_drawer.create_origin();
	up_drawer.create_origin();
	button_pressed_state();
	pass # Replace with function body.

func _on_meteor_rush_button_down():
	SoundPlayer.button_sfx();
	_panel_size_reset();
	drawer.current_game = "game3";
	right_drawer.current_game = "game3";
	up_drawer.current_game = "game3";
	drawer.create_origin();
	right_drawer.create_origin();
	up_drawer.create_origin();
	button_pressed_state();
	pass # Replace with function body.


func button_pressed_state():
	soda_tiles.button_pressed = false;
	digit_hack.button_pressed = false;
	meteor_rush.button_pressed = false;


func _on_scroll_container_scroll_started():
	scroll_moving = true;
	pass # Replace with function body.

var all_show= true;
var normal_show = false;
var hard_show = false;

func _on_all_visible_button_down():
	SoundPlayer.button_sfx();
	all_show = !all_show;
	if all_show:
		visible_icon_1.frame = 0;
		normal_hard_disable(all_show);
		line_2d_all.visible = true;
		points_all.visible = true;
	else:
		visible_icon_1.frame = 1;
		normal_hard_disable(all_show);
		line_2d_all.visible = false;
		points_all.visible = false;
	pass # Replace with function body.

func normal_hard_disable(all_show):
	if all_show:
		normal_visible.disabled = true;
		hard_visible.disabled = true;
		normal_show = true;
		_on_normal_visible_button_down2();
		hard_show = true;
		_on_hard_visible_button_down2();
	else:
		normal_visible.disabled = false;
		hard_visible.disabled = false;
		normal_show = false;
		_on_normal_visible_button_down2();
		hard_show = false;
		_on_hard_visible_button_down2();

func _on_normal_visible_button_down():
	SoundPlayer.button_sfx();
	normal_show = !normal_show;
	if normal_show:
		visible_icon_2.frame = 0;
		line_2d_normal.visible = true;
		points_normal.visible = true;
	else:
		visible_icon_2.frame = 1;
		line_2d_normal.visible = false;
		points_normal.visible = false;
	pass # Replace with function body.


func _on_hard_visible_button_down():
	SoundPlayer.button_sfx();
	hard_show = !hard_show;
	if hard_show:
		visible_icon_3.frame = 0;
		line_2d_hard.visible = true;
		points_hard.visible = true;
	else:
		visible_icon_3.frame = 1;
		line_2d_hard.visible = false;
		points_hard.visible = false;
	pass # Replace with function body.


#//////////////////////////////////////////////////////
func _on_normal_visible_button_down2():
	normal_show = !normal_show;
	if normal_show:
		visible_icon_2.frame = 0;
		line_2d_normal.visible = true;
		points_normal.visible = true;
	else:
		visible_icon_2.frame = 1;
		line_2d_normal.visible = false;
		points_normal.visible = false;
	pass # Replace with function body.


func _on_hard_visible_button_down2():
	hard_show = !hard_show;
	if hard_show:
		visible_icon_3.frame = 0;
		line_2d_hard.visible = true;
		points_hard.visible = true;
	else:
		visible_icon_3.frame = 1;
		line_2d_hard.visible = false;
		points_hard.visible = false;
	pass # Replace with function body.


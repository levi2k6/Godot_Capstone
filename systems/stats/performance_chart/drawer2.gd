extends Node2D
const POINT_NODE = preload("res://systems/stats/performance_chart/point_node.tscn")

@onready var panel = $"../Control/Stats_Chart/VBoxContainer/HBoxContainer/StatsPanelContainer/Panel"

@onready var line_2d_all = $"../Control/Stats_Chart/VBoxContainer/HBoxContainer/StatsPanelContainer/Panel/Line2D_All"
@onready var line_2d_normal = $"../Control/Stats_Chart/VBoxContainer/HBoxContainer/StatsPanelContainer/Panel/Line2D_Normal"
@onready var line_2d_hard = $"../Control/Stats_Chart/VBoxContainer/HBoxContainer/StatsPanelContainer/Panel/Line2D_Hard"

@onready var points_all = $"../Control/Stats_Chart/VBoxContainer/HBoxContainer/StatsPanelContainer/Panel/Points_All"
@onready var points_normal = $"../Control/Stats_Chart/VBoxContainer/HBoxContainer/StatsPanelContainer/Panel/Points_Normal"
@onready var points_hard = $"../Control/Stats_Chart/VBoxContainer/HBoxContainer/StatsPanelContainer/Panel/Points_Hard"

@onready var difficulty_number = $"../Control/Difficulty_Info/Difficulty_Number"
@onready var game_description = $"../Control/Game_Description"
@onready var interpretation = $"../Control/Interpretation"
@onready var rich_text_label = $"../Control/Interpretation/RichTextLabel"

#@onready var origin = $"../Origin";


var center = Vector2();
var up = Vector2();
var right = Vector2();


var current_game;
var all = false;
var max_length;

var okay;

func _ready():
	pass

func clear_line_datas():
	for child in points_all.get_children():
		child.queue_free();
	for child in points_normal.get_children():
		child.queue_free();
	for child in points_hard.get_children():
		child.queue_free();
	
	for i in range(line_2d_all.get_point_count() - 1, -1, -1):
		if i == 0:
			continue;
		line_2d_all.remove_point(i);
	
	for i in range(line_2d_normal.get_point_count() - 1, -1, -1):
		if i == 0:
			continue;
		line_2d_normal.remove_point(i);
	
	for i in range(line_2d_hard.get_point_count() - 1, -1, -1):
		if i == 0:
			continue;
		line_2d_hard.remove_point(i);

func create_origin():
	var child = DataManager._get_child_database();
	if child.size() == 0:
		print_debug("child does not exist");
		return;
	
	
	clear_line_datas();
	var center_x = panel.global_position.x;
	var center_y = panel.global_position.y + panel.custom_minimum_size.y;
	center = Vector2(center_x, center_y);
	
	up = center - Vector2(0, panel.custom_minimum_size.y);
	right = center + Vector2(panel.custom_minimum_size.x, 0);
	show_game_stats_dynamic();
	okay = true;
	queue_redraw();

func show_game_stats_dynamic():
	var session_datas_all = [];
	var session_datas_normal = [];
	var session_datas_hard = [];
	var highest_level;
	
	if current_game == "game1":
		session_datas_all = DataManager._get_game_sessions("sequence", null);
		session_datas_normal = DataManager._get_game_sessions("sequence", "normal");
		session_datas_hard = DataManager._get_game_sessions("sequence" , "hard");
		highest_level = DataManager._get_game_dynamic("sequence_game")[0].highest_level;
	elif current_game == "game2":
		session_datas_all = DataManager._get_game_sessions("number_memory", null);
		session_datas_normal = DataManager._get_game_sessions("number_memory", "normal");
		session_datas_hard = DataManager._get_game_sessions("number_memory" , "hard");
		highest_level = DataManager._get_game_dynamic("number_memory_game")[0].highest_level;
	elif current_game == "game3":
		session_datas_all = DataManager._get_game_sessions("timing", null);
		session_datas_normal = DataManager._get_game_sessions("timing", "normal");
		session_datas_hard = DataManager._get_game_sessions("timing" , "hard");
		highest_level = DataManager._get_game_dynamic("timing_game")[0].highest_level;
	
	var range = length_check();
	
	if range == null:
		print_debug("range is null");
		return
	
	if highest_level == 0 || highest_level == null:
		print_debug("highest_level == empty");
		rich_text_label.text = "Interpretation: ...";
		return;
	
	
	difficulty_number.set_text(session_datas_all.size(), "all");
	difficulty_number.set_text(session_datas_normal.size(), "normal");
	difficulty_number.set_text(session_datas_hard.size(), "hard");
	game_description.show_description();
	interpretation.interpret();
	
	set_length_max_size(session_datas_all, range);
	
	await range_check(session_datas_all, highest_level, range, "all");
	await range_check(session_datas_normal, highest_level, range, "normal");
	await range_check(session_datas_hard, highest_level, range, "hard");

@onready var zoom_in = $"../Control/Stats_Chart/above_panel/Zoom/ZoomIn"
@onready var zoom_out = $"../Control/Stats_Chart/above_panel/Zoom/ZoomOut"

func set_length_max_size(session_datas, range):
	var range_multiple = 0;
	for i in range(1, range+1):
			range_multiple += range;
			if session_datas.size() <= range_multiple:
				#print("working");
				break;
	
	var range_divide = (range_multiple + 20) / 20;
	max_length = (450 * range_divide) - 50;
	#print("length: " , panel.custom_minimum_size.x);
	#print("max_length:" , max_length);
	if panel.custom_minimum_size.x == max_length:
		zoom_out.disabled = true;
	else:
		zoom_out.disabled = false;
	if panel.custom_minimum_size.x == 450:
		zoom_in.disabled = true;
	else:
		zoom_in.disabled = false;

func length_check():
	var length = int(panel.custom_minimum_size.x);
	var times_amount = length / 450;
	var times_modulo =  length % 450;
	if times_modulo != 0:
		var floor_times_amount = floor(times_amount);
		var range_limit = 20 * floor_times_amount;
		max_length = floor_times_amount ^ 450;
		#print("max_length: " , max_length);
		return range_limit;
	
	var range_limit = 20 * times_amount;
	return range_limit;


var range_times = 0;
func range_check(session_datas, highest_level, range, type):
	if session_datas.size() == 0:
		print_debug(type, ": there aren't any datas");
		return;
	
	
	var b = 0;
	if type == "all":
		range_times = 0;
		for i in range(1, range+1):
			range_times += range;
			if session_datas.size() <= range_times:
				for data in session_datas:
					b+=1;
					renderer(data, highest_level, range_times, type, b); 
				return;
	
	if session_datas.size() <= range || session_datas.size() > range:
		for data in session_datas:
			b+=1;
			renderer(data, highest_level, range_times, type, b); 
		return;
	

func renderer(data, highest_level, range, type, b):
	var point_position = Vector2();
	point_position.y = point_pos_marker_y(highest_level, data.level_reached);
	point_position.x = point_pos_marker_x(range, b);
	var point_node = POINT_NODE.instantiate();
	if type == "all":
		points_all.add_child(point_node);
		point_node.global_position = point_position;
		line_2d_all.add_point(point_node.position);
	elif type == "normal":
		points_normal.add_child(point_node);
		point_node.global_position = point_position;
		line_2d_normal.add_point(point_node.position);
	elif type == "hard":
		points_hard.add_child(point_node);
		point_node.global_position = point_position;
		line_2d_hard.add_point(point_node.position);
	pass

func point_pos_marker_x(range, b):
	var right_length = right.x - center.x;
	var right_divide = right_length / (range+1);
	var point_position_x = center.x + (b * right_divide);
	return point_position_x;
	pass

func point_pos_marker_y(point_count_up, level_at):
	var up_length = up.y - center.y;
	var up_divide = up_length / (point_count_up+1);
	var point_position_y = center.y + (level_at * up_divide);
	return point_position_y;
	pass


func _draw():
	var center_x = center.x + -5;
	var center_y = center.y + +5;
	
	if okay == true:
		draw_circle(Vector2(center_x, center_y), 5, Color(1,1,1));
		draw_line(Vector2(center_x, center_y), Vector2(510, center_y), Color(1,1,1));
		draw_line(Vector2(center_x, center_y), Vector2(center_x, up.y), Color(1,1,1));


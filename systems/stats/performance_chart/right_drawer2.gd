extends Node2D
const POINT_RIGHT_NODE = preload("res://systems/stats/performance_chart/point_right_node.tscn")

@onready var panel = $"../../HBoxContainer/StatsPanelContainer/Panel"

@onready var right_numbers = $"../RightNumbers"
#@onready var drawer = $"../../../../../drawer"



#@onready var icon = $"../Icon";
#@onready var icon_2 = $"../../Icon2";
#@onready var origin = $"../../../Origin";




var center = Vector2();
var right = Vector2();

var current_game;

func _ready():
	print(length_check());
	pass

func create_origin():
	var child_database = DataManager._get_current_child();
	if child_database.size() == 0:
		print_debug("child does not exist");
		return;
	
	
	for child in right_numbers.get_children():
		child.queue_free();
	
	var center_x = right_numbers.global_position.x;
	var center_y = right_numbers.global_position.y;
	center = Vector2(center_x, center_y);
	right = center + Vector2(right_numbers.custom_minimum_size.x, 0);
	show_game_stats_dynamic();

func show_game_stats_dynamic():
	var session_datas = [];
	if current_game == "game1":
		session_datas = DataManager._get_game_sessions("sequence", null);
	elif current_game == "game2":
		session_datas = DataManager._get_game_sessions("number_memory", null);
	elif current_game == "game3":
		session_datas = DataManager._get_game_sessions("timing", null);
	
	if session_datas.size() == 0 || session_datas.size() == null:
		print("There aren't any datas");
		for child in right_numbers.get_children():
			child.queue_free();
		return;
	
	var range = length_check();
	
	if range == null:
		print("range is empty");
		return;
		
	range_check(session_datas, range);

func length_check():
	var length = int(panel.custom_minimum_size.x);
	#print("length: " , length);
	var times_amount = length / 450;
	var times_modulo =  length % 450;
	if times_modulo != 0:
		var floor_times_amount = floor(times_amount);
		var range_limit = 20 * floor_times_amount;
		return range_limit;
	
	var range_limit = 20 * times_amount;
	return range_limit;

func range_check(session_datas, range):
	
	var range_times = 0;
	var b = 0;
	if session_datas.size() < range:
		#print("IT IS BELLOW RANGE!");
		for i in range(1, range+1):
			b+=1;
			renderer(range, b);
		return;
	
	#print("IT IS HIGHER THAN RANGE!");
	for i in range(1, range+1):
		range_times += range;
		if session_datas.size() <= range_times:
			for a in range(1, range+1):
				b+=i;
				renderer(range_times, b)
			return


func renderer(range, b):
	var point_position = point_pos_marker_x(range, b);
	var point_right_node = POINT_RIGHT_NODE.instantiate();
	point_right_node.change_number(b);
	right_numbers.add_child(point_right_node);
	point_right_node.global_position = point_position;
	pass


func point_pos_marker_x(point_count_right, b):
	var right_length = right.x - center.x;
	var right_divide = right_length / (point_count_right + 1);
	var point_position_x = center.x + (b * right_divide);
	var point_position = Vector2(point_position_x, center.y + 5);
	#icon_2.position = point_position;
	return point_position
	pass

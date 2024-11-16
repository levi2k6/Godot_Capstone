extends Node2D

const POINT_UP_NODE = preload("res://systems/stats/performance_chart/point_up_node.tscn")
@onready var up_numbers = $"../UpNumbers"
@onready var icon_2 = $"../../Icon2"

var center = Vector2();
var up = Vector2();

var current_game;

func _ready():
	pass

func create_origin():
	var child = DataManager._get_child_database();
	if child.size() == 0:
		print_debug("child does not exist");
		return;
	
	var center_x = up_numbers.global_position.x;
	var center_y = up_numbers.global_position.y + up_numbers.custom_minimum_size.y;
	center = Vector2(center_x, center_y);
	up = center + Vector2(0, -up_numbers.custom_minimum_size.y);
	icon_2.position = up;
	show_game_stats_dynamic();

func show_game_stats_dynamic():
	var highest_level;
	
	if current_game == "game1":
		highest_level = DataManager._get_game_dynamic("sequence_game")[0].highest_level;
	elif current_game == "game2":
		highest_level = DataManager._get_game_dynamic("number_memory_game")[0].highest_level;
	elif current_game == "game3":
		highest_level = DataManager._get_game_dynamic("timing_game")[0].highest_level;
	
	if highest_level == 0 || highest_level == null:
		for child in up_numbers.get_children():
			child.queue_free();
		return;
	
	renderer(highest_level);

func renderer(highest_level):
	for child in up_numbers.get_children():
		child.queue_free();
	
	var b = 0;
	for i in range(highest_level):
		b+=1;
		var point_position = create_point_y(highest_level, b);
		var point_up_node = POINT_UP_NODE.instantiate();
		point_up_node.change_number(b);
		up_numbers.add_child(point_up_node);
		point_up_node.global_position = point_position;
		#print("point_node: " , point_node.global_position);
	pass

func create_point_y(point_count_up, b):
	var up_length = up.y - center.y;
	var up_divide = up_length / (point_count_up + 1);
	var point_position_y = center.y + (b * up_divide);
	var point_position = Vector2(center.x + 40, point_position_y);
	return point_position;
	pass




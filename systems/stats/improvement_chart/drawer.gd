extends Node2D
const POINT_NODE = preload("res://systems/stats/improvement_chart/point_node.tscn")
@onready var panel = $"../Control/ScrollContainer/Panel";
@onready var points = $"../Control/ScrollContainer/Panel/Points"
@onready var line_2d = $"../Control/ScrollContainer/Panel/Line2D"
@onready var origin = $"../Origin"

@onready var icon = $"../Icon"

var center = Vector2();
var up = Vector2();
var right = Vector2();

var point_position = Vector2();

var current_game;

func _ready():
	create_origin();


func create_origin():
	for child in points.get_children():
		child.queue_free()
	
	for i in range(line_2d.get_point_count() - 1, -1, -1):
		if i == 0:
			continue;
		line_2d.remove_point(i);
	
	var center_x = panel.global_position.x;
	var center_y = panel.global_position.y + panel.custom_minimum_size.y;
	center = Vector2(center_x, center_y);
	up = center - Vector2(0, panel.custom_minimum_size.y);
	right = center + Vector2(panel.custom_minimum_size.x, 0);
	
	origin.position = center;
	show_game_stats_dynamic();
	

func show_game_stats_dynamic():
	var session_datas = [];
	if current_game == "game1":
		session_datas = DataManager._get_game1_junction_session();
	elif current_game == "game2":
		session_datas = DataManager._get_game2_junction_session();
	elif current_game == "game3":
		session_datas = DataManager._get_game3_junction_session();
	
	if session_datas.size() == 0:
		print("There aren't any datas");
		return;
	
	var highest_level;
	var session_count = session_datas.size();
	
	if current_game == "game1":
		highest_level = DataManager._get_game_dynamic("sequence_game")[0].highest_level;
	elif current_game == "game2":
		highest_level = DataManager._get_game_dynamic("number_memory_game")[0].highest_level;
	elif current_game == "game3":
		highest_level = DataManager._get_game_dynamic("timing_game")[0].highest_level;
	renderer(session_datas, highest_level, session_count);

func renderer(session_datas, highest_level, session_count):
	var i = 0;
	for data in session_datas:
		i += 1;
		point_pos_marker_y(highest_level, data.level_reached);
		point_pos_marker_x(session_count, i);
		var point_node = POINT_NODE.instantiate();
		points.add_child(point_node);
		point_node.global_position = point_position;
		line_2d.add_point(point_node.position);
		#print("local: ", point_node.position, " global: ", point_node.global_position);

func point_pos_marker_y(point_count_up, level_at):
	var up_length = up.y - center.y;
	var up_divide = up_length / (point_count_up+1);
	var point_position_y = center.y + (level_at * up_divide);
	point_position.y = point_position_y;
	pass

func point_pos_marker_x(point_count_right, i):
	var right_length = right.x - center.x;
	var right_divide = right_length / (point_count_right+1);
	var point_position_x = center.x + (i * right_divide);
	point_position.x = point_position_x;
	pass

#func _draw():
	#draw_line(center, up, Color(1,1,1));
	#draw_line(center, right, Color(1,1,1));
	#draw_circle(point_position, 10, Color(1,1,1));
	#pass


extends Node2D
const POINT_NODE = preload("res://systems/stats/improvement_chart/point_node.tscn")
@onready var drawer = $"../../../drawer";
@onready var right_numbers = $"../RightNumbers"
@onready var icon = $"../../../Icon"

var center = Vector2();
var right = Vector2();
var point_position;
func _ready():
	center = global_position;
	right = center + Vector2(right_numbers.custom_minimum_size.x, 0);
	icon.position = right;
	print("this is right: " , right);
	print(right_numbers.custom_minimum_size.x);
	
	var array_length = 50;
	var b = 0;
	for i in range(array_length):
		b+=1;
		point_pos_marker_x(array_length, i);
		print(point_position);
		var point_node = POINT_NODE.instantiate();
		right_numbers.add_child(point_node);
		point_node.position = point_position;
		
	
	

func point_pos_marker_x(point_count_right, i):
	var right_length = right.x - center.x;
	var right_divide = right_length / (point_count_right+1);
	var point_position_x = center.x + (i * right_divide);
	point_position = Vector2(point_position_x, center.y);
	pass


func _draw():
	print("working");
	draw_line(center, right, Color(1,1,1));
	draw_circle(center, 30, Color(1,1,1));

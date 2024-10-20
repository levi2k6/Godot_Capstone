extends Node2D


var center = Vector2(50, 50);
var right_end = Vector2(500, 50);

var right_length = center.x - right_end.x;
var right_divide = abs(right_length) / 3;
var point_position_x = center.x + (right_divide * 0);


func _ready():
	
	print(right_end);
	print(right_length);
	print(right_divide);
	print(point_position_x);
	
	
	pass



func _draw():
	draw_line(center, right_end, Color(1,1,1));
	draw_circle(Vector2(point_position_x, 50), 10, Color(1,1,1));





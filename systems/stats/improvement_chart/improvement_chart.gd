extends Node2D
@onready var scroll_container = $Control/ScrollContainer
@onready var panel = $Control/ScrollContainer/Panel;
var scroll_moving = false;

@onready var right_scroll_container = $Control/RightScrollContainer
@onready var right_numbers = $Control/RightScrollContainer/RightNumbers

@onready var drawer = $drawer;

func _ready():
	pass

func _process(delta):
	if right_scroll_container.scroll_horizontal != scroll_container.scroll_horizontal:
		right_scroll_container.scroll_horizontal = scroll_container.scroll_horizontal; 
		print("working");

func _on_zoom_in_button_down():
	panel.custom_minimum_size.x += 50;
	right_numbers.custom_minimum_size.x = panel.custom_minimum_size.x;
	drawer.create_origin();
	pass # Replace with function body.


func _on_zoom_out_button_down():
	if panel.custom_minimum_size.x != 450:
		panel.custom_minimum_size.x -= 50;
		right_numbers.custom_minimum_size.x = panel.custom_minimum_size.x;
		drawer.create_origin();
	
	pass # Replace with function body.

func _on_sequence_mix_button_down():
	drawer.current_game = "game1";
	drawer.create_origin();
	pass # Replace with function body.

func _on_digit_hack_button_down():
	drawer.current_game = "game2";
	drawer.create_origin();
	pass # Replace with function body.

func _on_meteor_rush_button_down():
	drawer.current_game = "game3";
	drawer.create_origin();
	pass # Replace with function body.

func _on_scroll_container_scroll_started():
	print("hello");
	scroll_moving = true;
	pass # Replace with function body.

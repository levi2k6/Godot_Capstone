extends ScrollContainer


var inside = false;
var scrolling = false;

var old_position_y;

func _ready():
	old_position_y = get_global_mouse_position().y

func _input(event):
	if inside == false:
		return;
	if event is InputEventScreenTouch:
		if event.is_pressed():
			scrolling = true;
			print("scrolling true");
		if event.is_released():
			scrolling = false;
			print("scrolling false");

func _process(delta):
	if scrolling == true:
		if old_position_y > get_global_mouse_position().y:
			print("up");
			old_position_y = get_global_mouse_position().y; 
		elif old_position_y < get_global_mouse_position().y:
			print("down");
			old_position_y = get_global_mouse_position().y;

func _on_mouse_entered():
	inside = true;
	print(inside);
	pass # Replace with function body.

func _on_mouse_exited():
	inside = false;
	print(inside);
	pass # Replace with function body.

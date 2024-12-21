extends Panel
signal toggle_options(child_id);

var id: int;
var child_id: int;
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_texture_rect_button_down():
	
	emit_signal("toggle_options", child_id);
	pass # Replace with function body.




@onready var button = $HBoxContainer/Button;
@onready var label = $HBoxContainer/Label;

func get_ui_children():
	var children = {"button": button, "label": label};
	return children;

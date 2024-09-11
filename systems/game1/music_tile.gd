extends PanelContainer

@onready var timer = $"../../Timer"



func _on_gui_input(event):
	if event is InputEventMouseButton || event is InputEventScreenTouch:
		if event.is_pressed():
			get_parent().get_parent().click_tile(self, name);
			
			
	pass # Replace with function body.
	

func animation():
	$Sprite2D.modulate = "2e74e2";
	timer.start(0.2);
	await timer.timeout;
	$Sprite2D.modulate = Color(1,1,1);
	

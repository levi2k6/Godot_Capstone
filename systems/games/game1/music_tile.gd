extends TextureButton;

@onready var timer = $"../../Timer"


func animation():
	$Sprite2D.modulate = "2e74e2";
	timer.start(0.2);
	await timer.timeout;
	$Sprite2D.modulate = Color(1,1,1);
	




func _on_button_down():
	get_parent().get_parent().click_tile(self, name);
	pass # Replace with function body.

extends Control
@onready var v_box_container = $Game_Intro/VBoxContainer
@onready var game_intro = $Game_Intro

func _ready():
	var viewport_size = get_viewport().get_visible_rect().size;
	size = viewport_size;
	
	var value_percent = size.y * 0.25;
	var position_percent = (-size.y + -value_percent);
	position.y = position_percent;
	print("look at here yow: " , position.y);


func intro_appear():
	for child in v_box_container.get_children():
		child.disabled = true;
	
	var position_percent = size.y * 0.25;
	position.y = (-size.y + -position_percent);
	var tween = get_tree().create_tween();
	tween.set_trans(Tween.TRANS_CUBIC);
	tween.set_ease(Tween.EASE_OUT);
	tween.tween_property(self, "position", Vector2.ZERO , 2);
	await tween.finished
	
	for child in v_box_container.get_children():
		child.disabled = false;
	print("tween finished");

func intro_leave():
	for child in v_box_container.get_children():
		child.disabled = true;
	
	var value_percent = size.y + 0.25;
	var position_percent = (-size.y + -value_percent);
	position.y = 0;
	var tween = get_tree().create_tween();
	tween.set_trans(Tween.TRANS_CUBIC);
	tween.set_ease(Tween.EASE_IN);
	tween.tween_property(self, "position", Vector2(0, position_percent), 2);
	await tween.finished;
	print("tween finished");

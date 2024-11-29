extends Control

@onready var color_rect = $ColorRect
@onready var animator = $Animator


func _ready():
	var current_scene = get_tree().current_scene.name;
	if current_scene != "Game3":
		var viewport_size = get_viewport().get_visible_rect().size;
		size = viewport_size;
	
	if current_scene == "Game2":
		size.y += 300;
	
	if GameData.transition_disappear == false:
		return;
	
	if GameData.transition_disappear == true:
		animator.play("cover");
		await animator.animation_finished;
		await disappear();
		GameData.transition_disappear = false;


func get_animator():
	return animator;

func appear():
	animator.play("transition_appear");
	await animator.animation_finished;

func disappear():
	animator.play("transition_disappear");
	await animator.animation_finished;



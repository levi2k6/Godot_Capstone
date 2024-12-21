extends Node2D

@onready var timer = $Timer

@onready var animator = $Animator
@onready var animator_title = $Control/Title/Animator_Title;
@onready var animator_buttons = $Control/Buttons/Animator_Buttons;

@onready var title = $Control/Title;
@onready var buttons = $Control/Buttons;
@onready var transition_layer = $Transition_Layer


@onready var child_dashboard_button = $Control/Buttons/Child_Dashboard_Button


func get_transition_layer():
	return transition_layer;

func _ready():
	GameData.last_scene = "res://systems/game_menu/game_menu.tscn";
	SoundPlayer.play_bgm_music();
	_execute()
	pass

func _execute():
	animation();

func animation():
	await animator.title_animation();
	show_button("else");


func show_button(button_state):
	child_dashboard_button.visible = true
	animator_buttons.play("main_hub_button_up");



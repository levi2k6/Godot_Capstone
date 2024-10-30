extends AnimationPlayer

@onready var back = $"../Background/ParallaxLayer/Back"

@onready var casing = $"../Foreground/Casing";
@onready var monitor_1 = $"../Foreground/Monitor1";
@onready var monitor_1_output = $"../Foreground/Monitor1/Monitor1_Output";
@onready var monitor_2 = $"../Foreground/Monitor2";
@onready var monitor_2_output = $"../Foreground/Monitor2/Monitor2_Output";

@onready var animator_engine = $"../Foreground/Casing/Engine/AnimatorEngine"

@onready var electric = $"../Electric"
@onready var animator_electric = $"../Electric/AnimatorElectric"

@onready var game = $"../Game";
@onready var timer = $"../Game/Timer";


const LIGHTS_OFF = preload("res://assets/game2/backgrounds/lights_off.png")
const LIGHTS_ON_2 = preload("res://assets/game2/backgrounds/lights_on2.png")

func _ready():
	pass

func reset():
	timer.start(1);
	await timer.timeout;
	animator_engine.play("engine_off");
	monitor_1_output.text = "";
	monitor_2.modulate = "ffffff";
	back.texture = LIGHTS_OFF;
	casing.modulate = "808080";
	play("first_monitor_off");
	await animation_finished;
	play("second_monitor_off");


func intro():
	back.texture = LIGHTS_ON_2;
	casing.modulate = "ffffff";
	timer.start(1);
	await timer.timeout;
	animator_engine.play("engine_on");
	timer.start(1);
	await timer.timeout;
	
	play("first_monitor_on");
	timer.start(1);
	await timer.timeout;
	
	game.start();
	timer.start(3);
	await timer.timeout;
	electric.emitting = true;
	animator_electric.play("move");
	play("camera/camera_down");
	await animator_electric.animation_finished;
	electric.emitting = false;
	intro_second();
	pass
	
func intro_second():
	play("second_monitor_on");
	

func correct():
	monitor_2.modulate = "78ff4e";
	timer.start(1);
	await timer.timeout;
	play("camera/camera_up");
	await animation_finished;
	timer.start(1);
	await timer.timeout;
	game.difficulty_up();
	monitor_2.modulate = "ffffff";
	timer.start(3);
	await timer.timeout;
	play("camera/camera_down");
	



func game_over():
	monitor_2.modulate = "ff5449";
	timer.start(2);
	await timer.timeout;
	play("camera/camera_up");
	await animation_finished;
	reset();
	pass

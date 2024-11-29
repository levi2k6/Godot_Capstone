extends AnimationPlayer

@onready var back = $"../Background/ParallaxLayer/Back"
@onready var lights_sound = $"../Background/ParallaxLayer/Back/Lights_Sound"

@onready var casing = $"../Foreground/Casing";
@onready var monitor_1 = $"../Foreground/Monitor1";
@onready var monitor_sound = $Monitor_Sound;
@onready var monitor_1_output = $"../Foreground/Monitor1/Monitor1_Output";
@onready var bar_timer = $"../Foreground/Monitor1/Bar_Timer";
@onready var game_intro = $"../Foreground/Casing/Game_Intro";

@onready var monitor_2 = $"../Foreground/Monitor2";
@onready var monitor_2_output = $"../Foreground/Monitor2/Monitor2_Output";

@onready var animator_engine = $"../Foreground/Casing/Engine/AnimatorEngine";
@onready var engine_sound = $"../Foreground/Casing/Engine/Engine_Sound";


@onready var electric = $"../Electric"
@onready var animator_electric = $"../Electric/AnimatorElectric"

@onready var title = $"../Foreground/Monitor1/Title"
@onready var animator_title = $"../Foreground/Monitor1/Title/Animator_Title"

@onready var game = $"../Game";
@onready var timer = $"../Game/Timer";


const LIGHTS_OFF = preload("res://assets/game2/backgrounds/lights_off.png")
const LIGHTS_ON_2 = preload("res://assets/game2/backgrounds/lights_on2.png")

func _ready():
	animator_title.play("blinking");
	pass

func reset():
	timer.start(2);
	await timer.timeout;
	animator_engine.play("engine_off");
	engine_sound.playing = false;
	monitor_1_output.text = "";
	monitor_2.modulate = "b5ffff";
	lights_sound.play();
	back.texture = LIGHTS_OFF;
	casing.modulate = "808080";
	play("first_monitor_off");
	await animation_finished;
	timer.start(1);
	await timer.timeout;
	title.visible = true;
	play("second_monitor_off");
	
	game_intro.start = false;
	game_intro.display_highest_level();


func intro():
	lights_sound.play();
	back.texture = LIGHTS_ON_2;
	casing.modulate = "ffffff";
	timer.start(1);
	await timer.timeout;
	animator_engine.play("engine_on");
	engine_sound.play();
	timer.start(1);
	await timer.timeout;
	play("first_monitor_on");
	timer.start(1);
	await timer.timeout;
	
	monitor_1_output.text = "level: %s" %game.level; 
	timer.start(2.5);
	await timer.timeout;
	
	await number_show();
	electric.emitting = true;
	animator_electric.play("move");
	play("camera/camera_down");
	await animator_electric.animation_finished;
	electric.emitting = false;
	play("second_monitor_on");
	pass


func correct():
	const CHECK = preload("res://assets/game2/sounds/Check.wav")
	monitor_sound.stream = CHECK;
	monitor_sound.play();
	monitor_2.modulate = "78ff4e";
	timer.start(1);
	await timer.timeout;
	play("camera/camera_up");
	await animation_finished;
	timer.start(1);
	await timer.timeout;
	monitor_1_output.text = "level: %s" %game.level; 
	timer.start(2.5);
	await timer.timeout;
	await number_show();
	monitor_2.modulate = "b5ffff";
	bar_timer.visible = false;
	play("camera/camera_down");

var bonus_time = 0;
var time;

func number_show():
	game.start();
	if game.difficulty == "normal":
		bonus_time += 0.5;
	if game.difficulty == "hard":
		bonus_time += 1;
	
	bar_timer.visible = true;
	time = 1.5 + bonus_time;
	print("BONUS: ", time);
	timer.start(time);
	await timer.timeout;
	bar_timer.visible = false;

func _process(delta):
	if bar_timer.visible:
		var num_percent = (timer.time_left / time) * 100;
		bar_timer.value = num_percent;

func game_over():
	const WRONG = preload("res://assets/game2/sounds/Wrong.wav")
	monitor_sound.stream = WRONG;
	monitor_sound.play();
	bonus_time = 0;
	monitor_2.modulate = "ff5449";
	timer.start(2);
	await timer.timeout;
	play("camera/camera_up");
	await animation_finished;
	reset();
	pass

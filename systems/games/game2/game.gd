extends Control
@onready var pet = $"../Pet"
@onready var animator = $"../Animator"

@onready var monitor_1_output = $"../Foreground/Monitor1/Monitor1_Output"
@onready var game_intro = $"../Foreground/Casing/Game_Intro"


@onready var monitor_2_output = $"../Foreground/Monitor2/Monitor2_Output"

@onready var timer = $Timer
@onready var typer = $"../Foreground/Casing/Typer"

@onready var camera_2d = $"../Camera2D"

var difficulty: String;
var rng = RandomNumberGenerator.new();
var monitor1_num = "";
var level = 1;
var per_num = 0;

func _ready():
	var viewport_size = camera_2d.get_viewport_rect().size;
	var viewport_half_y = viewport_size.y / 2;
	
	size = viewport_size;
	position = Vector2(0, camera_2d.position.y + -viewport_half_y);



func start():
	print(difficulty);
	print("start working");
	if difficulty == "normal":
		per_num += 1
	elif difficulty == "hard":
		per_num += 2;
	
	monitor1_num = "";
	for i in range(per_num):
		var rand_int = rng.randi_range(0,9);
		var rand_str:String = str(rand_int);
		monitor1_num += rand_str;
		print(rand_int);
	monitor_1_output.text = monitor1_num;
	monitor_2_output.text = "What was the number?";
	typer.able = true;

func intro_animation():
	
	pass

func compare():
	if monitor_2_output.text == monitor1_num:
		print("THEY ARE THE SAME NUMBER!");
		print(monitor_1_output.text, " | " , monitor1_num);
		level += 1;
		animator.correct();
	else:
		lose();

func lose():
	print(monitor_1_output.text, " | " , monitor1_num);
	DataManager._insert_game2_session(level, difficulty);
	animator.game_over();
	reward_system();
	level = 1;
	per_num = 0;

func reward_system():
	var reward = level;
	var money = level;
	
	if difficulty == "hard":
		if level >= 30:
			level += 8;
		elif level >= 25:
			reward += 7;
		elif level >= 20:
			reward += 6;
		elif level >= 15:
			reward += 5;
		elif level >= 10:
			reward += 4;
		elif level >= 6:
			reward += 3;
		elif level >= 4:
			reward += 2;
		elif level == 3:
			reward += 1;
		money *= 2;
	
	print("points: ", reward);
	pet._learn(reward);
	get_parent().update_money(money);

func difficulty_up():
	typer.able = false;
	start();

func _on_submit_button_up():
	compare();
	pass # Replace with function body.



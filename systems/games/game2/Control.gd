extends Control
@onready var pet = $"../Pet"

@onready var animator = $"../Animator"
@onready var monitor_1_output = $"../Foreground/Monitor1/Monitor1_Output"
@onready var monitor_2_output = $"../Foreground/Monitor2/Monitor2_Output"

@onready var timer = $Timer
@onready var typer = $"../Foreground/Casing/Typer"

var rng = RandomNumberGenerator.new();
var monitor1_num = "";
var level = 1;

func start():
	print("start working");
	monitor1_num = "";
	for i in range(level):
		var rand_int = rng.randi_range(0,9);
		var rand_str:String = str(rand_int);
		monitor1_num += rand_str;
		print(rand_int);
	monitor_1_output.text = monitor1_num;
	timer.start(3);
	await timer.timeout;
	monitor_2_output.text = "What was the number?";
	typer.able = true;

func intro_animation():
	
	pass

func compare():
	if int(monitor_2_output.text) == int(monitor1_num):
		print("THEY ARE THE SAME NUMBER!");
		print(int(monitor_1_output.text), " | " , monitor1_num);
		animator.correct();
	else:
		lose();

func lose():
	animator.game_over();
	print(int(monitor_1_output.text), " | " , monitor1_num);
	$Game_Intro.visible = true;
	$Game_Intro.start = false;
	$Game_Intro.change();
	DataManager._insert_game2_session(level);
	level = 1
	typer.able = false;
	reward_system();

func reward_system():
	var reward = 3;
	if level >= 20:
		reward = 20;
		print("plus 14 points!");
	elif level >= 15:
		reward = 16;
		print("plus 12 points!");
	elif level >= 10:
		reward = 12;
		print("plus 10 points!");
	elif level > 5:
		reward = 8;
	elif level == 1:
		reward = 1;
		print("plus 8 points!");
	pet._learn(reward);
	get_parent().update_money();

func difficulty_up():
	level += 1;
	typer.able = false;
	start();

func _on_submit_button_up():
	compare();
	pass # Replace with function body.



extends Control
@onready var pet = $"../Pet"

var rng = RandomNumberGenerator.new();
var label_num = "";
var level = 1;

func start():
	print("start working");
	label_num = "";
	for i in range(level):
		var rand_int = rng.randi_range(0,9);
		var rand_str:String = str(rand_int)
		label_num += rand_str;
		print(rand_int);
	$Label.text = label_num;
	$Timer.start(3);
	await $Timer.timeout;
	$Label.text = "What Was The Number?"
	$Typer.able = true;

func compare():
	if int($Label.text) == int(label_num):
		print("THEY ARE THE SAME NUMBER!");
		print(int($Label.text), " | " , label_num);
		difficulty_up();
	else:
		print(int($Label.text), " | " , label_num);
		$Game_Intro.visible = true;
		$Game_Intro.start = false;
		$Game_Intro.change();
		DataManager._insert_game2_session(level);
		level = 1
		$Typer.able = false;
		reward_system();

func reward_system():
	print("DIES: ", level);
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
	$Typer.able = false;
	start();

func _on_submit_button_up():
	compare();
	pass # Replace with function body.



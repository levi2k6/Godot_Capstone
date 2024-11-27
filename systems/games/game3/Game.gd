extends Node2D
@onready var animator = $"../Animator"
@onready var game_intro = $"../Control/Game_Intro";
@onready var highest_level = $"../Control/Game_Intro/Highest_Level"
@onready var pet = $"../Pet"
@onready var timer = $Timer
@onready var label = $"../Control/Game_Intro/Label"

signal game_win;
const METEOR = preload("res://systems/games/game3/Meteor.tscn");

var rng = RandomNumberGenerator.new();

var level : int;
var stop_spawn : bool;
var meteors : int;
var difficulty: String;

func _ready():
	self.connect("game_win", Callable(self, "win"));
	pass;

func _process(delta):
	$Debuger/Label1.text = "stop_spawn: %s" %stop_spawn;
	$Debuger/Label2.text = "meteors: %s" %meteors;
	$Debuger/Label3.text = str($Spawn_Timer.time_left);
	pass;

func start():
	print("start");
	level = 1;
	await show_level();
	stop_spawn = false;
	meteors = level;
	spawn_repeater();

func _continue():
	print("continue");
	stop_spawn = false;
	meteors = level;
	spawn_repeater();

func spawn_repeater():
	for i in range(level):
		print(i + 1);
		var ran_num = rng.randi_range(1,2);
		$Spawn_Timer.start(ran_num);
		await $Spawn_Timer.timeout;
		if stop_spawn == true:
			break;
		spawn();
	stop_spawn = true;
	pass;

func spawn():
	var meteor = METEOR.instantiate();
	if difficulty == "normal":
		meteor.speed = rng.randi_range(1000, 1500);
	elif difficulty == "hard":
		meteor.speed = rng.randi_range(1500, 2000);
	
	var ran_num = rng.randi_range(1, 3);
	if ran_num == 1:
		$Spawner1.add_child(meteor);
		var recent_child = $Spawner1.get_child_count() - 1;
		#print_debug(recent_child);
		$Spawner1.get_child(recent_child).connect("meteor_destroy", Callable(self, "meteor_input"));
	elif ran_num == 2:
		$Spawner2.add_child(meteor);
		var recent_child = $Spawner2.get_child_count() - 1;
		#print_debug(recent_child);
		$Spawner2.get_child(recent_child).connect("meteor_destroy", Callable(self, "meteor_input"));
	elif ran_num == 3:
		$Spawner3.add_child(meteor);
		var recent_child = $Spawner3.get_child_count() - 1;
		#print_debug(recent_child);
		$Spawner3.get_child(recent_child).connect("meteor_destroy", Callable(self, "meteor_input"));


func meteor_input(meteor):
	print("input");
	meteor.destroy();
	meteors -= 1;
	print("something");
	if meteors == 0:
		#emit_signal("game_win");
		win();

func difficulty_up():
	level += 1;
	await show_level();
	print("level: ", level);
	_continue();
	pass

func show_level():
	print("level here" , str(level));
	label.text = "LEVEL: %s" %str(level);
	timer.start(2.5);
	await timer.timeout;
	label.text = "";
	timer.start(1);
	await timer.timeout;

func win():
	print("you win!");
	timer.start(1.5);
	await timer.timeout;
	difficulty_up();

func lose():
	DataManager._insert_game3_session(level, difficulty);
	reward_system();
	await animator.lose();

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

func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	area.get_parent().destroy();
	stop_spawn = true;
	if $Spawn_Timer.time_left > 0:
		print("Waiting");
		await $Spawn_Timer.timeout;
	lose();
	
	
	pass # Replace with function body.

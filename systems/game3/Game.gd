extends Node2D

@onready var game_intro = $"../Control/Game_Intro";
@onready var pet = $"../Pet"

signal game_win;
const TILE = preload("res://systems/game3/tile.tscn");

var rng = RandomNumberGenerator.new();

var level : int;
var stop_spawn : bool;
var meteors : int;

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
	var tile1 = TILE.instantiate();
	var ran_num = rng.randi_range(1, 3);
	if ran_num == 1:
		$Spawner1.add_child(tile1);
		var recent_child = $Spawner1.get_child_count() - 1;
		#print_debug(recent_child);
		$Spawner1.get_child(recent_child).connect("meteor_destroy", Callable(self, "meteor_input"));
	elif ran_num == 2:
		$Spawner2.add_child(tile1);
		var recent_child = $Spawner2.get_child_count() - 1;
		#print_debug(recent_child);
		$Spawner2.get_child(recent_child).connect("meteor_destroy", Callable(self, "meteor_input"));
	elif ran_num == 3:
		$Spawner3.add_child(tile1);
		var recent_child = $Spawner3.get_child_count() - 1;
		#print_debug(recent_child);
		$Spawner3.get_child(recent_child).connect("meteor_destroy", Callable(self, "meteor_input"));

func meteor_input(meteor):
	meteor.queue_free();
	meteors -= 1;
	if meteors == 0:
		emit_signal("game_win");

func difficulty_up():
	level += 1;
	print("level: ", level);
	_continue();
	pass

func win():
	print("you win!");
	$Timer.start(3);
	await $Timer.timeout;
	difficulty_up();

func lose():
	print("lost");
	game_intro.start = false;
	game_intro.change();
	game_intro.visible = true;
	DataManager._insert_game3_session(level);
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

func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	area.get_parent().queue_free();
	
	stop_spawn = true;
	
	if $Spawn_Timer.time_left > 0:
		print("Waiting");
		await $Spawn_Timer.timeout;
	
	lose();
	
	
	pass # Replace with function body.

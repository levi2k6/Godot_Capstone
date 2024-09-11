extends Control

var rng = RandomNumberGenerator.new()
var level = 1;
var pattern = [];
var click;

@onready var pet = $"../Pet";

var tile_datas = {
	1: "tile1",
	2: "tile2",
	3: "tile3",
	4: "tile4",
	5: "tile5",
	6: "tile6",
	7: "tile7",
	8: "tile8",
	9: "tile9"
}

func _ready():
	print_datas();
	pass

func start():
	var rng_result = rng.randi_range(1, 9);
	pattern.append(tile_datas[rng_result]);
	game_animation()

var queue_i = 0;
var while_animation = false;

func game_animation():
	while_animation = true;
	
	$Timer.start();
	await $Timer.timeout;
	
	for tile_name in pattern:
		for tile in get_child(0).get_children():
			if tile.name == tile_name:
				tile.modulate = "ff1622";
				$Timer.start(1);
				await $Timer.timeout;
				tile.modulate = Color(1,1,1);
				$Timer.start(1);
				await $Timer.timeout;
				continue;
	while_animation = false;
	pass

func win_animation():
	$Timer.start(1)
	await $Timer.timeout
	difficulty_up();

func click_tile(tile, tile_name):
	if !while_animation:
		tile.animation();
		click = tile_name;
		print(click);
		var queue = pattern_queue();
		
		if click == queue:
			print("YOU ARE RIGHT");
			if queue_i ==  pattern.size():
				win_animation();
		else:
			print("WRONG!");
			$Game_Intro.visible = true;
			$Game_Intro.start = false;
			$Game_Intro.change();
			reward_system();
			DataManager._insert_game1_session(level);
			level = 1;
			queue_i = 0;
			pattern = [];


func pattern_queue():
	var current_queue = pattern[queue_i]
	queue_i += 1;
	return current_queue;

func difficulty_up():
	#for i in range(level):
		#print(i);
	var rng_result = rng.randi_range(1, 9);
	pattern.append(tile_datas[rng_result]);
	
	level += 1;
	$Level.text = "LEVEL: " + str(level)
	queue_i = 0;
	game_animation()
	
	print("-----------WELCOME TO LEVEL: ", level);
	print_datas();

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

func session_stats():
	pass

func print_datas():
	print("level: " ,level);
	print("pattern: ", pattern);
	print("click: " , click);
	print("queue: ", queue_i);
	print("-------------------------------")
	






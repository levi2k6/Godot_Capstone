extends Control
@onready var pet = $"../Pet";
@onready var animator = $"../Animator"
@onready var tiles = $Tiles

var rng = RandomNumberGenerator.new()
var level = 1;
var pattern = [];
var click;
var difficulty: String;
var per_pattern = 0;

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
	animator.restart();
	print(difficulty);
	if difficulty == "normal":
		per_pattern = 1;
	if difficulty == "hard":
		per_pattern = 2;
	
	for i in range(per_pattern):
		print("range " , i);
		var rng_result = rng.randi_range(1, 9);
		pattern.append(tile_datas[rng_result]);
		pass
	
	$Level.text = "LEVEL: " + str(level)
	game_animation()

func tile_amount():
	pass


var queue_i = 0;
var able = false;

func game_animation():
	disable_tiles();
	
	$Timer.start();
	await $Timer.timeout;
	
	for tile_name in pattern:
		for tile in tiles.get_children():
			if tile.name == tile_name:
				tile.modulate = "ff1622";
				$Timer.start(0.3);
				await $Timer.timeout;
				tile.modulate = Color(1,1,1);
				$Timer.start(0.3);
				await $Timer.timeout;
				continue;
	activate_tiles();
	pass

func win():
	await animator.right();
	$Timer.start(1)
	await $Timer.timeout
	difficulty_up();

func lose():
	disable_tiles();
	print("WRONG!");
	await animator.wrong();
	$Game_Intro.visible = true;
	$Game_Intro.start = false;
	$Game_Intro.change();
	reward_system();
	DataManager._insert_game1_session(level, difficulty);
	level = 1;
	queue_i = 0;
	pattern = [];

func click_tile(tile, tile_name):
	print("this is while animation" , able);
	tile.animation();
	click = tile_name;
	print(click);
	var queue = pattern[queue_i];
	queue_i += 1;
	if click == queue:
		print("YOU ARE RIGHT");
		if queue_i ==  pattern.size():
			print("WIN END");
			disable_tiles();
			win();
	else:
		lose();

func disable_tiles():
	for tile in tiles.get_children():
		tile.disabled = true;

func activate_tiles():
	for tile in tiles.get_children():
		tile.disabled = false;

func difficulty_up():
	level += 1;
	queue_i = 0;
	start();
	print("-----------WELCOME TO LEVEL: ", level);
	print_datas();

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

func session_stats():
	pass

func print_datas():
	print("level: " ,level);
	print("pattern: ", pattern);
	print("click: " , click);
	print("queue: ", queue_i);
	print("-------------------------------")
	






extends AnimationPlayer
@onready var intro_control = $"../Control/Game/Intro_Control"
@onready var game_intro = $"../Control/Game/Intro_Control/Game_Intro"
@onready var background = $"../Control/Background"
@onready var timer = $"../Control/Game/Timer"
@onready var animator_tiles = $"../Control/Game/Animator_Tiles"
@onready var tiles = $"../Control/Game/Tiles"
@onready var level = $"../Control/Game/Level"



func _ready():
	game_intro_appear();

func game_intro_appear():
	
	for tile in tiles.get_children():
		tile.disabled = true;
		print(tile.disabled);
	
	timer.start(2);
	await timer.timeout;
	
	animator_tiles.play("tiles_appear");
	await animator_tiles.animation_finished;
	
	var i = 0;
	var first_tiles = [];
	var second_tiles = [];
	for tile in tiles.get_children():
		i+=1;
		if i == 1 || i == 3 || i == 5 || i == 7 || i == 9:
			first_tiles.append(tile);
		elif i == 2 || i == 4 || i == 6 || i == 8:
			second_tiles.append(tile);
	
	for tile in first_tiles:
		tile.change_red();
	timer.start(1);
	await timer.timeout;
	for tile in first_tiles:
		tile.change_normal();
	
	for tile in second_tiles:
		tile.change_blue();
	timer.start(1);
	await timer.timeout;
	for tile in second_tiles:
		tile.change_normal();
	
	timer.start(1);
	await timer.timeout;
	
	await intro_control.intro_appear();
	
	print("done intro");
	pass

func game_intro_leave():
	level.visible = true;
	await intro_control.intro_leave();
	pass

func restart():
	background.modulate = "ee9e4b";

func wrong():
	game_intro.display_highest_level();
	background.modulate = "ff0000";
	timer.start(2);
	await timer.timeout;
	await intro_control.intro_appear();

func right():
	background.modulate = "2166e7";
	timer.start(2);
	await timer.timeout;
	background.modulate = "ee9e4b";

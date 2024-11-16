extends AnimationPlayer
@onready var background = $"../Background"
@onready var timer = $"../Game/Timer"
@onready var animator_tiles = $"../Game/Animator_Tiles"
@onready var tiles = $"../Game/Tiles"
@onready var level = $"../Game/Level"


func _ready():
	game_intro_appear();

func game_intro_appear():
	play("RESET");
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
	
	play("game_intro_appear");
	await animation_finished;
	print("done intro");
	pass

func game_intro_leave():
	level.visible = true;
	play("game_intro_leave");
	await animation_finished;
	pass

func restart():
	background.modulate = "ee9e4b";

func wrong():
	background.modulate = "ff0000";
	timer.start(2);
	await timer.timeout;
	play("game_intro_appear");

func right():
	background.modulate = "2166e7";
	timer.start(2);
	await timer.timeout;
	background.modulate = "ee9e4b";

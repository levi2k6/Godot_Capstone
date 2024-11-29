extends AnimationPlayer

@onready var animator_timer = $AnimatorTimer;
@onready var animator_alien = $"../Foreground/Alien/AnimatorAlien";
@onready var animator_stars = $"../Background/ParallaxLayer/TextureRect/Stars/AnimatorStars";
@onready var game_intro = $"../Control/Game_Intro";
@onready var highest_level_container = $"../Control/Game_Intro/Highest_Level_Container"
@onready var label = $"../Control/Game_Intro/Label"
@onready var normal = $"../Control/Game_Intro/Ship_Intro/ShipMenu/VBoxContainer/Normal"
@onready var hard = $"../Control/Game_Intro/Ship_Intro/ShipMenu/VBoxContainer/Hard"
@onready var ship_sound = $"../Control/Game_Intro/Ship_Intro/Ship_Sound"

@onready var timer = $"../Game/Timer"

func _ready():
	animator_alien.play("idle");
	animator_stars.play("twinkle");
	play("RESET");
	animator_timer.start(3);
	await animator_timer.timeout;
	play("camera_up");
	await animation_finished;
	ship_appear();
	await animation_finished;
	game_intro.display_highest_level();


func ship_leave():
	normal.disabled = true;
	hard.disabled = true;
	play("ship_leave");
	ship_sound.play();
	await animation_finished;

func ship_appear():
	normal.disabled = true;
	hard.disabled = true;
	play("ship_appear");
	ship_sound.play();
	await animation_finished;
	highest_level_container.visible = true;
	normal.disabled = false;
	hard.disabled = false;

func lose():
	timer.start(1);
	await timer.timeout;
	print("lost");
	ship_appear();
	await animation_finished;
	game_intro.display_highest_level();


extends AnimationPlayer

@onready var animator_timer = $AnimatorTimer;
@onready var animator_alien = $"../Foreground/Alien/AnimatorAlien";
@onready var animator_stars = $"../Background/ParallaxLayer/TextureRect/Stars/AnimatorStars";
@onready var game_intro = $"../Control/Game_Intro";
@onready var label = $"../Control/Game_Intro/Label"
@onready var normal = $"../Control/Game_Intro/Ship_Intro/ShipMenu/VBoxContainer/Normal"
@onready var hard = $"../Control/Game_Intro/Ship_Intro/ShipMenu/VBoxContainer/Hard"

func _ready():
	animator_alien.play("idle");
	animator_stars.play("twinkle");
	play("RESET");
	animator_timer.start(3);
	await animator_timer.timeout;
	play("camera_up");
	await animation_finished;
	game_intro.visible = true;
	ship_appear();
	await animation_finished;


func ship_leave():
	normal.disabled = true;
	hard.disabled = true;
	play("ship_leave");
	await animation_finished;

func ship_appear():
	normal.disabled = true;
	hard.disabled = true;
	play("ship_appear");
	await animation_finished;
	normal.disabled = false;
	hard.disabled = false;
	

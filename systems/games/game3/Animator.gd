extends AnimationPlayer

@onready var animator_timer = $AnimatorTimer;
@onready var animator_alien = $"../Foreground/Alien/AnimatorAlien";
@onready var animator_stars = $"../Background/ParallaxLayer/TextureRect/Stars/AnimatorStars";
@onready var game_intro = $"../Control/Game_Intro";

func _ready():
	animator_alien.play("idle");
	animator_stars.play("twinkle");
	play("RESET");
	animator_timer.start(3);
	await animator_timer.timeout;
	play("camera_up");
	await animation_finished;
	game_intro.visible = true;
	


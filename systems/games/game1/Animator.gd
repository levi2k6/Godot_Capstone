extends AnimationPlayer
@onready var background = $"../Background"
@onready var timer = $"../Game/Timer"




func game_intro_appear():
	pass

func game_intro_leave():
	pass

func restart():
	background.modulate = "ffffff";

func wrong():
	background.modulate = "ff4349";
	timer.start(2);
	await timer.timeout;

func right():
	background.modulate = "11ea00";
	timer.start(2);
	await timer.timeout;
	background.modulate = "ffffff";

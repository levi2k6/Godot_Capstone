extends AnimationPlayer
@onready var timer = $"../Timer"

@onready var animator_title = $"../Control/Title/Animator_Title"


func _ready():
	
	pass


func title_animation():
	timer.start(1);
	await timer.timeout;
	play("dark_disappear");
	await animation_finished;
	timer.start(1);
	await timer.timeout;
	animator_title.play("back_mini_pet");
	await animator_title.animation_finished;
	animator_title.play("bit_buddy");
	await animator_title.animation_finished;
	


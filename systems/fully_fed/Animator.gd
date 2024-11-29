extends AnimationPlayer
@onready var timer = $"../Timer"

@onready var baloons_1 = $"../Control/Baloons1"
@onready var baloons_2 = $"../Control/Baloons2"

@onready var pet = $"../Control/Pet_Control/Pet"
@onready var hunger_bar = $"../Control/Info/Hunger/Hunger_Bar"
@onready var camera_2d = $"../Camera2D"
@onready var reward = $"../Control/Reward"
@onready var rich_text_label = $"../Control/RichTextLabel"
@onready var main_hub_button = $"../Control/Main_Hub_Button"
@onready var sound = $Sound


func start(pet_animators):
	pet_animators.body_animation.play("idle");
	
	timer.start(2)
	await timer.timeout;
	
	play("hunger_appear");
	await animation_finished;
	
	var tween = get_tree().create_tween();
	tween.set_trans(Tween.TRANS_CUBIC);
	tween.set_ease(Tween.EASE_OUT);
	tween.tween_property(hunger_bar, "value", 100, 1);
	const TRANSITION = preload("res://assets/universal/sounds/Transition.wav")
	sound.stream = TRANSITION;
	sound.pitch_scale = 2;
	sound.play();
	await tween.finished;
	
	var tween1 = get_tree().create_tween();
	tween1.set_trans(Tween.TRANS_CUBIC);
	tween1.set_ease(Tween.EASE_OUT);
	tween1.tween_property(camera_2d, "zoom", Vector2(1.3,1.3), 1.7);
	
	sound.pitch_scale = 1;
	
	play("white_animation");
	await animation_finished;
	pet_animators.mouth_animation.play("happy_open");
	reward.visible = true;
	rich_text_label.visible = true;
	baloons_1.visible = true;
	baloons_2.visible = true;
	main_hub_button.visible = true;
	play("white_fade");
	SoundPlayer.play_bgm_music();
	var tween2 = get_tree().create_tween();
	tween2.set_trans(Tween.TRANS_BACK);
	tween2.set_ease(Tween.EASE_OUT);
	tween2.tween_property(camera_2d, "zoom", Vector2(1,1), 0.2);
	
	pet_animators.body_animation.play("dance1");

var hue: float = 0.0

func _process(delta):
	hue += delta * 0.1 # Adjust speed
	if hue > 1.0:
		hue = 0.0 # Wrap around when exceeding the hue range
	rich_text_label.self_modulate = Color.from_hsv(hue, 1.0, 1.0) # Set a vibrant color





extends Node2D
@onready var texture_button = $TextureButton
@onready var sprite_2d = $Sprite2D
@onready var fire_particle = $Fire_Particle
@onready var explosion_particle = $Explosion_Particle
@onready var timer = $Timer
@onready var meteor_sound = $Meteor_Sound

signal meteor_destroy(meteor);


var speed: int;

func _ready():
	meteor_sound.play();
	$Area2D.connect("input_event", Callable(self, "input_event_func"));

func fire_explosion():
	fire_particle.one_shot = true;
	fire_particle.speed_scale = 3;
	fire_particle.gravity.y = 0;
	fire_particle.spread = 180;

func _process(delta):
	if speed != null:
		position.y += (speed * delta);
		sprite_2d.rotation_degrees += (200 * delta);

func destroy():
	const METEOR_EXPLOSION_FX = preload("res://assets/game3/sounds/Meteor Explosion FX.wav")
	meteor_sound.stream = METEOR_EXPLOSION_FX;
	meteor_sound.play();
	speed = 0;
	sprite_2d.visible = false;
	explosion_particle.emitting = true;
	fire_explosion();
	timer.start(1);
	await timer.timeout;
	fire_particle.emitting = false;
	queue_free();

func _on_texture_button_button_down():
	print("working");
	emit_signal("meteor_destroy", self);
	texture_button.queue_free();
	pass # Replace with function body.

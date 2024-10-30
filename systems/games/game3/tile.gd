extends Node2D
@onready var texture_button = $TextureButton
@onready var sprite_2d = $Sprite2D
@onready var cpu_particles_2d = $CPUParticles2D
@onready var timer = $Timer

signal meteor_destroy(meteor);

var rng = RandomNumberGenerator.new();
var speed = rng.randi_range(20, 25);

func _ready():
	$Area2D.connect("input_event", Callable(self, "input_event_func"));

func _process(delta):
	position.y += speed;
	sprite_2d.rotation_degrees += 5;

func destroy():
	speed = 0;
	sprite_2d.visible = false;
	cpu_particles_2d.emitting = false;
	timer.start(1);
	await timer.timeout;
	queue_free();

func _on_texture_button_button_down():
	emit_signal("meteor_destroy", self);
	texture_button.queue_free();
	pass # Replace with function body.

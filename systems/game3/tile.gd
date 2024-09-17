extends Node2D

signal meteor_destroy(meteor);

var rng = RandomNumberGenerator.new();
var speed = rng.randi_range(20, 30);

func _ready():
	$Area2D.connect("input_event", Callable(self, "input_event_func"));

func _process(delta):
	position.y += speed;

func input_event_func(viewport, event, shape_idx):
	if (event is InputEventMouseButton or event is InputEventScreenTouch) and event.pressed:
		emit_signal("meteor_destroy", self);

func destroy():
	emit_signal("meteor_destroy", "");
	queue_free();


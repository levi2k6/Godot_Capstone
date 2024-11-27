extends Control
@onready var camera_2d = $"../Camera2D"


var viewport_half = 0;

func _ready():
	var viewport_size = get_viewport().get_visible_rect().size;
	size = viewport_size;
	viewport_half = viewport_size.y / 2;
	print(viewport_half);
	

func _process(delta):
	position.y = camera_2d.position.y + -viewport_half;

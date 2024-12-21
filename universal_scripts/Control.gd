extends Control

func _ready():
	var viewport_size = get_viewport().get_visible_rect().size;
	size = viewport_size;



extends Node2D

@onready var camera_2d = $"../Camera2D"

func _ready():
	position = camera_2d.position


func _process(delta):
	if position != camera_2d.position:
		position = camera_2d.position;

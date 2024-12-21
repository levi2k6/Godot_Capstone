extends Node

@onready var restriction = $restriction

func _ready():
	print(get_restriction())
	pass

func _process(delta):
	pass

func get_restriction():
	return restriction;

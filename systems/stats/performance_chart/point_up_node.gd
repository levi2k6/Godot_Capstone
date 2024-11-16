extends Node2D

@onready var label = $Label;

func change_number(number: int):
	get_child(1).text = str(number);

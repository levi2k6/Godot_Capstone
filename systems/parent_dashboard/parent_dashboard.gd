extends Node2D
@onready var transition_layer = $Transition_Layer

func get_transition_layer():
	return transition_layer;

func _ready():
	GameData.current_child_id = 0;
	GameData.child_playing = false;
	pass


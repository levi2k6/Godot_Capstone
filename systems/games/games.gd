extends Node2D
@onready var transition_layer = $Transition_Layer


func _ready():
	SoundPlayer.play_bgm_music();

func get_transition_layer():
	return transition_layer;

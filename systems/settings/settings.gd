extends Node2D
@onready var transition_layer = $Transition_Layer;
@onready var exit_modal = $Control/Exit_Modal;

func _ready():
	SoundPlayer.play_bgm_music();

func get_transition_layer():
	return transition_layer;

func _on_settings_button_pressed():
	visible = true;
	pass # Replace with function body.

func _on_button_pressed():
	visible = false;
	pass # Replace with function body.

func _on_exit_button_up():
	SoundPlayer.button_sfx();
	exit_modal.visible = true;
	pass # Replace with function body.

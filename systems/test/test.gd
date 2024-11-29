extends Node2D

@onready var audio_stream_player_2d = $AudioStreamPlayer2D






func _on_button_button_down():
	audio_stream_player_2d.play();
	pass # Replace with function body.

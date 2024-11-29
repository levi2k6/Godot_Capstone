extends Node
@onready var bgm = $BGM
@onready var sfx = $SFX
@onready var modules = $Modules


var state;
var current_state = "";

func play_bgm_music():
	state = modules.state_change();
	
	if current_state == state:
		return;
	current_state = state;
	
	var bgm_music = modules.bgm_music_collection(state);
	bgm.stream = bgm_music;
	bgm.play();

func button_sfx():
	const BUTTON_PRESSED_SOUND = preload("res://assets/universal/sounds/button_pressed_sound.wav")
	sfx.stream = BUTTON_PRESSED_SOUND;
	sfx.play();
	pass

func _on_bgm_finished():
	bgm.play();
	pass # Replace with function body.

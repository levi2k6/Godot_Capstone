extends Node



func state_change():
	var current_scene = get_tree().current_scene.name;
	var state = "";
	if current_scene == "GameMenu" || current_scene == "MainHub" || current_scene == "Settings" || current_scene == "Stats" || current_scene == "Games" || current_scene == "Fully_Fed" || current_scene == "Collection" || current_scene == "Shop":
		state = "universal";
	elif current_scene == "Game1":
		state = "game1";
	elif current_scene == "Game2":
		state = "game2";
	elif current_scene == "Game3":
		state = "game3"
	return state;


func bgm_music_collection(state):
	if state == "universal":
		const UNIVERSAL_GAME_THEME = preload("res://assets/universal/sounds/Universal Game Theme.wav");
		return UNIVERSAL_GAME_THEME;
	if state == "game1":
		const GAME_1 = preload("res://assets/game1/sounds/Game 1.wav");
		return GAME_1;
	if state == "game2":
		const GAME_2 = preload("res://assets/game2/sounds/Game 2.wav");
		return GAME_2;
	if state == "game3":
		const GAME_3 = preload("res://assets/game3/sounds/Game 3.wav");
		return GAME_3;




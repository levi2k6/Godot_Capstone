extends Node2D





@onready var timer = $Timer

func _ready():
	adaptive_logic();
	var time_limit = DataManager._get_time_limit_database();
	if time_limit.size() == 0:
		DataManager._insert_time_limit()
	else:
		print("time_limit already exist");
	
	pass # Replace with function body.


func adaptive_logic():
	timer.start(0.5);
	await timer.timeout;
	var parent = DataManager._get_parent_database();
	if parent.size() == 0 || parent[0].password == "":
		print("parent is empty");
		get_tree().change_scene_to_file("res://systems/create_parent/create_parent.tscn");
	else:
		print("parent is not empty");
		get_tree().change_scene_to_file("res://systems/game_menu/game_menu.tscn");

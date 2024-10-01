extends Node2D
@onready var v_box_container = $Control/VBoxContainer
const GAME_STATS_BAR = preload("res://systems/stats/time_played/game_stats_bar.tscn")

const ICON = preload("res://icon.svg")

var games_library = [
{"id" : 1 ,"name": "", "sprite": null, "count": 0},
{"id" : 2 ,"name": "", "sprite": null, "count": 0},
{"id" : 3, "name": "", "sprite": null, "count": 0}
];

var highest_count = 0;
var lowest_count = 0;
var high_low_arr = [];
var low_high_arr = [];

func _ready():
	append_game_library();
	var games_db = DataManager._get_all_game_counts();
	var highest = 0;
	for data in games_db:
		for i in range(games_db.size()):
			if data.count > highest:
				highest = data.count;
			if data.count < games_db[i].count:
				highest = games_db[i].count;
	highest_count = highest;
	game_datas_display(games_db);

func remove_games_stats():
	for child in v_box_container.get_children():
		child.queue_free();

func append_game_library():
	var games_db = DataManager._get_all_game_counts();
	for i in range(games_library.size()):
		games_library[i].name = games_db[i].name;
		games_library[i].count = games_db[i].count;

func high_to_low_datas_initialize():
	remove_games_stats();
	var games_db = DataManager._get_all_game_counts();
	var arr = games_db;
	for a in range(arr.size()-1):
		for i in range(arr.size()-1):
			var left = arr[i];
			var right = arr[i+1];
			if left.count < right.count:
				arr[i] = right;
				arr[i+1] = left;
	highest_count = arr[0].count;
	game_datas_display(arr);
	pass;

func low_to_high_datas_initialize():
	remove_games_stats();
	var games_db = DataManager._get_all_game_counts();
	var arr = games_db;
	for a in range(arr.size()-1):
		for i in range(arr.size()-1):
			var left = arr[i];
			var right = arr[i+1];
			if left.count > right.count:
				arr[i] = right;
				arr[i+1] = left;
	highest_count = arr[arr.size()-1].count;
	game_datas_display(arr);
	pass;

func game_datas_display(arr: Array):
	for data in arr:
		var games_stats_bar = GAME_STATS_BAR.instantiate();
		v_box_container.add_child(games_stats_bar);
		var percent = (float(data.count) / float(highest_count)) * 100;
		var int_percent = int(percent);
		
		var parameter_datas = {
			"name" : data.name,
			"texture" : ICON,
			"count": data.count,
			"percent": int_percent
		}
		games_stats_bar.initialize_game_data(parameter_datas);

func _on_button_button_down():
	high_to_low_datas_initialize();
	pass # Replace with function body.


func _on_button_2_button_down():
	low_to_high_datas_initialize();
	pass # Replace with function body.

extends Node

var last_scene = "";




var time_track := 0.0;

func _ready():
	var db_total_time = float(DataManager._get_milestone_datas()[0].total_time);
	time_track += db_total_time;

func _exit_tree():
	DataManager._update_milestone_total_time();

func _process(delta):
	time_track += delta;
	#print(time_track);


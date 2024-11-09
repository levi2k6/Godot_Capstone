extends Node

signal okay;


var last_scene = "";
var child_exist = false;
var time_track := 0.0;



func _ready():
	if DataManager._get_child_database().size() != 0:
		var db_total_time = float(DataManager._get_milestone_datas()[0].total_time);
		time_track += db_total_time;
		emit_signal("okay");


func _exit_tree():
	DataManager._update_milestone_total_time();

func _process(delta):
	time_track += delta;
	#print(time_track);


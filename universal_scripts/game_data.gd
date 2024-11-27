extends Node

signal okay;


var last_scene = "";
var transition_disappear = false;
var child_exist = false;
var fully_fed_reward = false;
var time_track := 0.0;

var calendar_animation = false;



func _ready():
	if DataManager._get_child_database().size() != 0:
		var db_total_time = float(DataManager._get_milestone_datas()[0].total_time);
		time_track += db_total_time;
		emit_signal("okay");
	
	
	


func calendar_animate():
	
	pass;


func _exit_tree():
	DataManager._update_milestone_total_time();

func _process(delta):
	time_track += delta;
	#print(time_track);


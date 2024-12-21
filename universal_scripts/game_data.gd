extends Node

signal okay;

var current_child_id: int;

var last_scene = "";
var transition_disappear = false;
var child_exist = false;
var fully_fed_reward = false;
var time_track := 0.0;

var calendar_animation = false;

var child_playing = false;

func child_starts_playing():
	child_playing = true;
	if child_playing:
		var db_total_time = float(DataManager._get_milestone_datas()[0].total_time);
		time_track += db_total_time;
		emit_signal("okay");

func _exit_tree():
	DataManager._update_milestone_total_time();

func _process(delta):
	if child_playing:
		time_track += delta;
		#print(time_track);
	#print(time_track);


extends Label


func _ready():
	update_label();
	pass # Replace with function body.


func update_label():
	var time_limit_data = DataManager._get_time_limit_database()[0];
	if time_limit_data.start_time == "" || time_limit_data.end_time == "":
		print_debug("No resitriction");
	else:
		text = "Time Limit: %s - %s"%[time_limit_data.start_time, time_limit_data.end_time];

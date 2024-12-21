extends Node

@onready var timer = $Timer

func _ready():
	var time_limit_data = DataManager._get_time_limit_database()[0];
	print(time_limit_data);
	if time_limit_data.start_time == "" || time_limit_data.end_time == "":
		return;
	every_3sec_check();

func every_3sec_check():
	Modules.get_restriction().force_out();
	timer.start(3);
	await timer.timeout;
	every_3sec_check();

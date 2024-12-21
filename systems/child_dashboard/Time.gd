extends Label


func show_time():
	var current_time = Time.get_datetime_dict_from_system();
	var current_time_str = str(current_time.hour).pad_zeros(2) + ":" + str(current_time.minute).pad_zeros(2) + ":" + str(current_time.second).pad_zeros(2);
	var current_clock_time = convert_to_clock_time(current_time_str);
	print(current_clock_time);
	text = "TIME: %s"%[current_clock_time]; 
	pass # Replace with function body.

func convert_to_clock_time(time_24: String) -> String:
	var time_parts = time_24.split(":")
	var hour = int(time_parts[0])
	var minute = time_parts[1]
	
	
	var am_pm = "AM"
	
	if hour >= 12:
		am_pm = "PM"
	if hour > 12:
		hour -= 12
	elif hour == 0:
		hour = 12
	
	# Return formatted 12-hour time
	return str(hour).pad_zeros(2) + ":" + minute + " " + am_pm


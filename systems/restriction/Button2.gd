extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	var current_time = Time.get_datetime_dict_from_system();
	print("current_time:", current_time);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_down():
	if is_time_within_range("01:00:00 PM", "03:00:00 AM"):
		print("it is within");
	else:
		print("it is not within");
	
	pass # Replace with function body.

func convert_to_24hr(time_str: String):
	var am_pm = time_str.substr(time_str.length() - 2, time_str.length()).to_lower()
	var time_parts = time_str.substr(0, time_str.length() - 2).split(":")
	var hour = int(time_parts[0])
	
	if am_pm == "pm" and hour != 12:
		hour += 12
	elif am_pm == "am" and hour == 12:
		hour = 0
	
	return str(hour).pad_zeros(2) + ":" + time_parts[1] + ":" + time_parts[2]

func time_to_seconds(time_str: String) -> int:
	var time_parts = time_str.split(":")
	return int(time_parts[0]) * 3600 + int(time_parts[1]) * 60 + int(time_parts[2])

	# Function to check if the current time is within the start and end time
func is_time_within_range(start_time: String, end_time: String) -> bool:
	# Get the current time in "HH:MM:SS" format
	var current_time = Time.get_datetime_dict_from_system();
	var current_time_str = str(current_time.hour).pad_zeros(2) + ":" + str(current_time.minute).pad_zeros(2) + ":" + str(current_time.second).pad_zeros(2);

	# Convert start time, end time, and current time to 24-hour format
	var start_24hr = convert_to_24hr(start_time);
	var end_24hr = convert_to_24hr(end_time);
	var current_24hr = convert_to_24hr(current_time_str);

	# Convert to seconds
	var start_seconds = time_to_seconds(start_24hr)
	var end_seconds = time_to_seconds(end_24hr)
	var current_seconds = time_to_seconds(current_24hr)

	# Check if the time range spans midnight
	if start_seconds <= end_seconds:
		return current_seconds >= start_seconds and current_seconds <= end_seconds
	else:
		# Handle wrap-around (midnight)
		return current_seconds >= start_seconds or current_seconds <= end_seconds

# Example usage
#func _ready():
	#var start_time = "03:00:00 AM"  # Example start time
	#var end_time = "05:00:00 AM"    # Example end time
	#if is_time_within_range(start_time, end_time):
		#print("Current time is within the range.")
	#else:
		#print("Current time is outside the range.")

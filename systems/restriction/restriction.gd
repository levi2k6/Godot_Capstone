extends Node2D

@onready var spin_box_start_h = $Control/Panel/VBoxContainer2/VBoxContainer/StartHbox/HBoxContainer/SpinBoxStartH;
@onready var spin_box_start_m = $Control/Panel/VBoxContainer2/VBoxContainer/StartHbox/HBoxContainer2/SpinBoxStartM;
@onready var option_button_s = $Control/Panel/VBoxContainer2/VBoxContainer/StartHbox/OptionButtonS;

@onready var spin_box_end_h = $Control/Panel/VBoxContainer2/VBoxContainer/EndHbox/HBoxContainer/SpinBoxEndH;
@onready var spin_box_end_m = $Control/Panel/VBoxContainer2/VBoxContainer/EndHbox/HBoxContainer2/SpinBoxEndM;
@onready var option_button_e = $Control/Panel/VBoxContainer2/VBoxContainer/EndHbox/OptionButtonE;
@onready var hours_between_label = $Control/Panel/VBoxContainer2/VBoxContainer/Hours_Between;
@onready var time_limit_label = $Control/Panel/VBoxContainer2/VBoxContainer/TimeLimitLabel;
@onready var message = $Control/Panel/VBoxContainer2/Message;

@onready var transition_layer = $Transition_Layer;

var queued_data_start = {
"hours" : 0,
"minutes" : 0,
"ampm" : ""
};

var queued_data_end = {
"hours" : 0,
"minutes" : 0,
"ampm" : ""
};


func get_transition_layer():
	return transition_layer;

func _ready():
	change_time_between();

func _on_button_button_up():
	queued_data_start.hours = spin_box_start_h.value;
	queued_data_start.minutes =  spin_box_start_m.value;
	var selecteds = option_button_s.selected;
	queued_data_start.ampm = option_button_s.get_item_text(selecteds);
	queued_data_end.hours = spin_box_end_h.value;
	queued_data_end.minutes = spin_box_end_m.value;
	var selectede = option_button_e.selected;
	queued_data_end.ampm = option_button_e.get_item_text(selectede);
	
	if queued_data_start.hours == 0 || queued_data_end.hours == 0:
		message.text = "0 is invalid in hours.";
	
	if queued_data_start.hours == queued_data_end.hours && queued_data_start.minutes == queued_data_end.minutes && queued_data_start.ampm == queued_data_end.ampm:
		message.text = "START and END are the same.";
		return;
	
	
	var text_hours_s;
	if str(queued_data_start.hours).length() == 1:
		text_hours_s = "0%s"%queued_data_start.hours;
	else:
		text_hours_s = queued_data_start.hours;
	
	var text_minutes_s;
	if str(queued_data_start.minutes).length() == 1:
		text_minutes_s = "0%s"%queued_data_start.minutes;
	else:
		text_minutes_s = queued_data_start.minutes;
	
	var start_time = "%s:%s:00 %s"%[text_hours_s, text_minutes_s, queued_data_start.ampm];
	
	var text_hours_e;
	if str(queued_data_end.hours).length() == 1:
		text_hours_e = "0%s"%queued_data_end.hours;
	else:
		text_hours_e = queued_data_end.hours;
	
	var text_minutes_e;
	if str(queued_data_end.minutes).length() == 1:
		text_minutes_e = "0%s"%queued_data_end.minutes;
	else:
		text_minutes_e = queued_data_end.minutes;
	
	var end_time = "%s:%s:00 %s"%[text_hours_e, text_minutes_e, queued_data_end.ampm];
	
	print(start_time);
	print(end_time);
	Singleton.database.query("UPDATE time_limit SET start_time = '%s', end_time = '%s'" %[start_time, end_time]);
	time_limit_label.update_label();
	change_time_between();
	message.text = "Restriction Added."


func seconds_converter(hours, minutes):
	var seconds = (60 * hours) + minutes;
	return seconds;
	

# Function to calculate the difference in hours
func pad_time(time: String) -> String:
	if time.length() == 1:
		return "0" + time  # Add leading zero if length is 1
	return time


func hours_between(start_time: String, end_time: String) -> float:
	var start_parts = start_time.split(":")
	var end_parts = end_time.split(":")
	
	var start_hour = int(pad_time(start_parts[0]))  
	var start_minute = int(pad_time(start_parts[1].substr(0, 2)))  
	var start_period = start_parts[1].substr(2, 2) 
	
	var end_hour = int(pad_time(end_parts[0]))  
	var end_minute = int(pad_time(end_parts[1].substr(0, 2)))  
	var end_period = end_parts[1].substr(2, 2) 
	
	if start_period == "PM" and start_hour < 12:
		start_hour += 12 
	elif start_period == "AM" and start_hour == 12:
		start_hour = 0  

	if end_period == "PM" and end_hour < 12:
		end_hour += 12  
	elif end_period == "AM" and end_hour == 12:
		end_hour = 0  
	
	var start_total_minutes = start_hour * 60 + start_minute
	var end_total_minutes = end_hour * 60 + end_minute
	
	
	var time_difference = end_total_minutes - start_total_minutes
	
	if time_difference < 0:
		time_difference += 24 * 60  
	
	return int((time_difference / 60.0) * 10) / 10.0;

func change_time_between():
	queued_data_start.hours = spin_box_start_h.value;
	queued_data_start.minutes =  spin_box_start_m.value;
	var selecteds = option_button_s.selected;
	queued_data_start.ampm = option_button_s.get_item_text(selecteds);
	queued_data_end.hours = spin_box_end_h.value;
	queued_data_end.minutes = spin_box_end_m.value;
	var selectede = option_button_e.selected;
	queued_data_end.ampm = option_button_e.get_item_text(selectede);
	
	if queued_data_start.hours == queued_data_end.hours && queued_data_start.minutes == queued_data_end.minutes && queued_data_start.ampm == queued_data_end.ampm:
		hours_between_label.text = "Hours Between: 0 hr";
		return;
	
	var start_time = "%s:%s%s"%[queued_data_start.hours, queued_data_start.minutes, queued_data_start.ampm];
	var end_time = "%s:%s%s"%[queued_data_end.hours, queued_data_end.minutes, queued_data_end.ampm];
	var hours_between = hours_between(start_time, end_time);
	print(start_time);
	print(end_time);
	if hours_between > 1.9:
		hours_between_label.text = "Hours Between: %s hrs"%hours_between;
	else:
		hours_between_label.text = "Hours Between: %s hr"%hours_between;
	pass 


func _on_button_2_button_down():
	await Singleton.database.query("UPDATE time_limit SET start_time = '', end_time = '' ");
	print("Restriction Removed");
	time_limit_label.text = "Time Limit: ";
	hours_between_label.text = "";
	message.text = "Restriction removed."
	pass # Replace with function body.


func _on_spin_box_start_h_value_changed(value):
	change_time_between();
	pass # Replace with function body.

func _on_spin_box_start_m_value_changed(value):
	change_time_between();
	pass # Replace with function body.

func _on_spin_box_end_h_value_changed(value):
	change_time_between();
	pass # Replace with function body.

func _on_spin_box_end_m_value_changed(value):
	change_time_between();
	pass # Replace with function body.




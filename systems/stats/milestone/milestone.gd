extends Node2D
@onready var total_time = $Control/TextureRect/VBoxContainer/Total_Time
@onready var total_collection = $Control/TextureRect/VBoxContainer/Total_Collection;
@onready var total_pet_fully_fed = $Control/TextureRect/VBoxContainer/Total_Pet_Fully_Fed
@onready var total_games_played = $Control/TextureRect/VBoxContainer/Total_Games_Played;
@onready var total_days_played = $Control/TextureRect/VBoxContainer/Total_Days_Played
@onready var total_money_earned = $Control/TextureRect/VBoxContainer/Total_Money_Earned
@onready var transition_layer = $Transition_Layer


func get_transition_layer():
	return transition_layer;

func _ready():
	var child = DataManager._get_current_child();
	print("THIS", child);
	print(GameData.current_child_id);
	if child.size() == 0:
		print_debug("child does not exist");
		return;
	update_datas();
	display_datas();

func update_datas():
	DataManager._update_milestone_total_time();
	DataManager._update_milestone_total_collection();
	DataManager._update_milestone_total_games_played(GameData.current_child_id);

func total_time_converter(seconds):
	var minutes = float(seconds) / 60; 
	var hours = float(minutes) / 60;
	var time;
	var text;
	var time_text;
	
	if hours >= 1:
		time = round(hours * 10) / 10;
		if time == 1:
			text = "hour";
		else:
			text = "hours"
	else:
		print("minutes");
		time = round(minutes * 10) / 10
		
		if time == 1:
			text = "minute";
		else:
			text = "minutes"
	
	print(text);
	
	time_text = "%s %s" %[time, text];
	return time_text;

func display_datas():
	var milestone_datas_db = DataManager._get_milestone_datas();
	#print_debug(milestone_datas_db);
	
	var text_total_time = total_time_converter(milestone_datas_db[0].total_time);
	print(text_total_time)
	total_time.text = "Total Time: %s" %text_total_time;
	
	var text_total_collection = milestone_datas_db[0].total_collection;
	total_collection.text = "Total Collection: %s" %text_total_collection;
	
	var text_total_pet_fully_fed = milestone_datas_db[0].total_pet_fully_fed;
	total_pet_fully_fed.text = "Total Pet Fully Brain Fed: %s" %text_total_pet_fully_fed;
	
	var text_total_games_played = milestone_datas_db[0].total_games_played;
	total_games_played.text = "Total Games Played: %s" %text_total_games_played;
	
	var text_total_days_played = milestone_datas_db[0].total_days_played;
	total_days_played.text = "Total Days Played: %s" %text_total_days_played;
	
	var text_total_money_earned = milestone_datas_db[0].total_money_earned;
	total_money_earned.text = "Total Money Earned: %s" %text_total_money_earned;
	

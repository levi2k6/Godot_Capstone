extends Panel



func interpret():
	var games_count = DataManager._get_all_game_counts();
	
	
	
	
	
	



func percent_gap_between(normal, hard):
	var percent_between:float ;
	if normal >= hard:
		percent_between = (float(normal) - float(hard)) / float(hard) * 100;
	elif normal <= hard:
		print("this workedddd");
		percent_between = (float(hard) - float(normal)) / float(normal) * 100;
	
	return percent_between;
	
	



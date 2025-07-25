extends Panel
@onready var rich_text_label = $RichTextLabel
@onready var drawer = $"../../drawer"



func _ready():
	var child = DataManager._get_current_child();
	if child.size() == 0:
		return;
	

func interpret():
	var session_datas_all = [];
	var session_datas_normal = [];
	var session_datas_hard = [];
	var highest_level;
	
	var cognitive_skill;
	
	if drawer.current_game == "game1":
		cognitive_skill = "visual memory";
		session_datas_all = DataManager._get_game_sessions("sequence", null);
		session_datas_normal = DataManager._get_game_sessions("sequence", "normal");
		session_datas_hard = DataManager._get_game_sessions("sequence" , "hard");
		highest_level = DataManager._get_game_dynamic("sequence_game")[0].highest_level;
	elif drawer.current_game == "game2":
		cognitive_skill = "number memory";
		session_datas_all = DataManager._get_game_sessions("number_memory", null);
		session_datas_normal = DataManager._get_game_sessions("number_memory", "normal");
		session_datas_hard = DataManager._get_game_sessions("number_memory" , "hard");
		highest_level = DataManager._get_game_dynamic("number_memory_game")[0].highest_level;
	elif drawer.current_game == "game3":
		cognitive_skill = "reaction time";
		session_datas_all = DataManager._get_game_sessions("timing", null);
		session_datas_normal = DataManager._get_game_sessions("timing", "normal");
		session_datas_hard = DataManager._get_game_sessions("timing" , "hard");
		highest_level = DataManager._get_game_dynamic("timing_game")[0].highest_level;
	
	
	var normal_count = session_datas_normal.size();
	var hard_count = session_datas_hard.size();
	#var normal_count = 100;
	#var hard_count = 300;
	var percent_between_count = percent_gap_between(normal_count, hard_count);
	#print_debug("percent_count: " , percent_between_count);
	
	
	var all_median = get_levels_median(session_datas_all)
	var normal_median = get_levels_median(session_datas_normal);
	var hard_median = get_levels_median(session_datas_hard);
	#var all_median = 1000;
	#var normal_median = 400;
	#var hard_median = 200;
	var percent_between_median = percent_gap_between(normal_median, hard_median);
	
	#print("normal_median: ", normal_median , " hard_median: " , hard_median);
	#print("percent_median: " , percent_between_median);
	var median_text: String;
	var count_text: String;
	var median_count_text: String;
	var conclusion_text: String;
	
	var interpretation_text = "";
	
	
	if normal_count < 10 && hard_count < 10:
		median_count_text = "Child must have atleast 10 game sessions in [color=#ffb159]normal[/color] and [color=#cf2828]hard[/color] difficulty to be interpreted.";
		interpretation_text = "All Median: [color=#49e21e]%s[/color] \nNormal Median: [color=#ffb159]%s[/color] \nHard Median: [color=#cf2828]%s[/color] \n%% Between Hard And Normal: %s%%  \n\n%s"%[all_median, normal_median, hard_median ,percent_between_median, median_count_text];
		rich_text_label.text = interpretation_text;
		return;
	
	if normal_count < 10:
		median_count_text = "Child must have atleast 10 game sessions in [color=#ffb159]normal[/color] difficulty to be interpreted.";
		interpretation_text = "All Median: [color=#49e21e]%s[/color] \nNormal Median: [color=#ffb159]%s[/color] \nHard Median: [color=#cf2828]%s[/color] \n%% Between Hard And Normal: %s%%  \n\n%s"%[all_median, normal_median, hard_median ,percent_between_median, median_count_text];
		rich_text_label.text = interpretation_text;
		return;
	
	if hard_count < 10:
		median_count_text = "Child must have atleast 10 game sessions in [color=#cf2828]hard[/color] difficutly to be interpreted.";
		interpretation_text = "All Median: [color=#49e21e]%s[/color] \nNormal Median: [color=#ffb159]%s[/color] \nHard Median: [color=#cf2828]%s[/color] \n%% Between Hard And Normal: %s%%  \n\n%s"%[all_median, normal_median, hard_median ,percent_between_median, median_count_text];
		rich_text_label.text = interpretation_text;
		return;
	
	if normal_count > hard_count:
		if  hard_median == 0:
			count_text = "Child only plays in [color=#ffb159]normal[/color] difficutly";
		elif normal_median > hard_median:
			if percent_between_count <= 5:
				count_text = "Child slightly plays more and is ";
			elif percent_between_median <= 15:
				count_text = "Child moderately plays more and is ";
			elif percent_between_median > 15:
				count_text = "Child significantly plays more and is ";
		elif normal_median < hard_median:
			if percent_between_count <= 5:
				count_text = "Child slightly plays more in [color=#ffb159]normal[/color] difficulty, but is ";
			elif percent_between_median <= 15:
				count_text = "Child moderately plays more in [color=#ffb159]normal[/color] difficulty, but is ";
			elif percent_between_median > 15:
				count_text = "Child significantly plays more in [color=#ffb159]normal[/color] difficutly, but is ";
		elif normal_median == hard_median:
			if percent_between_count <= 5:
				count_text = "Child slightly plays more in [color=#ffb159]normal[/color] difficulty, but ";
			elif percent_between_median <= 15:
				count_text = "Child moderately plays more in [color=#ffb159]normal[/color] difficulty, but ";
			elif percent_between_median > 15:
				count_text = "Child significantly plays more in [color=#ffb159]normal[/color] difficulty, but ";
	elif normal_count < hard_count:
		if normal_median == 0:
			count_text = "Child only plays in the [color=#cf2828]hardest[/color] difficutly";
		elif normal_median < hard_median:
			if percent_between_count <= 5:
				count_text = "Child slightly plays more and is ";
			elif percent_between_median <= 15:
				count_text = "Child moderately plays more and is ";
			elif percent_between_median > 15:
				count_text = "Child significantly plays more and is ";
		elif normal_median > hard_median:
			if percent_between_count <= 5:
				count_text = "Child slightly plays more in the [color=#cf2828]hardest[/color] difficulty, but is ";
			elif percent_between_median <= 15:
				count_text = "Child moderately plays more in the [color=#cf2828]hardest[/color] difficulty, but is ";
			elif percent_between_median > 15:
				count_text = "Child significantly plays more in the [color=#cf2828]hardest[/color] difficutly, but is ";
		elif normal_median == hard_median:
			if percent_between_count <= 5:
				count_text = "Child slightly plays more in the [color=#cf2828]hardest[/color] difficulty, but ";
			elif percent_between_median <= 15:
				count_text = "Child moderately plays more in the [color=#cf2828]hardest[/color] difficulty, but ";
			elif percent_between_median > 15:
				count_text = "Child significantly plays more in the [color=#cf2828]hardest[/color] difficulty, but ";
	elif normal_count == hard_count:
		if normal_median == hard_median:
			if percent_between_count <= 5:
				count_text = "Child plays both [color=#ffb159]normal[/color] and hard difficulty evenly, and ";
			elif percent_between_median <= 15:
				count_text = "Child plays both [color=#ffb159]normal[/color] and hard difficulty evenly, and ";
			elif percent_between_median > 15:
				count_text = "Child plays both [color=#ffb159]normal[/color] and hard difficulty evenly, and ";
		else:
			count_text = "Child plays both [color=#ffb159]normal[/color] and [color=#cf2828]hard[/color] difficulty evenly, but is ";

	if normal_median > hard_median:
		if hard_count == 0:
			median_text = ".";
		elif percent_between_median <= 5:
			median_text = "slightly more competent in [color=#ffb159]normal[/color] difficulty.";
		elif percent_between_median <= 15:
			median_text = "moderately more competent in [color=#ffb159]normal[/color] difficulty.";
		elif percent_between_median <= 50:
			median_text = "more competent in [color=#ffb159]normal[/color] difficulty.";
		elif percent_between_median > 50:
			median_text = "highly more competent in [color=#ffb159]normal[/color] difficulty.";
	elif normal_median < hard_median:
		if normal_count == 0:
			median_text = ".";
		elif percent_between_median <= 5:
			median_text = "slightly more competent in the [color=#cf2828]hardest[/color] difficulty.";
		elif percent_between_median <= 15:
			median_text = "moderately more competent in the [color=#cf2828]hardest[/color] difficulty.";
		elif percent_between_median <= 50:
			median_text = "more competent in the [color=#cf2828][color=#cf2828]hardest[/color][/color] difficulty.";
		elif percent_between_median > 50:
			median_text = "highly more competent in the [color=#cf2828]hardest[/color] difficulty.";
	elif normal_median == hard_median:
		median_text = "competence are the same in both [color=#ffb159]normal[/color] and [color=#cf2828]hard[/color] difficulty.";
		pass
	
	
	if normal_median > hard_median:
		if normal_count == 0:
			conclusion_text = "";
		elif all_median <= 5:
			conclusion_text = "In theory, child is incompetent in %s."%cognitive_skill;
		elif all_median <= 15:
			conclusion_text = "In theory, child is slightly incompetent in %s."%cognitive_skill;
		elif all_median <= 50:
			conclusion_text = "In theory, child is average in %s."%cognitive_skill;
		elif all_median > 50:
			conclusion_text = "In theory, child is slightly above average in %s."%cognitive_skill;
	elif normal_median == hard_median:
		if all_median <= 5:
			conclusion_text = "In theory, child is slightly incompetent in %s."%cognitive_skill;
		elif all_median <= 15:
			conclusion_text = "In theory, child is average in %s."%cognitive_skill;
		elif all_median <= 50:
			conclusion_text = "In theory, child is slightly above average in %s."%cognitive_skill;
		elif all_median > 50:
			conclusion_text = "In theory, child is above average in %s."%cognitive_skill;
	elif normal_median < hard_median:
		if hard_count == 0:
			conclusion_text = "";
		elif all_median <= 5:
			conclusion_text = "In theory, child is slightly competent in %s."%cognitive_skill;
		elif all_median <= 15:
			conclusion_text = "In theory, child is average in %s."%cognitive_skill;
		elif all_median <= 50:
			conclusion_text = "In theory, child is above average in %s."%cognitive_skill;
		elif all_median > 50:
			conclusion_text = "In theory, child is highly competent in %s."%cognitive_skill;

	
	
	median_count_text = count_text + median_text;
	interpretation_text = "All Median: [color=#49e21e]%s[/color] \nNormal Median: [color=#ffb159]%s[/color] \nHard Median: [color=#cf2828]%s[/color] \n%% Between Hard And Normal: %s%%  \n\n[b]Analysis[/b]: %s \n\n[b]Interpretation[/b]: %s"%[all_median, normal_median, hard_median ,percent_between_median, median_count_text, conclusion_text];
	rich_text_label.text = interpretation_text;  
	


func get_levels_median(datas):
	var levels_arranged = [];
	for data in datas:
		levels_arranged.append(data.level_reached);
	
	levels_arranged.sort();
	
	print("LOOKA TIM HERE: ", levels_arranged.size())
	
	if levels_arranged.size() == 0:
		return 0;
	
	var amount = levels_arranged.size();
	if levels_arranged.size() % 2 != 0:
		return levels_arranged[amount/2];
	
	
	var median_value = (levels_arranged[amount / 2 - 1] + levels_arranged[amount / 2]) / 2.0
	return median_value;


func percent_gap_between(normal, hard):
	var percent_between:float ;
	if normal >= hard:
		percent_between = (float(normal) - float(hard)) / float(hard) * 100;
	elif normal <= hard:
		percent_between = (float(hard) - float(normal)) / float(normal) * 100;
	
	return percent_between;
	
	



extends Node

func _ready():
	_create_status();
	_update_today_database();

func _get_child_database():
	Singleton.database.query(" SELECT * FROM child;")
	var result = Singleton.database.query_result;
	return result;

func _get_pet_database():
	Singleton.database.query("SELECT * FROM pet;")
	var result = Singleton.database.query_result;
	return result;

func _update_pet_hunger(hunger):
	var child_id = _get_child_database()[0].id
	Singleton.database.update_rows("pet","id = %s"%child_id, {"hunger": hunger});


func _get_collection_database():
	Singleton.database.query("SELECT * FROM collection;");
	var result = Singleton.database.query_result;
	return result

func _get_money_database():
	Singleton.database.query(
		"SELECT money FROM datas;"
	)
	var result = Singleton.database.query_result
	return result

func _get_date():
	Singleton.database.query("SELECT * FROM date");
	var result = Singleton.database.query_result;
	return result;

func _get_today_database():
	Singleton.database.query("SELECT today FROM date;")
	var result = Singleton.database.query_result	
	return result

func _update_today_database():
	var today = Time.get_datetime_dict_from_system().day
	var today_or_old = _get_today_database()
	
	if _get_today_database().size() == 0:
		Singleton.database.insert_row("date", {"today": today});
		#print(today)
		print_debug("THIS IS WORKING");
	elif today_or_old[0].today != today:
		Singleton.database.query("UPDATE date SET today = %s" %today);
		_update_redeem_status(0);
		_update_fully_fed_status(0);
		_update_milestone_total_days_played();
		print_debug("THIS IS WORKING NEW DAY");
		#print("TODAY IS: ", today)
		
		var child_id = DataManager._get_child_database()[0].id
		Singleton.database.update_rows("pet", "id = %s"%child_id, {"hunger": 0})

func _create_status():
	var status = _get_status();
	if status.size() != 0:
		return
	Singleton.database.query("INSERT INTO status(redeem_status, fully_fed_status) VALUES(0, 0)")

func _get_status():
	Singleton.database.query("SELECT * FROM status");
	var result = Singleton.database.query_result;
	return result;

func _update_redeem_status(data):
	Singleton.database.update_rows("status", "1=1", {"redeem_status": data});

func _update_fully_fed_status(data):
	Singleton.database.update_rows("status", "1=1", {"fully_fed_status": data});


func _update_money_database(money):
	var child_id = _get_child_database()[0].id
	
	Singleton.database.update_rows("datas", "id = %s"%child_id, {"money": money});
	print("MONEY DEDUCTED")

#games///////////////////


func _get_game_dynamic(game):
	var child = DataManager._get_child_database();
	if child.size() == 0:
		return;
	var child_id = child[0].id;
	Singleton.database.query("SELECT * FROM %s WHERE id = %d" % [game, child_id]);
	var result = Singleton.database.query_result;
	return result;

func _get_all_game_counts():
	Singleton.database.query("
	SELECT 'sequence_session' AS name, COUNT(*) AS count FROM sequence_session
	UNION ALL 
	SELECT 'number_memory_session' AS name, COUNT(*) FROM number_memory_session
	UNION ALL
	SELECT 'timing_session' AS name, COUNT(*) FROM timing_session;
	");
	var result = Singleton.database.query_result;
	return result;

func _get_sequence_game_database():
	var child_id = _get_child_database()[0].id;
	Singleton.database.query("SELECT * FROM child where id = %s;" % [str(child_id)] );
	var result = Singleton.database.query_result;
	return result;


func _get_game_sessions(from ,where):
	var query = "SELECT * FROM %s_session WHERE id IN (SELECT session_id FROM %s_junction_session)" %[from, from];
	if where != null:
		query += " AND difficulty = '%s'" %where;
		#print_debug(query);
	Singleton.database.query(query);
	var result = Singleton.database.query_result;
	return result;


func _insert_game1_session(level, difficulty):
	var child_id = _get_child_database()[0].id;
	Singleton.database.query("INSERT INTO sequence_session(level_reached, difficulty) VALUES(%d, '%s')" %[level, difficulty]);
	var last_id = Singleton.database.last_insert_rowid;
	Singleton.database.insert_row("sequence_junction_session", {"game_id": child_id, "session_id": last_id});
	
	dynamic_update_game_data("sequence_session", "sequence_game", child_id);

func _insert_game2_session(level, difficulty):
	var child_id = _get_child_database()[0].id;
	Singleton.database.query("INSERT INTO number_memory_session(level_reached, difficulty) VALUES(%d, '%s')"%[level, difficulty] );
	var last_id = Singleton.database.last_insert_rowid;
	Singleton.database.insert_row("number_memory_junction_session", {"game_id": child_id, "session_id": last_id});
	
	dynamic_update_game_data("number_memory_session", "number_memory_game", child_id);

func _insert_game3_session(level, difficulty):
	var child_id = _get_child_database()[0].id;
	Singleton.database.query("INSERT INTO timing_session(level_reached, difficulty) VALUES(%d, '%s')" %[level, difficulty] );
	var last_id = Singleton.database.last_insert_rowid;
	Singleton.database.insert_row("timing_junction_session", {"game_id": child_id, "session_id": last_id});
	
	dynamic_update_game_data("timing_session", "timing_game", child_id);

func dynamic_update_game_data(session: String, game: String, child_id: int):
	var game_session = session;
	var game_name = game;
	
	var result_dict1;
	var result_dict2;
	Singleton.database.query("SELECT MAX(level_reached) FROM %s;" %game_session);
	result_dict1 = Singleton.database.query_result[0];
	var highest_level  = result_dict1["MAX(level_reached)"];
	Singleton.database.query("SELECT COUNT(*) FROM %s;" %game_session);
	result_dict2 = Singleton.database.query_result[0];
	var total_session = result_dict2["COUNT(*)"];
	Singleton.database.update_rows("%s" %game_name, "id = %s"%child_id, {"total_session": total_session, "highest_level": highest_level});

#Milestone/////////////////////

func _get_milestone_datas():
	var child_id = _get_child_database()[0].id;
	Singleton.database.query("SELECT * FROM milestone WHERE  id = %s"%child_id);
	var result = Singleton.database.query_result;
	return result;

func _update_milestone_total_time():
	var child = _get_child_database();
	if child.size() == 0:
		return
	var child_id = child[0].id;
	var time_track = int(GameData.time_track);
	Singleton.database.update_rows("milestone", "id = %s" %child_id, {"total_time": time_track});

func _update_milestone_total_collection():
	var child_id = _get_child_database()[0].id;
	Singleton.database.query("SELECT COUNT(*) FROM collection WHERE child_id = %s" %child_id);
	var query_result = Singleton.database.query_result[0];
	var collection_count = query_result["COUNT(*)"];
	Singleton.database.update_rows("milestone", "id = %s" %child_id, {"total_collection": collection_count});

func _update_milestone_total_pet_fully_fed():
	Singleton.database.query("UPDATE milestone SET total_pet_fully_fed = total_pet_fully_fed + 1");

func _update_milestone_total_days_played():
	print("TOTAL DAYS ADDED");
	Singleton.database.query("UPDATE milestone SET total_days_played = total_days_played + 1");

func _update_milestone_total_games_played():
	var child_id = _get_child_database()[0].id;
	Singleton.database.query("SELECT 
		(SELECT COUNT(*) FROM sequence_session) +
		(SELECT COUNT(*) FROM number_memory_session) +
		(SELECT COUNT(*) FROM timing_session) AS total_count;
	");
	var total_games_played_count = Singleton.database.query_result[0].total_count;
	Singleton.database.update_rows("milestone", "id = %s" %child_id, {"total_games_played": total_games_played_count});

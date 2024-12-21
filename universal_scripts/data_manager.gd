extends Node

func _ready():
	_update_today_database();

func _insert_time_limit():
	Singleton.database.insert_row("time_limit", {"start_time": "", "end_time":""});

func _get_time_limit_database():
	Singleton.database.query(" SELECT * FROM time_limit;");
	var result = Singleton.database.query_result;
	return result;

func _get_parent_database():
	Singleton.database.query(" SELECT * FROM parent;");
	var result = Singleton.database.query_result;
	return result;

func _get_current_child():
	var child = _get_child_database(GameData.current_child_id);
	return child;

func _get_all_child_database():
	Singleton.database.query("SELECT * FROM child;")
	var result = Singleton.database.query_result;
	return result;

func _get_child_database(id):
	Singleton.database.query("SELECT * FROM child WHERE id = %s;"%id);
	var result = Singleton.database.query_result;
	return result;

func _get_current_pet():
	var pet = _get_pet_database(GameData.current_child_id);
	return pet;


func _get_all_pet_database():
	Singleton.database.query("SELECT * FROM pet;")
	var result = Singleton.database.query_result;
	return result;

func _get_pet_database(id):
	Singleton.database.query("SELECT * FROM pet WHERE id = %s;"%id);
	var result = Singleton.database.query_result;
	return result;

func _update_pet_hunger(hunger):
	var child_id = _get_current_child()[0].id;
	Singleton.database.update_rows("pet","id = %s"%child_id, {"hunger": hunger});


func _get_collection_database(id):
	Singleton.database.query("SELECT * FROM collection WHERE child_id = %s;"%id);
	var result = Singleton.database.query_result;
	return result;

func _get_money_database():
	var child_id = _get_current_child()[0].id;
	Singleton.database.query( "SELECT money FROM datas WHERE id = %s;"%child_id)
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
	
	if GameData.current_child_id == 0:
		print("no child");
		return
	
	if _get_today_database().size() == 0:
		Singleton.database.insert_row("date", {"today": today});
		#print(today)
		print_debug("THIS IS WORKING");
	elif today_or_old[0].today != today:
		var child_id = _get_current_child()[0].id;
		Singleton.database.query("UPDATE date SET today = %s" %today);
		_update_redeem_status(0);
		_update_fully_fed_status(0);
		_update_milestone_total_days_played(child_id);
		print_debug("THIS IS WORKING NEW DAY");
		#print("TODAY IS: ", today)
		
		Singleton.database.update_rows("pet", "id = %s"%child_id, {"hunger": 0})

func _get_status(id):
	Singleton.database.query("SELECT * FROM status WHERE id = %s"%id);
	var result = Singleton.database.query_result;
	return result;

func _update_redeem_status(data):
	Singleton.database.update_rows("status", "1=1", {"redeem_status": data});

func _update_fully_fed_status(data):
	Singleton.database.update_rows("status", "1=1", {"fully_fed_status": data});


func _update_money_database(money):
	var child_id = _get_current_child()[0].id;
	
	Singleton.database.update_rows("datas", "id = %s"%child_id, {"money": money});
	print("MONEY DEDUCTED")

#games///////////////////


func _get_game_dynamic(game):
	var child = _get_current_child();
	if child.size() == 0:
		return;
	var child_id = child[0].id;
	Singleton.database.query("SELECT * FROM %s WHERE id = %d" % [game, child_id]);
	var result = Singleton.database.query_result;
	return result;

func _get_all_game_counts(id):
	print("look at this id" , id);
	Singleton.database.query("
	SELECT 'sequence_session' AS name, COUNT(*) AS count FROM sequence_junction_session WHERE game_id = %s
	UNION ALL 
	SELECT 'number_memory_session' AS name, COUNT(*) FROM number_memory_junction_session WHERE game_id = %s
	UNION ALL 
	SELECT 'timing_session' AS name, COUNT(*) FROM timing_junction_session WHERE game_id = %s;
	"%[id,id,id]
	);
	var result = Singleton.database.query_result;
	return result;

func _get_sequence_game_database():
	var child_id = _get_current_child()[0].id;
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

func _get_game_highest_normal(game):
	var query = "SELECT MAX(level_reached) AS highest FROM %s_session WHERE difficulty = 'normal'"%game;
	Singleton.database.query(query);
	var result = Singleton.database.query_result;
	return result;

func _get_game_highest_hard(game):
	var query = "SELECT MAX(level_reached) AS highest FROM %s_session WHERE difficulty = 'hard'"%game;
	Singleton.database.query(query);
	var result = Singleton.database.query_result;
	return result;


func _insert_game1_session(level, difficulty):
	var child_id = _get_current_child()[0].id
	Singleton.database.query("INSERT INTO sequence_session(level_reached, difficulty) VALUES(%d, '%s')" %[level, difficulty]);
	var last_id = Singleton.database.last_insert_rowid;
	Singleton.database.insert_row("sequence_junction_session", {"game_id": child_id, "session_id": last_id});
	
	dynamic_update_game_data("sequence_session", "sequence_game", child_id);

func _insert_game2_session(level, difficulty):
	var child_id = _get_current_child()[0].id
	Singleton.database.query("INSERT INTO number_memory_session(level_reached, difficulty) VALUES(%d, '%s')"%[level, difficulty] );
	var last_id = Singleton.database.last_insert_rowid;
	Singleton.database.insert_row("number_memory_junction_session", {"game_id": child_id, "session_id": last_id});
	
	dynamic_update_game_data("number_memory_session", "number_memory_game", child_id);

func _insert_game3_session(level, difficulty):
	var child_id = _get_current_child()[0].id
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
	var child_id = _get_current_child()[0].id
	Singleton.database.query("SELECT * FROM milestone WHERE  id = %s"%child_id);
	var result = Singleton.database.query_result;
	return result;

func _update_milestone_total_time():
	var child = _get_current_child();
	if child.size() == 0:
		return
	var child_id = child[0].id;
	var time_track = int(GameData.time_track);
	Singleton.database.update_rows("milestone", "id = %s" %child_id, {"total_time": time_track});

func _update_milestone_total_collection():
	var child_id = _get_current_child()[0].id;
	Singleton.database.query("SELECT COUNT(*) FROM collection WHERE child_id = %s" %child_id);
	var query_result = Singleton.database.query_result[0];
	var collection_count = query_result["COUNT(*)"];
	Singleton.database.update_rows("milestone", "id = %s" %child_id, {"total_collection": collection_count});

func _update_milestone_total_pet_fully_fed(id):
	Singleton.database.query("UPDATE milestone SET total_pet_fully_fed = total_pet_fully_fed + 1 WHERE id = %s"%id);

func _update_milestone_total_days_played(id):
	print("TOTAL DAYS ADDED");
	Singleton.database.query("UPDATE milestone SET total_days_played = total_days_played + 1 WHERE id = %s" %id);

func _update_milestone_total_games_played(id):
	var child_id = _get_current_child()[0].id
	Singleton.database.query("SELECT 
		(SELECT COUNT(*) FROM sequence_session WHERE id = %s) +
		(SELECT COUNT(*) FROM number_memory_session WHERE id = %s) +
		(SELECT COUNT(*) FROM timing_session WHERE id = %s) AS total_count;
	"%[id,id,id]);
	var total_games_played_count = Singleton.database.query_result[0].total_count;
	Singleton.database.update_rows("milestone", "id = %s" %child_id, {"total_games_played": total_games_played_count});

func _update_milestone_total_money_earned(money):
	print("LOKLOKLOKLOKLOK", money);
	var child_id = _get_current_child()[0].id
	Singleton.database.query("UPDATE milestone SET total_money_earned = total_money_earned + %s WHERE id = %s" %[money, child_id]);

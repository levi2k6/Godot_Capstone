extends Node

func _ready():
	_update_today_database();

func _get_child_database():
	Singleton.database.query(" SELECT * FROM child;")
	var result = Singleton.database.query_result;
	return result
	pass

func _get_pet_database():
	Singleton.database.query("SELECT * FROM pet;")
	var result = Singleton.database.query_result
	return result
	

func _update_pet_hunger(hunger):
	var child_id = _get_child_database()[0].id
	Singleton.database.update_rows("pet","id = %s"%child_id, {"hunger": hunger})


func _get_collection_database():
	Singleton.database.query("SELECT * FROM collection;")
	var result = Singleton.database.query_result
	return result

func _get_money_database():
	Singleton.database.query(
		"SELECT money FROM datas;"
	)
	var result = Singleton.database.query_result
	return result

func _get_today_database():
	Singleton.database.query("SELECT today FROM date;")
	var result = Singleton.database.query_result	
	return result

func _update_today_database():
	var today = Time.get_datetime_dict_from_system().day
	var today_or_old = _get_today_database()
	
	
	if _get_today_database().size() == 0:
		Singleton.database.insert_row("date", {"today": today})
		#print(today)
		#print(_get_today_database()[0].today)
	elif today_or_old[0].today != today:
		Singleton.database.query("UPDATE date SET today = %s" %today)
		print("YESTERDAY WAS: ", today_or_old[0].today)
		print("TODAY IS: ", today)
		
		var child_id = DataManager._get_child_database()[0].id
		Singleton.database.update_rows("pet", "id = %s"%child_id, {"hunger": 0})

func _update_money_database(money):
	var child_id = _get_child_database()[0].id
	
	Singleton.database.update_rows("datas", "id = %s"%child_id, {"money": money})
	print("MONEY DEDUCTED")

func _get_sequence_game_database():
	var child_id = _get_child_database()[0].id
	Singleton.database.query("SELECT * FROM child where id = %s;" % [str(child_id)] );
	var result = Singleton.database.query_result;
	return result;

func _insert_game1_session(level):
	var child_id = _get_child_database()[0].id;
	Singleton.database.query("INSERT INTO sequence_session(level_reached) VALUES(%d)"%level);
	var last_id = Singleton.database.last_insert_rowid;
	Singleton.database.insert_row("sequence_junction_session", {"game_id": child_id, "session_id": last_id});
	
	var result_dict1;
	var result_dict2;
	Singleton.database.query("SELECT MAX(level_reached) FROM sequence_session");
	result_dict1 = Singleton.database.query_result[0];
	var highest_level  = result_dict1["MAX(level_reached)"];
	Singleton.database.query("SELECT COUNT(*) FROM sequence_session;");
	result_dict2 = Singleton.database.query_result[0];
	var total_session = result_dict2["COUNT(*)"];
	Singleton.database.update_rows("sequence_game", "id = %s"%child_id, {"total_session": total_session, "highest_level": highest_level});

func _insert_game2_session(level):
	var child_id = _get_child_database()[0].id;
	Singleton.database.query("INSERT INTO number_memory_session(level_reached) VALUES(%d)"%level);
	var last_id = Singleton.database.last_insert_rowid;
	Singleton.database.insert_row("number_memory_junction_session", {"game_id": child_id, "session_id": last_id});
	
	var result_dict1;
	var result_dict2;
	Singleton.database.query("SELECT MAX(level_reached) FROM number_memory_session");
	result_dict1 = Singleton.database.query_result[0];
	var highest_level  = result_dict1["MAX(level_reached)"];
	Singleton.database.query("SELECT COUNT(*) FROM number_memory_session;");
	result_dict2 = Singleton.database.query_result[0];
	var total_session = result_dict2["COUNT(*)"];
	Singleton.database.update_rows("number_memory_game", "id = %s"%child_id, {"total_session": total_session, "highest_level": highest_level});

func _insert_game3_session(level):
	var child_id = _get_child_database()[0].id;
	Singleton.database.query("INSERT INTO timing_session(level_reached) VALUES(%d)"%level);
	var last_id = Singleton.database.last_insert_rowid;
	Singleton.database.insert_row("timing_junction_session", {"game_id": child_id, "session_id": last_id});
	
	var result_dict1;
	var result_dict2;
	Singleton.database.query("SELECT MAX(level_reached) FROM timing_session");
	result_dict1 = Singleton.database.query_result[0];
	var highest_level  = result_dict1["MAX(level_reached)"];
	Singleton.database.query("SELECT COUNT(*) FROM timing_session;");
	result_dict2 = Singleton.database.query_result[0];
	var total_session = result_dict2["COUNT(*)"];
	Singleton.database.update_rows("timing_game", "id = %s"%child_id, {"total_session": total_session, "highest_level": highest_level});



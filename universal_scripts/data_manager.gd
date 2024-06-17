extends Node




func _ready():
	_insert_today_database()
	
	pass




func _get_child_database():
	Singleton.database.query(" SELECT * FROM child;")
	var result = Singleton.database.query_result
	return result

func _get_pet_database():
	Singleton.database.query("SELECT * FROM pet;")
	var result = Singleton.database.query_result
	return result
	

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

func _insert_today_database():
	var today = Time.get_datetime_dict_from_system().day
	var today_or_old = _get_today_database()[0].today
	
	print(today)
	print(today_or_old)
	
	if today_or_old != today:
		Singleton.database.query("UPDATE date SET today = %s" %today)
		print("YESTERDAY WAS: ", today_or_old)
		print("TODAY IS: ", today)
		
		var child_id = DataManager._get_child_database()[0].id
		Singleton.database.update_rows("pet", "id = %s"%child_id, {"hunger": 0})



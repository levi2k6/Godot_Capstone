extends Node




func _ready():
	_update_today_database()
	
	pass


func _create_child_database():
	var child = _get_child_database()
	
	if child.size() == 0:
		Singleton.database.insert_row("child", {"fname": "", "lname": ""})
		var child_id = _get_child_database()[0].id
		Singleton.database.insert_row("datas", {"id": child_id, "money": 10})
	else: 
		print("child already exist")


func _get_child_database():
	Singleton.database.query(" SELECT * FROM child;")
	var result = Singleton.database.query_result
	return result


func _create_pet_database():
	Singleton.database.query("SELECT * FROM pet")
	var pet = Singleton.database.query_result
	var child_id = _get_child_database()[0].id
	
	if pet.size() == 0:
		Singleton.database.insert_row("pet", {"id":child_id, "name": "", "body_id": 0,"hunger": 50, "eyes_id": 0, "mouth_id":0, "hat_id": 0, "color_id": 0})
	else:
		print("pet already exist")

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

func _update_today_database():
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

func _update_money_database(money):
	var child_id = _get_child_database()[0].id
	
	Singleton.database.update_rows("datas", "id = %s"%child_id, {"money": money})
	print("MONEY DEDUCTED")



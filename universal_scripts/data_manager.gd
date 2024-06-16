extends Node




func _ready():
	
	
	pass




func _get_child_database():
	Singleton.database.query(" SELECT * FROM child")
	return Singleton.database.query_result

func _get_collection_database():
	Singleton.database.query(
		"SELECT * FROM collection;"
	)
	var result = Singleton.database.query_result
	
	return result

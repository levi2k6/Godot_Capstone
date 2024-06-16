extends Node2D




func _ready():
	
	var child = DataManager._get_child_database()
	
	if child.size() == 0:
		Singleton.database.insert_row("child", {"fname": "", "lname": ""})
	else: 
		print("child already exist")
	
	
	

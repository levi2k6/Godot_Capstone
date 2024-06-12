extends Node2D

func _ready():
	print("mama")
	Singleton.database.query(
		"SELECT * FROM child"
	)
	
	print(Singleton.database.query_result)
	if Singleton.database.query_result.size() == 0:
		$Main_Hub.visible = false
		$Character_Costumize.visible = true
		print("is empty")
	else:
		$Main_Hub.visible = true
		$Character_Costumize.visible = false
		print("is not empty")
		
		

















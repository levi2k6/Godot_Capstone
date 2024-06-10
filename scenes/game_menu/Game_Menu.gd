extends Node2D

func _ready():
	print("mama")
	Singleton.database.query(
		"SELECT * FROM child"
	)
	
	if Singleton.database.query_result.size() == 0:
		$Main_Hub.visible = true
		$Character_Costumize.visible = false
	else:
		$Character_Costumize.visible = true
		$Main_Hub.visible = false

















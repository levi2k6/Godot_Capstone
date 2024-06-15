extends Node2D

func _ready():
	print("mama")
	Singleton.database.query(
		"SELECT * FROM child"
	)
	
	
	print(Singleton.database.query_result)
	if Singleton.database.query_result.size() == 0:
		$Main_Hub_Button.visible = false
		$Create_Child_Button.visible = true
		print("is empty")
	else:
		$Main_Hub_Button.visible = true
		$Create_Child_Button.visible = false
		print("is not empty")
		
		

















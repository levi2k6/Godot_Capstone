extends Node2D




func _test():
	Singleton.database.insert_row("pet", {"name" :"donda" , "body_id" : 1, "eyes_id": 1, "mouth_id": 1, "hat_id": 1})









func _on_button_pressed():
	print("grow")
	

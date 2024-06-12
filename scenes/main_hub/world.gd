extends Node2D

func _ready():
	_connections()
	_triggers()
	pass


func _connections():
	
	get_child(0).connect("update_hunger", _update_hunger)
	
	pass

func _triggers():
	get_child(0)._update_hunger_bar()

func _update_hunger(hunger):
	print("what?")
	get_child(3).get_child(0).value = hunger

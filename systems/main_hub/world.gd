extends Node2D

func _ready():
	_connections()
	_triggers()
	pass


func _connections():
	
	$Pet.connect("update_hunger", _update_hunger)
	
	pass

func _triggers():
	$Pet._update_hunger_bar()

func _update_hunger(hunger):
	print("what?")
	get_child(2).get_child(0).value = hunger

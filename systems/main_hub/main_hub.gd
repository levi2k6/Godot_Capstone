extends Node2D
func _ready():
	_connections()
	_triggers()
	_display_money()
	#print(Time.get_date_dict_from_system())
	#print(Time.get_time_dict_from_system())
	pass

func _connections():
	$Pet.connect("update_hunger", _update_hunger)	
	pass

func _triggers():
	$Pet._update_hunger_bar()

func _update_hunger():
	var pet_hunger = DataManager._get_pet_database()[0].hunger
	get_child(2).get_child(0).value = pet_hunger

func _display_money():
	var money = DataManager._get_money_database()[0].money
	$UI.get_child(2).text = str(money)
	



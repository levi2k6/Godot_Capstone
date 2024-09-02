extends Node2D

@onready var money_display = $UI/Money

func _ready():
	#print(Time.get_date_dict_from_system())
	#print(Time.get_time_dict_from_system())
	#_resolution()
	_connections()
	_triggers()
	for item in ItemLibrary.library:
		print(item.name)
	pass

func _resolution():
	var view_port = get_viewport().size
	var center_x = view_port.x / 2
	var center_y = view_port.y / 2
	
	$Background.get_child(0).size = view_port
	$UI.size = view_port
	
	$Pet.position = Vector2(center_x, center_y)
	#$Background.get_child(0).

func _connections():
	$Pet.connect("update_hunger", update_hunger)
	pass

func _triggers():
	$Pet.update_hunger_bar()

func update_hunger():
	var pet_hunger = DataManager._get_pet_database()[0].hunger
	get_child(2).get_child(0).value = pet_hunger

func _on_get_money_pressed():
	var money = DataManager._get_money_database()[0].money
	var add = money + 5
	DataManager._update_money_database(add)
	print(add)
	money_display._display_money()
	pass # Replace with function body.

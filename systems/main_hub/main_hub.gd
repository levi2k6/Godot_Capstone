extends Node2D

@onready var money_display = $UI/Money


func _ready():
	#print(Time.get_date_dict_from_system())
	#print(Time.get_time_dict_from_system())
	_go_back()
	_connections()
	_triggers()
	
	
	pass

func _go_back():
	var equip_library = ItemLibrary._get_pet_equip_library()
	if equip_library.size() < 3:
		get_tree().change_scene_to_file("res://systems/create_pet/create_pet.tscn")


func _connections():
	$Pet.connect("update_hunger", _update_hunger)	
	pass

func _triggers():
	$Pet._update_hunger_bar()

func _update_hunger():
	var pet_hunger = DataManager._get_pet_database()[0].hunger
	get_child(2).get_child(0).value = pet_hunger






func _on_get_money_pressed():
	var money = DataManager._get_money_database()[0].money
	var add = money + 5
	DataManager._update_money_database(add)
	print(add)
	money_display._display_money()
	pass # Replace with function body.

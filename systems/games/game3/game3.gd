extends Node2D
@onready var money_count = $Control/Info/Money_Count
@onready var hunger_bar = $Control/Info/Hunger/Hunger_Bar


func _ready():
	_connections();
	update_hunger();

func _connections():
	$Pet.connect("update_hunger", update_hunger)
	pass

func update_hunger():
	var pet_hunger = DataManager._get_pet_database()[0].hunger;
	hunger_bar.value = pet_hunger;

func update_money(add):
	var money = DataManager._get_money_database()[0].money;
	var money_added = money + add;
	DataManager._update_money_database(money_added);
	print(add);
	money_count._display_money();

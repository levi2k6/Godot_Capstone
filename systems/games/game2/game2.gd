extends Node2D
@onready var pet = $Pet

@onready var money_node = $Game/Money
@onready var hunger_bar = $Game/Hunger_Bar


func _ready():
	_connections();
	update_hunger();

func _connections():
	pet.connect("update_hunger", update_hunger);
	pass

func update_hunger():
	var pet_hunger = DataManager._get_pet_database()[0].hunger;
	hunger_bar.value = pet_hunger;

func update_money():
	var money = DataManager._get_money_database()[0].money;
	var add = money + 10;
	DataManager._update_money_database(add);
	print(add);
	money_node._display_money();



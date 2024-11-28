extends Node2D
@onready var pet = $Pet;
@onready var money_count = $Game/Info/Money_Count;
@onready var hunger_bar = $Game/Info/Hunger/Hunger_Bar;
@onready var transition_layer = $Transition_Position/Transition_Layer;



func get_transition_layer():
	return transition_layer;

func _ready():
	_connections();
	update_hunger();

func _connections():
	pet.connect("update_hunger", update_hunger);
	pass

func update_hunger():
	var pet_hunger = DataManager._get_pet_database()[0].hunger;
	hunger_bar.value = pet_hunger;

func update_money(add):
	var money = DataManager._get_money_database()[0].money;
	var money_added = money + add;
	DataManager._update_money_database(money_added);
	DataManager._update_milestone_total_money_earned(add);
	print(add);
	money_count._display_money();



extends Node2D
@onready var pet = $Foreground/Pet
@onready var pet_name = $UI/Pet_Name
@onready var hunger_bar = $UI/Info/Hunger/Hunger_Bar

func _ready():
	_connections();
	_triggers();
	GameData.last_scene = get_tree().current_scene.get_scene_file_path();
	pet_name.text = DataManager._get_pet_database()[0].name;

func _connections():
	pet.connect("update_hunger", update_hunger)
	pass

func _triggers():
	pet.update_hunger_bar()

func update_hunger():
	var pet_hunger = DataManager._get_pet_database()[0].hunger
	hunger_bar.value = pet_hunger

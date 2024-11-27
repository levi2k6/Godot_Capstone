extends Node2D
@onready var pet = $Control/Pet_Control/Pet;
@onready var animator = $Animator;
@onready var transition_layer = $Transition_Layer


func get_transition_layer():
	return transition_layer;

func _ready():
	
	var pet_animators = pet.get_animator();
	animator.start(pet_animators);
	GameData.fully_fed_reward = true;








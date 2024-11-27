extends Node2D

@onready var animator_transition = $Transition_Layer/Animator_Transition


func _ready():
	animator_transition.play("transition_appear");

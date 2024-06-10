extends CharacterBody2D

signal update_hunger(hunger)


@export var properties : pet_stats_blueprint
var rng = RandomNumberGenerator.new()
var current_state
var previous_state

enum states{
	normal,
	happy,
	sad
}


func _ready():
	$body_animation.play("idle")
	state_chage()
	start_time()
	_fashion()


func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if get_child(5).get_child(2).get_rect().has_point(to_local(event.position)):
			_learn()
	
	if Input.is_action_just_pressed("ui_accept"):
		print(properties.hunger)
	


func _fashion():
	$Body_Parts.get_child(2).texture = properties.body
	$Body_Parts.get_child(2).get_child(1).get_child(1).texture = properties.eyes
	$Body_Parts.get_child(2).get_child(1).get_child(0).texture = properties.mouth
	$Body_Parts.get_child(2).get_child(0).texture = properties.hat
	
	


func _learn():
	properties.hunger += 10
	properties.hunger = clamp(properties.hunger, 0, 100)
	state_chage()
	_update_hunger_bar()
	
	

func _update_hunger_bar():
	emit_signal("update_hunger", properties.hunger)



func state_chage():
	if properties.hunger < 50:
		current_state = states.sad
	elif properties.hunger >= 50 and properties.hunger < 99:
		current_state = states.normal
	elif properties.hunger == 100:
		current_state = states.happy
	
	if previous_state != current_state:
		face_swap()


func face_swap():
	
	match current_state:
		states.normal:
			$eyes_animation.play("normal_blink")
			$mouth_animation.play("normal_switch")
		states.happy:
			$eyes_animation.play("happy_blink")
			$mouth_animation.play("happy_switch")
		states.sad:
			$eyes_animation.play("sad_blink")
			$mouth_animation.play("sad_switch")
	previous_state = current_state

func start_time():
	var time = rng.randi_range(4,8)
	#print(time)
	$Timer.wait_time = time
	$Timer.start()



func _on_timer_timeout():
	#print("TIMEOUT!!!!!")
	match current_state:
		states.normal:
			$eyes_animation.play("normal_blink")
		states.happy:
			$eyes_animation.play("happy_blink")
		states.sad:
			$eyes_animation.play("sad_blink")
	
	start_time()
	pass # Replace with function body.

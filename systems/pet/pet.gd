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
	start_time()
	_append_properties()
	state_chage()
	_fashion()


func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if get_child(5).get_child(2).get_rect().has_point(to_local(event.position)):
			_learn()
	
	if Input.is_action_just_pressed("ui_accept"):
		print(properties.hunger)
	

func _append_properties():
	
	properties.hunger = DataManager._get_pet_database()[0].hunger

func _fashion():
	var equip_items = ItemLibrary._get_pet_equip_library()
	
	if equip_items.size() == 0:
		return
	
	for item in equip_items:
		if item.type == "body":
			properties.body = item.texture
		if item.type == "eye":
			properties.eyes = item.texture
		if item.type == "mouth":
			properties.mouth = item.texture
		if item.type == "hat":
			properties.hat = item.texture
	
	$Body.get_child(2).texture = properties.body
	$Body.get_child(2).get_child(1).get_child(1).texture = properties.eyes
	$Body.get_child(2).get_child(1).get_child(0).texture = properties.mouth
	$Body.get_child(2).get_child(0).texture = properties.hat

func _learn():
	var child_id = DataManager._get_child_database()[0].id
	properties.hunger += 10
	properties.hunger = clamp(properties.hunger, 0, 100)
	print(properties.hunger)
	Singleton.database.update_rows("pet","id = %s"%child_id, {"hunger": properties.hunger})
	state_chage()
	_update_hunger_bar()

func _update_hunger_bar():
	var pet_hunger = DataManager._get_pet_database()[0].hunger
	emit_signal("update_hunger")

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

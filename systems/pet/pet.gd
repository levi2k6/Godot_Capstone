extends CharacterBody2D

signal update_hunger(hunger)

@onready var body_animation = $body_animation
@onready var eyes_animation = $eyes_animation
@onready var mouth_animation = $mouth_animation
@onready var timer = $Timer
@onready var blink_timer = $BlinkTimer



@export var properties : pet_stats_blueprint
var rng = RandomNumberGenerator.new()
var current_state
var previous_state
var fully_fed: bool;

enum states{
	normal,
	happy,
	sad
}


func _ready():
	body_animation.play("idle")
	start_time();
	check_hunger();
	state_chage();
	_fashion();

func check_hunger():
	properties.hunger = DataManager._get_pet_database()[0].hunger;
	var fully_fed_status = DataManager._get_status()[0].fully_fed_status;
	if get_tree().current_scene.name == "MainHub":
		if properties.hunger == 100:
			dance();

func dance():
	if get_tree().current_scene.name == "MainHub":
		body_animation.play("dance1");


func _fashion():
	var equip_items = ItemLibrary._get_pet_equip_library();
	#print("RIGHT HERE:: " , equip_items);
	if equip_items.size() == 0:
		print_debug("Empty Equip Items");
		return
	for item in equip_items:
		if item == null:
			continue
		if item.type == "body":
			properties.body = item.texture
			#print_debug(properties.body)
		if item.type == "eye":
			properties.eyes = item.texture
			#print_debug(properties.eyes)
		if item.type == "mouth":
			properties.mouth = item.texture
			#print_debug(properties.mouth)
		if item.type == "hat":
			properties.hat = item.texture
			#print_debug(properties.hat)
		if item.type == "color":
			$Body.get_child(2).self_modulate = item.name
			$Body.get_child(3).self_modulate = item.name
			$Body.get_child(4).self_modulate = item.name
	
	$Body.get_child(2).texture = properties.body
	$Body.get_child(2).get_child(1).get_child(1).texture = properties.eyes
	$Body.get_child(2).get_child(1).get_child(0).texture = properties.mouth
	$Body.get_child(2).get_child(0).texture = properties.hat

func _learn(xp):
	properties.hunger += xp;
	properties.hunger = clamp(properties.hunger, 0, 100);
	DataManager._update_pet_hunger(properties.hunger);
	state_chage();
	update_hunger_bar();
	
	var fully_fed_status = DataManager._get_status()[0].fully_fed_status;
	if fully_fed_status == 0:
		if properties.hunger == 100:
			DataManager._update_milestone_total_pet_fully_fed();
			DataManager._update_fully_fed_status(1);
			
			var transition_layer = get_tree().current_scene.get_transition_layer();
			timer.start(1);
			await timer.timeout;
			transition_layer.mouse_filter = Control.MOUSE_FILTER_STOP;
			print("mouse_filter: ", transition_layer.mouse_filter);
			await transition_layer.appear();
			GameData.transition_disappear = true;
			get_tree().change_scene_to_file("res://systems/fully_fed/fully_fed.tscn");
		else:
			print_debug("still hungry");

func update_hunger_bar():
	emit_signal("update_hunger");

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
			eyes_animation.play("normal_blink")
			mouth_animation.play("normal_switch")
		states.happy:
			eyes_animation.play("happy_blink")
			mouth_animation.play("happy_switch")
		states.sad:
			eyes_animation.play("sad_blink")
			mouth_animation.play("sad_switch")
	previous_state = current_state

func start_time():
	var time = rng.randi_range(4,8)
	#print(time)
	blink_timer.start(time)



func get_animator():
	var array = {
	"body_animation" : body_animation,
	"eyes_animation" : eyes_animation,
	"mouth_animation" : mouth_animation
	}
	
	return array;



func _on_timer_timeout():
	#print("TIMEOUT!!!!!")
	match current_state:
		states.normal:
			eyes_animation.play("normal_blink")
		states.happy:
			eyes_animation.play("happy_blink")
		states.sad:
			eyes_animation.play("sad_blink")
	
	start_time()
	pass # Replace with function body.


@onready var body = $Body/Body

func _on_touch_button_down():
	print_debug("CURRENT ANIMATOIN: ", body_animation.current_animation);
	
	if body_animation.current_animation == "dance1":
		var tween = get_tree().create_tween();
		tween.set_trans(Tween.TRANS_CUBIC);
		tween.set_ease(Tween.EASE_OUT);
		tween.tween_property(body, "rotation", 0, 0.5);
	
	match current_state:
		states.normal:
			eyes_animation.play("normal_blink")
		states.happy:
			eyes_animation.play("happy_blink")
		states.sad:
			eyes_animation.play("sad_blink")
	body_animation.play("flinch");
	await body_animation.animation_finished;
	
	body_animation.play("idle");
	pass # Replace with function body.

extends Node2D

@onready var icon = $Icon
@onready var icon_2 = $Icon2

func _ready():
	icon1_move()  # Linear motion (no easing)
	icon2_move()  # Ease-in motion

func icon1_move():
	var tween = get_tree().create_tween()
	# Default TRANS_LINEAR and EASE_IN_OUT ensures linear motion
	tween.tween_property(icon, "position", Vector2(500, icon.position.y), 1)

func icon2_move():
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_QUAD)    # Smooth easing transition
	tween.set_ease(Tween.EASE_IN)        # Apply ease-in for smoother start
	tween.tween_property(icon_2, "position", Vector2(500, icon_2.position.y), 1)

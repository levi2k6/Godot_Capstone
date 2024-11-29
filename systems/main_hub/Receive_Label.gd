extends Label
@onready var main_hub = $"../.."
@onready var timer = $"../../Timer"
@onready var money_sound = $Money_Sound


func _ready():
	if GameData.fully_fed_reward == true:
		fully_fed_reward();
		GameData.fully_fed_reward = false;


func fully_fed_reward():
	timer.start(1);
	await timer.timeout;
	text = "+30";
	visible = true;
	var tween = get_tree().create_tween();
	tween.set_trans(Tween.TRANS_LINEAR);
	tween.tween_property(self, "position", Vector2(position.x, position.y - 150), 3.5);
	money_sound.play();
	main_hub.update_money(30);
	await tween.finished;
	visible = false;

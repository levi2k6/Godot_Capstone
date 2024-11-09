extends HBoxContainer
@onready var label = $Label


func _ready():
	_display_money()
	

func _display_money():
	var money = DataManager._get_money_database()[0].money
	label.text = str(money)
	

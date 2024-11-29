extends Button;

@onready var timer = $"../../Timer"
@onready var tile_sprite = $Tile_Sprite
@onready var tile_sound = $Tile_Sound

func animation():
	tile_sound.play();
	change_blue();
	timer.start(0.2);
	await timer.timeout;
	change_normal();

func change_red():
	tile_sound.play();
	tile_sprite.frame = 1;

func change_blue():
	tile_sound.play();
	tile_sprite.frame = 2;

func change_normal():
	tile_sprite.frame = 0;

func _on_button_down():
	get_parent().get_parent().click_tile(self, name);
	pass # Replace with function body.

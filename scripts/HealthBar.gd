extends Sprite2D

@onready var player: BombGuy = get_node("../BombGuy")

func _ready() -> void:
	position = Vector2(20, 20)
	player.get_hit.connect(update_health_bar)
	player.get_extra_live.connect(update_health_bar)

	update_health_bar()

func update_health_bar():
	$Heart1.visible = player.lives >= 1
	$Heart2.visible = player.lives >= 2
	$Heart3.visible = player.lives >= 3


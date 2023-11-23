extends Sprite2D

@onready var player: BombGuy = get_node("../BombGuy")
@onready var hearts: Array[Sprite2D] = [$Heart1, $Heart2, $Heart3]

func _ready() -> void:
	position = Vector2(20, 20)
	player.get_hit.connect(update_health_bar)
	player.get_extra_live.connect(update_health_bar)

	update_health_bar()

func update_health_bar():
	hearts[0].visible = player.lives >= 1
	hearts[1].visible = player.lives >= 2
	hearts[2].visible = player.lives >= 3


extends Sprite2D

@onready var player: BombGuy = get_node("../BombGuy")
@onready var hearts: Array[Sprite2D] = [$Heart1, $Heart2, $Heart3]

func _ready() -> void:
	player.get_hit.connect(_on_player_get_hit)
	update_heart()
	position = Vector2(20, 20)

func update_heart():
	hearts[0].visible = player.lives >= 1
	hearts[1].visible = player.lives >= 2
	hearts[2].visible = player.lives >= 3


func _on_player_get_hit():
	update_heart()

extends StaticBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var CannonBallScene: PackedScene = preload("res://scenes/objects/cannon_ball.tscn")

func _ready() -> void:
	animated_sprite.play("idle")


func _on_timer_timeout() -> void:
	animated_sprite.play("attack")
	var cannon_ball: CannonBall = CannonBallScene.instantiate()
	cannon_ball.position = position + Vector2(-15, 7) * scale
	cannon_ball.scale = scale
	get_tree().root.add_child(cannon_ball)

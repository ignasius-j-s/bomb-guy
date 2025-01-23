extends StaticBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var randomize_timer: bool = false

var CannonBallScene: PackedScene = preload("res://scenes/objects/cannon_ball.tscn")

func _ready() -> void:
	$Timer.wait_time = randf_range(0.5, 4.0)
	animated_sprite.play("idle")


func _on_timer_timeout() -> void:
	if randomize_timer:
		$Timer.wait_time = randf_range(0.5, 4.0)
	else:
		$Timer.wait_time = 4.0
		
	animated_sprite.play("attack")
	var cannon_ball: CannonBall = CannonBallScene.instantiate()
	cannon_ball.rotation = rotation
	cannon_ball.position = position + Vector2(-1, 1) * scale
	cannon_ball.scale = scale
	get_tree().root.add_child(cannon_ball)

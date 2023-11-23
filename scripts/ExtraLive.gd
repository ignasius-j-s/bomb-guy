extends AnimatedSprite2D

func _ready() -> void:
	play("idle")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.lives < 3:
		play("collected")
		body.get_extra_live.emit()
		await animation_finished
		queue_free()

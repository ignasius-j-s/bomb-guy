extends AnimatedSprite2D

func _ready() -> void:
	play("idle")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.lives < 3:
		collected_tween()
		play("collected")
		body.get_extra_live.emit()
		await animation_finished
		queue_free()


func collected_tween():
	var tween = get_tree().create_tween().bind_node(self)
	tween.tween_property(self, "scale", Vector2(2, 2), 0.4)

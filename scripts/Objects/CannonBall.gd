class_name CannonBall
extends Node2D

var tween: Tween

func _ready() -> void:
	tween = get_tree().create_tween().bind_node(self).set_loops().set_parallel()
	tween.tween_property($Area2D, "position:x", -1600, 5.6).as_relative()
	tween.tween_property($Area2D, "rotation", -38, 5.6).as_relative()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is BombGuy:
		body.get_hit.emit()
	elif body is TileMapLayer:
		queue_free()
		tween.kill()

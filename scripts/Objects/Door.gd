class_name Door
extends Area2D

@onready var animated_sprite = $AnimatedSprite2D

func _ready() -> void:
	animated_sprite.play("closed")


func _on_body_entered(_body: Node2D) -> void:
	animated_sprite.play("opening")


func _on_body_exited(_body: Node2D) -> void:
	animated_sprite.play("closing")

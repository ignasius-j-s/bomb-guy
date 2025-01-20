class_name Door
extends Area2D

@onready var animated_sprite = $AnimatedSprite2D

func _ready() -> void:
	animated_sprite.play("closed")


func _on_body_entered(body: Node2D) -> void:
	animated_sprite.play("opening")
	$SFX.play()
	body.door_in()


func _on_body_exited(_body: Node2D) -> void:
	animated_sprite.play("closing")

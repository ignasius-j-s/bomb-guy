class_name Particles
extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	animated_sprite.play()
	floor_snap_length = 50
	collision_layer = 0
	collision_mask = 1


func _physics_process(_delta: float):
	if not is_on_floor():
		apply_floor_snap()


func _on_sprite_2d_animation_finished():
	queue_free()

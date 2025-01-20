extends Control

@onready var bomb_anim: AnimatedSprite2D = $Background/BombAnim
@onready var door_anim: AnimatedSprite2D = $Background/DoorAnim
var level_menu_scene: PackedScene = load("res://scenes/ui/level_menu.tscn")


func _goto_level_menu():
	get_tree().change_scene_to_packed(level_menu_scene)


func _on_quit_released() -> void:
	get_tree().quit(0)

extends Control

var main_menu_scene: PackedScene = load("res://scenes/ui/main_menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.hide()


func _on_game_over():
	get_tree().paused = true
	self.show()


func _on_retry_released():
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_menu_released() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_packed(main_menu_scene)

extends Control

var main_menu_scene: PackedScene = load("res://scenes/ui/main_menu.tscn")

func _ready():
	self.hide()

func _input(event: InputEvent):
	if event.is_action_pressed("pause") and not get_tree().paused:
		pause()


func pause():
	get_tree().paused = true
	self.show()

func _on_resume_released() -> void:
	get_tree().paused = false
	self.hide()


func _on_restart_released() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_menu_released() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_packed(main_menu_scene)


func _on_quit_released() -> void:
	get_tree().quit(0)

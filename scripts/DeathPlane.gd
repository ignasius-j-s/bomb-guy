extends Area2D


func _on_body_entered(player: BombGuy) -> void:
	player.game_over.emit()
	

extends Area2D
signal room()

func _on_body_entered(body):
	room.emit()

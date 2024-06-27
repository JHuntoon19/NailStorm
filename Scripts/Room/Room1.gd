extends Area2D
signal room1()


func _on_body_entered(body):
	room1.emit()

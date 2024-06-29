extends Area2D
signal respawn()
#Emits a signal to level to return dwarf to starting position
func _on_body_entered(_body):
	get_tree().paused = true
	respawn.emit()

extends CanvasLayer

signal playing()

func _on_play_pressed():
	playing.emit()



func _on_quit_pressed():
	get_tree().quit()

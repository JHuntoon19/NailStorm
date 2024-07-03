extends CanvasLayer


func _on_play_pressed():
	var tweenM = create_tween()
	tweenM.tween_property($Music, "volume_db", -50, 1)
	SceneTransition.changeScene("res://Scenes/Level/level2.tscn")



func _on_quit_pressed():
	get_tree().quit()

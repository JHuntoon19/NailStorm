extends "res://Scripts/level.gd"



func _on_checkpoint_activation():
	$Checkpoint2.unActivated()
	$Checkpoint3.unActivated()



func _on_checkpoint_2_activation():
	$Checkpoint.unActivated()
	$Checkpoint3.unActivated()
	



func _on_checkpoint_3_activation():
	$Checkpoint.unActivated()
	$Checkpoint2.unActivated()


func _on_level_load_body_entered(_body):
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE)
	CaveMusic.stop()
	SceneTransition.changeScene("res://Scenes/UI/end.tscn")

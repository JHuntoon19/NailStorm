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


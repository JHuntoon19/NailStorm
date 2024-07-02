extends "res://Scripts/level.gd"


#Will uncheck the checkpoint that is not used
func _on_checkpoint_activation():
	$Checkpoint2.unActivated()


func _on_checkpoint_2_activation():
	$Checkpoint.unActivated()

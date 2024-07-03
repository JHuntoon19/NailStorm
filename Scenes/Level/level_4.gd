extends "res://Scripts/level.gd"

func _ready():
	TrinityFieldsBegining.get_child(0).play("stop")
	CaveMusic.play()

func _on_checkpoint_activation():
	$Checkpoint2.unActivated()
	$Checkpoint3.unActivated()


func _on_checkpoint_2_activation():
	$Checkpoint.unActivated()
	$Checkpoint3.unActivated()


func _on_checkpoint_3_activation():
	$Checkpoint.unActivated()
	$Checkpoint2.unActivated()



func _on_level_load_body_entered(_dbody):
	SceneTransition.changeScene("res://Scenes/Level/level_5.tscn")

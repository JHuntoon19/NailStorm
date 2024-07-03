extends "res://Scripts/level.gd"

func _ready():
	for nail in get_tree().get_nodes_in_group("Nail"):
		nail.disLight()
	for cPoint in get_tree().get_nodes_in_group("Checkpoint"):
		cPoint.disLight()
	$Dwarf.disLight()
	$Hammer.disLight()
	$Hammer.deActive()
	#Starts the music for the level
	TrinityFieldsBegining.get_child(0).play("Play")
	#Hides the cursor
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN)
#Will uncheck the checkpoint that is not used
func _on_checkpoint_activation():
	$Checkpoint2.unActivated()

func _on_checkpoint_2_activation():
	$Checkpoint.unActivated()


func _on_level_load_body_entered(_body):
	print("load")
	$Dwarf.visible = false
	#changes scene to next level
	SceneTransition.changeScene("res://Scenes/Level/level_3.tscn")


func _on_cam_delay_timeout():
	print("Respawn")
	$RoomTransitionCamera.position = Globals.respawnCameraPos
	$RoomTransitionCamera.currentRoom = Globals.respawnCurrentRoom

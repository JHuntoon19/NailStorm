extends "res://Scripts/level.gd"

func _ready():
	$Hammer.disLight()
	$Hammer.deActive()
	#Hides the cursor
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN)


func _on_area_2d_hammer_time():
	$Hammer.activate()


func _on_checkpoint_activation():
	$Checkpoint2.unActivated()


func _on_checkpoint_2_activation():
	$Checkpoint.unActivated()


func _on_level_load_body_entered(_body):
	$Dwarf.visible = false
	SceneTransition.changeScene("res://Scenes/Level/level_4.tscn")

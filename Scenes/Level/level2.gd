extends "res://Scripts/level.gd"

func _ready():
	for nail in get_tree().get_nodes_in_group("Nail"):
		nail.disLight()
	for cPoint in get_tree().get_nodes_in_group("Checkpoint"):
		cPoint.disLight()
	$Dwarf.disLight()
	$Hammer.disLight()
#Will uncheck the checkpoint that is not used
func _on_checkpoint_activation():
	$Checkpoint2.unActivated()

func _on_checkpoint_2_activation():
	$Checkpoint.unActivated()

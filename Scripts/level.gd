extends Node2D

func _ready():
	#Hides the cursor
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN)
func _process(_delta):
	$UI/HealthBar.value = Globals.dwarfHealth
#Resets dwarf position to the starting point
func respawn():
	get_tree().call_deferred("reload_current_scene")

#Signal recieved from the death zone
func _on_death_zone_respawn():
	respawn()


func _on_dwarf_respawn():
	get_tree().call_deferred("reload_current_scene")

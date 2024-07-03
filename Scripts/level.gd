extends Node2D

func _ready():
	#Hides the cursor
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN)
#Press escape key to quit application, mainly used to quickly  exit and debug
func _process(_delta):
	if(Input.is_action_just_pressed("Quit")):
		get_tree().call_deferred("quit")
#Resets dwarf position to the starting point
func respawn():
	$Dwarf.death()
	$Dwarf.position = Globals.respawnPoint
	for nail in get_tree().get_nodes_in_group("Nail"):
		nail.reset()
	$RoomTransitionCamera.position = Globals.respawnCameraPos
	$RoomTransitionCamera.currentRoom = Globals.respawnCurrentRoom
	
	get_tree().paused = false
#Signal recieved from the death zone
func _on_death_zone_respawn():
	respawn()
#Plays the sound effect when the camera transfers rooms
func playWoosh():
	$Audio/Woosh.play()	
#Camera sends this signal to alert the level that the room changed
func _on_room_transition_camera_level_alert():
	playWoosh()

func _on_dwarf_respawn_dwarf():
	respawn()

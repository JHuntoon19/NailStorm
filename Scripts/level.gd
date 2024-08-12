extends Node2D
@onready var pause = $Pause
var paused : bool = true
func _ready():
	#Hides the cursor
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN)
#Press escape key to quit application, mainly used to quickly  exit and debug
func _process(_delta):
	if(Input.is_action_just_pressed("Quit")):
		pauseFunc()
		
func pauseFunc():	
	if(paused):
		DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE)
		pause.show()
		Engine.time_scale = 0
	else:
		DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN)
		pause.hide()
		Engine.time_scale = 1
	paused = !paused
#Resets dwarf position to the starting point
func respawn():
	#hides any wonky camera switches
	Cover.hideS($CamDelay.wait_time)
	$Dwarf.death()
	$Dwarf.position = Globals.respawnPoint
	for nail in get_tree().get_nodes_in_group("Nail"):
		nail.reset()
		#Starts the timer until the camera can zoom to the player
	$CamDelay.start()
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

#After a tiny delay under cover this puts the camera onto the dwarf
func _on_cam_delay_timeout():
	print("Respawn")
	$RoomTransitionCamera.position = Globals.respawnCameraPos
	$RoomTransitionCamera.currentRoom = Globals.respawnCurrentRoom

func _on_pause_playing():
	pauseFunc()

extends Node2D

func _ready():
	#Hides the cursor
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN)
func _process(_delta):
	if(Input.is_action_just_pressed("Quit")):
		get_tree().call_deferred("quit")
#Resets dwarf position to the starting point
func respawn():
	get_tree().call_deferred("reload_current_scene")

#Signal recieved from the death zone
func _on_death_zone_respawn():
	respawn()


func _on_dwarf_respawn():
	get_tree().call_deferred("reload_current_scene")
	

func _on_room_2_room():
	print("room2")
	$Camera2D.position = $CameraRooms/Room2.position
	playWoosh()

func _on_room_1_room():
	print("room1")
	$Camera2D.position = $CameraRooms/Room1.position
	playWoosh()

func playWoosh():
	$Audio/Woosh.play()

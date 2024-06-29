extends Camera2D
#Current room transition
var currentRoom : Vector2 = Vector2.ZERO
#Offset keeps the player on screen 32 is the minimum to give a one tile edge to each transition
var hOffset : int = 32
var vOffset : int = 32
#initialize variables to be set later
var hCamMovement : int = 0
var vCamMovement : int = 0
#Origin offset is the offset added to keep the camera in the same spot on startup
var originOffset : Vector2 = Vector2.ZERO
#Signal sent to the level
signal levelAlert()

func _ready():
	#gets origin offset from camera
	originOffset = position
	#The amount of pixels the camera moves each transition
	#The amount is the size of the screen minus the offset to keep the player on screen
	hCamMovement = int(get_viewport_rect().size.x - hOffset)
	vCamMovement = int(get_viewport_rect().size.y - vOffset)
	#Stores the default values for the globals to keep track of
	Globals.cameraPos = position
	Globals.respawnCameraPos = position
	Globals.cameraCurrentRoom = currentRoom
	Globals.respawnCurrentRoom = currentRoom
func updateCameraPos(direction : Vector2):
	print("update")
	currentRoom += direction
	#Moves the camera the correct amount and alerts the level
	position = currentRoom * Vector2(hCamMovement, vCamMovement) + originOffset
	levelAlert.emit()
	#Lets globals know where the camera is
	Globals.cameraPos = position
	Globals.cameraCurrentRoom = currentRoom
#All are triggered when the player touches the connected area
func top_entered(_body):
	print("Up")
	updateCameraPos(Vector2.UP)
func bottom_entered(_body):
	print("down")
	updateCameraPos(Vector2.DOWN)
func left_entered(_body):
	updateCameraPos(Vector2.LEFT)
func right_entered(_body):
	updateCameraPos(Vector2.RIGHT)

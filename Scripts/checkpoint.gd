extends Area2D
@onready var animation_player = $AnimationPlayer
var activated : bool = false
func _ready():
	animation_player.play("Idle")
func _on_body_entered(_body):
	if(not activated):
		animation_player.play("Activated")
		Globals.respawnPoint = position
		Globals.respawnCameraPos = Globals.cameraPos
		Globals.respawnCurrentRoom = Globals.cameraCurrentRoom
		print("activated" + str(Globals.respawnCameraPos))
		activated = true


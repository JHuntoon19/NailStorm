extends Area2D
@onready var animation_player = $AnimationPlayer
var activated : bool = false
signal activation()
func _ready():
	animation_player.play("Idle")
func _on_body_entered(_body):
	if(not activated):
		animation_player.play("Activated")
		Globals.respawnPoint = position
		Globals.respawnCameraPos = Globals.cameraPos
		Globals.respawnCurrentRoom = Globals.cameraCurrentRoom
		activated = true
		activation.emit()
func unActivated():
	activated = false
	animation_player.play("Idle")

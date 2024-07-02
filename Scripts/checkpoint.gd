extends Area2D
@onready var animation_player = $AnimationPlayer
var activated : bool = false
signal activation()
var light : bool = true
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


func _on_visible_on_screen_notifier_2d_screen_entered():
	$PointLight2D.enabled = true

func _on_visible_on_screen_notifier_2d_screen_exited():
	$PointLight2D.enabled = false
	
func disLight():
	light = false
func _process(_delta):
	if(not light):
		$PointLight2D.enabled = false

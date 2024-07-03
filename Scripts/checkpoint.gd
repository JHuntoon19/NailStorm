extends Area2D
@onready var animation_player = $AnimationPlayer
var activated : bool = false
signal activation()
var light : bool = true
var downPos : float
var upPos : float
func _ready():
	animation_player.play("Idle")
	downPos = position.y - 3
	upPos = position.y + 3
	tweenUps()
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
func tweenUps():
	#Tweens that make the checkpoing float
	var tweenD = create_tween().set_loops(INF)
	tweenD.tween_property(self, "position", Vector2(position.x, upPos), 1).set_ease(Tween.EASE_IN)
	tweenD.tween_property(self, "position", Vector2(position.x, downPos), 1).set_ease(Tween.EASE_OUT)
	var tweenS = create_tween().set_loops(INF)
	tweenS.tween_property(self, "scale", Vector2(1,1), 1).set_ease(Tween.EASE_IN)
	tweenS.tween_property(self, "scale", Vector2(1.2,1.2), 1).set_ease(Tween.EASE_OUT)
	
	
func _process(_delta):

	if(not light):
		$PointLight2D.enabled = false

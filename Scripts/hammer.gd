extends Area2D
@onready var animation_player = $AnimationPlayer
var active : bool = true
func _process(_delta):
	#Sets the hammer position to match the mouse
	position = get_global_mouse_position()
	#On a click this starts the animation
	if(Input.is_action_just_pressed("Swing") and active):
		animation_player.play("Attack")
#Turns on and off the collision box of the hammer
func startCol():
	monitoring = true
func endCol():
	monitoring = false
#Only collides with a nail so when it enters the nail it hits it
func _on_body_entered(body):
	body.hit()
func disLight():
	$PointLight2D.enabled = false
func deActive():
	active = false
func activate():
	$PointLight2D.enabled = true
	active = true
	visible = true

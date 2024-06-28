extends Area2D
@onready var animation_player = $AnimationPlayer

func _process(_delta):
	#Sets the hammer position to match the mouse
	position = get_global_mouse_position()
	#On a click this starts the animation
	if(Input.is_action_just_pressed("Swing")):
		animation_player.play("Attack")
#Turns on and off the collision box of the hammer
func startCol():
	monitoring = true
func endCol():
	monitoring = false
#Only collides with a nail so when it enters the nail it hits it
func _on_body_entered(body):
	body.hit()

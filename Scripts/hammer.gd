extends Area2D
@onready var animation_player = $AnimationPlayer
func _process(_delta):
	position = get_global_mouse_position()
	if(Input.is_action_just_pressed("Swing")):
		animation_player.play("Attack")

func startCol():
	monitoring = true
func endCol():
	monitoring = false


func _on_body_entered(body):
	body.hit()

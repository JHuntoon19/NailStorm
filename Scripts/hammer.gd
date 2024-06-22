extends Area2D
@onready var animation_player = $AnimationPlayer
func _process(_delta):
	global_position = get_global_mouse_position()
	if(Input.is_action_just_pressed("Swing")):
		animation_player.play("Attack")

func _on_area_entered(area):
	area.hit()

func startCol():
	monitoring = true
func endCol():
	monitoring = false

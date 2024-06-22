extends Area2D
@onready var animation_player = $AnimationPlayer

func _process(delta):
	global_position = get_global_mouse_position()
	if(Input.is_action_just_pressed("Swing")):
		animation_player.play("Attack")

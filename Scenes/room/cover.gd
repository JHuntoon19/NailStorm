extends CanvasLayer
@onready var delay = $Delay
@onready var animation_player = $AnimationPlayer

func hideS(time : float):
	animation_player.play("HIDE")
	delay.wait_time = time
	delay.start()
	
func _on_delay_timeout():
	animation_player.play_backwards("Fade")

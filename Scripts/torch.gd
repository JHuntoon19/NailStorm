extends AnimatedSprite2D

func _ready():
	$StartTimer.wait_time = randf_range(0, 3)
	$StartTimer.start()
func _on_visible_on_screen_notifier_2d_screen_entered():
	$PointLight2D.enabled = true


func _on_visible_on_screen_notifier_2d_screen_exited():
	$PointLight2D.enabled = false


func _on_start_timer_timeout():
	$AnimationPlayer.play("Flicker")

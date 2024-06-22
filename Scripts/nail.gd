extends Area2D

func hit():
	$AudioStreamPlayer2D.play()
	$AnimationPlayer.play("Dead")

extends Area2D
signal hammerTime()
func _ready():
	$AnimationPlayer.play("Idle")

func _on_body_entered(_body):
	$AnimationPlayer.play("Activated")
	await $AnimationPlayer.animation_finished
	hammerTime.emit()

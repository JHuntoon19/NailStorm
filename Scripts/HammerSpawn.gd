extends Area2D
func _ready():
	$AnimationPlayer.play("Idle")

func _on_body_entered(body):
	$AnimationPlayer.play("Activated")

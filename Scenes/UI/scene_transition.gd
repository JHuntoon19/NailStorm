extends CanvasLayer

func changeScene(target : String):
	layer += 1
	$AnimationPlayer.play("FadeToBlack")
	await $AnimationPlayer.animation_finished
	get_tree().call_deferred("change_scene_to_file", target)
	$AnimationPlayer.play_backwards("FadeToBlack")
	layer -= 1

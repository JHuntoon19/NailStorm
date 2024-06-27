extends CharacterBody2D
var near : bool = false
var direction : Vector2 = Vector2(0,0)
var speed : int = 75
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var dead : bool = false
var jumping : bool = false
var jumpHeight : int = -175
func ready():
	$AnimationPlayer.play("Idle")
func _process(delta):
	#Add gravity
	if(not is_on_floor()):
		velocity.y += gravity * delta
	if(near):
		direction = (Globals.dwarfPos - position).normalized()
		velocity.x = direction.x * speed
		if(not jumping and not dead):
			print("Jump")
			jumping = true
			velocity.y = jumpHeight
			$JumpTimer.start()
		else:
			move_toward(velocity.y, 0, gravity)
	else:
		move_toward(velocity.x,0,speed)
	if(dead):
		velocity.x = 0
	move_and_slide()
	
func hit():
	$AudioStreamPlayer2D.play()
	$AnimationPlayer.play("Dead")


func _on_chase_area_body_entered(_body):
	near = true


func _on_chase_area_body_exited(_body):
	near = false

func deadFunc():
	dead = true
	$DwarfHitArea.monitoring = false
func _on_dwarf_hit_area_body_entered(body):
	print("hit")
	body.hit()


func _on_jump_timer_timeout():
	jumping = false

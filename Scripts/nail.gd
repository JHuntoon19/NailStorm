extends CharacterBody2D
#Booleans to store different states
var near : bool = false
var dead : bool = false
var jumping : bool = false
var hitting : bool = false
#Direction to move
var direction : Vector2 = Vector2(0,0)
#Speed of movement 
var speed : int = 75
#Gravity will match the project gravity
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#Height of jump
var jumpHeight : int = -180

func ready():
	#Resets its state and hitboxes
	$AnimationPlayer.play("Idle")
func _process(delta):
	#Add gravity
	if(not is_on_floor()):
		velocity.y += gravity * delta
	#Will start to chase player
	if(near):
		#Gets the direction to the dwarf
		direction = (Globals.dwarfPos - position).normalized()
		#Only moves torward the player on the x axis
		velocity.x = direction.x * speed
		#Checks that it is time for a jump, not dead, and not currently touching the player
		if(not jumping and not dead and not hitting):
			jumping = true
			#Jumps vertically and starts the timer to know when to begin a new jump
			velocity.y = jumpHeight
			$JumpTimer.start()
		else:
			#Returns the nail to the ground
			move_toward(velocity.y, 0, gravity)
	#Stops the nail from moving
	else:
		move_toward(velocity.x,0,speed)
		#stops the nail from moving once dead
	if(dead):
		velocity.x = 0
	move_and_slide()
	
func hit():
	#Plays the hit sound effect and plays the dead animation
	$AudioStreamPlayer2D.play()
	$AnimationPlayer.play("Dead")
	#Alerts nail when to follow the dwarf
func _on_chase_area_body_entered(_body):
	near = true
func _on_chase_area_body_exited(_body):
	near = false
#Once dead it disables the dwarf hit area
func deadFunc():
	dead = true
	$DwarfHitArea.monitoring = false
	#Alerts nail to know when the dwarf is touching it
func _on_dwarf_hit_area_body_entered(_body):
	hitting = true
func _on_dwarf_hit_area_body_exited(_body):
	hitting = false
#Tells the nail to jump again
func _on_jump_timer_timeout():
	jumping = false

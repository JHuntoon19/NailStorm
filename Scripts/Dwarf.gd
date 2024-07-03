extends CharacterBody2D
#speed it moves normally 100
var speed : int = 100
#stores which way to walk
var direction : float = 0
#State to know when to play animation
var walking : bool = false
#Normal jump velocity
var jumpVel : int = -220
#bool for jumping
var jumping : bool = false
#Jump velocity off of a nail
var springVel : int = -440
@onready var animation_player = $AnimationPlayer
@onready var sprite = $Sheet
#Gravity setting from project settings so everything matches
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var jump = $Audio/Jump
@onready var big_jump = $Audio/BigJump
@onready var jump_thump = $Audio/JumpThump
#Jump particle effect
@onready var big_jump_parts = $Parts/BigJump
#Alerts dwarf if standing on a nail
var nailed : bool = false
#Signal sent to level to respawn the dwarf
signal respawnDwarf()
#Timer for coyote jump
@onready var coyote_timer = $CoyoteTimer
#Timer for jump buffer
@onready var jump_buffer = $JumpBuffer
#Used to smooth arc of jump
var prevVel := Vector2.ZERO

func _ready():
	Globals.respawnPoint = position
func _process(delta):
	#Add gravity
	if(not is_on_floor()):
		velocity.y += gravity * delta
	#Handle Jumps
	if(Input.is_action_just_pressed("Jump")):
		jumpFunc()
	#Check for jump buffer
	if(not jump_buffer.is_stopped()):
		jumpFunc()
	#Check if not jumping anymore
	if(velocity.y >= 0):
		jumping = false
	#Get direction for movement
	direction = Input.get_axis("Left", "Right")
	#Changes the velocity depending on the direction
	if(direction):
		walking = true
		velocity.x = direction * speed
	else:
		walking = false
		velocity.x = move_toward(velocity.x, 0, speed)
	#Handles animation for walking
	if(is_on_floor()):
		#Plays idle if not moving
		if(not walking):
			animation_player.play("Idle")
		else:
			#Plays walk animation when moving on floor
			animation_player.play("Walk")
	else:
		#If in the air this plays jump animation
		animation_player.play("Jump")
		#smooth jumping arc
		#velocity.x = move_toward(prevVel.x, velocity.x, 0.3)
	#Flips character depending on movement
	if(direction > 0):
		sprite.flip_h = false
	elif (direction < 0):
		sprite.flip_h = true
	#Used for coyote time
	var wasOnFloor = is_on_floor()
	move_and_slide()
	#Store velocity
	prevVel = velocity
	#Checks that player is falling off a block
	if( not is_on_floor() and wasOnFloor and not jumping):
		coyote_timer.start()
	#Update dwarf position in globals variable
	Globals.dwarfPos = position
	#Allow player to respawn
	if(Input.is_action_just_pressed("Respawn")):
		respawn()

func jumpFunc():
	#if standing on nail this jumps higher and plays the correct sounds. then emits the jump particles
	if(nailed):
		velocity.y = springVel
		big_jump.play()
		jump_thump.play()
		big_jump_parts.emitting = true
		jumping = true
		#Normal jump with normal sound
	elif(is_on_floor() or not coyote_timer.is_stopped()):
		velocity.y = jumpVel
		jump.play()
		jumping = true
			#Stop coyote timer 
		coyote_timer.stop()
			#stop jump buffer timer
		jump_buffer.stop()
	else:
		if(jump_buffer.is_stopped()):
			jump_buffer.start()
#Alert dwarf when standing on a nail
func nail_body_entered(_body):
	nailed = true
func _on_nail_detection_body_exited(_body):
	nailed = false
func death():
	visible = true
	$Audio/death.play()
	$Parts/Respawn.emitting = true
func respawn():
	respawnDwarf.emit()
func disLight():
	$PointLight2D.enabled = false
func unCollide():
	$CollisionShape2D.disabled = true
func reCollide():
	$CollisionShape2D.disabled = false

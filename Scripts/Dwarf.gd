extends CharacterBody2D
#speed it moves
var speed : int = 100
#stores which way to walk
var direction : float = 0
#State to know when to play animation
var walking : bool = false
#Normal jump velocity
var jumpVel : int = -220
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
func _ready():
	Globals.respawnPoint = position
func _process(delta):
	#Add gravity
	if(not is_on_floor()):
		velocity.y += gravity * delta
	#Handle Jumps
	if(Input.is_action_just_pressed("Jump")):
		#if standing on nail this jumps higher and plays the correct sounds. then emits the jump particles
		if(nailed):
			velocity.y = springVel
			big_jump.play()
			jump_thump.play()
			big_jump_parts.emitting = true
		#Normal jump with normal sound
		elif(is_on_floor()):
			velocity.y = jumpVel
			jump.play()
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
	#Flips character depending on movement
	if(direction > 0):
		sprite.flip_h = false
	elif (direction < 0):
		sprite.flip_h = true
	move_and_slide()
	#Update dwarf position in globals variable
	Globals.dwarfPos = position
#Alert dwarf when standing on a nail
func nail_body_entered(_body):
	nailed = true
func _on_nail_detection_body_exited(_body):
	nailed = false
func death():
	$Audio/death.play()
	$Parts/Respawn.emitting = true

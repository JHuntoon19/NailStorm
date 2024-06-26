extends CharacterBody2D
var speed : int = 100
var direction : float = 0
var walking : bool = false
var jumpVel : int = -300
@onready var animation_player = $AnimationPlayer
@onready var sprite = $Sprite2D
signal respawn()
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var health : int = 100
func _process(delta):
	#Add gravity
	if(not is_on_floor()):
		velocity.y += gravity * delta
	#Handle Jumps
	if(Input.is_action_just_pressed("Jump") and is_on_floor()):
		velocity.y = jumpVel
		$AudioStreamPlayer2D2.play()
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
		if(direction == 0):
			animation_player.play("Idle")
		else:
			animation_player.play("Walk")
	else:
		animation_player.play("Jump")
	#Flips character depending on movement
	if(direction > 0):
		sprite.flip_h = false
	elif (direction < 0):
		sprite.flip_h = true
	move_and_slide()
	#Update dwarf position in globals variable
	Globals.dwarfPos = position
	#Update health in globals
	Globals.dwarfHealth = health

func hit():
	health -= 10
	if(health <= 0):
		respawn.emit()

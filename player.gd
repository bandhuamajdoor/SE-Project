extends CharacterBody2D

@export var player_index: int = 1   # Player number (1,2,3,4)
@export var speed: float = 200.0
@export var jump_force: float = -400.0
@export var gravity: float = 800.0

@onready var anim = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	var velocity = self.velocity
	
	# gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# figure out which inputs to use
	var left  = "p%d_left" % player_index
	var right = "p%d_right" % player_index
	var jump  = "p%d_jump" % player_index
	
	# movement
	var dir = 0
	if Input.is_action_pressed(left):
		dir -= 1
	if Input.is_action_pressed(right):
		dir += 1
	velocity.x = dir * speed
	
	if is_on_floor() and Input.is_action_just_pressed(jump):
		velocity.y = jump_force
	
	# animations
	if not is_on_floor():
		anim.play("jump")
	elif dir != 0:
		anim.play("run")
		anim.flip_h = dir < 0
	else:
		anim.play("idle")
	
	self.velocity = velocity
	move_and_slide()

extends Moving

@onready var gravity: float= GRAVITY
var release: bool = false

func handle_input(subaru: Subaru, _event: InputEvent) -> void: 

	if _event.is_action_pressed("LEFT"):
		prior_x = LEFT
	if _event.is_action_pressed("RIGHT"):
		prior_x = RIGHT

	#START FALL
	if _event.is_action_released("C") and not release:
		if subaru.velocity.y < 0:
			subaru.velocity.y = 0
		release = true

	#DASH
	if subaru.can_dash and _event.is_action_pressed("X"):
		if subaru.dash_direction == Vector2.ZERO:
			subaru.dash_direction.x = subaru.face_direction.x
		subaru.transition_to("Dashing",{direction = subaru.dash_direction.normalized()})
		subaru.can_dash = false


func physics_update( subaru: Subaru, _delta: float) -> void:
	#MOVING IN ARI
	subaru.velocity.y += gravity*_delta
	if subaru.velocity.y > FALL_SPEED:
		subaru.velocity.y = FALL_SPEED
	subaru.velocity.x = 0
	subaru.dash_direction = Vector2.ZERO
	if prior_x == LEFT:
		if Input.is_action_pressed("LEFT"):
			subaru.velocity.x = -SPEED
			subaru.dash_direction.x = -1
		elif Input.is_action_pressed("RIGHT"):
			subaru.velocity.x = SPEED
			subaru.dash_direction.x = 1
	if prior_x == RIGHT:
		if Input.is_action_pressed("RIGHT"):
			subaru.velocity.x = SPEED
			subaru.dash_direction.x = 1
		elif Input.is_action_pressed("LEFT"):
			subaru.velocity.x = -SPEED
			subaru.dash_direction.x = -1
	if Input.is_action_pressed("UP"):
		subaru.dash_direction.y = -1
	if Input.is_action_pressed("DOWN"):
		subaru.dash_direction.y = 1
		subaru.velocity.y = FALL_SPEED*1.5
	subaru.move_and_slide()

	#STANDING
	if subaru.is_on_floor():
		subaru.transition_to("Standing")

	if subaru.cur_stama <= 0:
		return

	#ClIMBING
	if Input.is_action_pressed("Z") and (subaru.rightCast.is_colliding()):
		subaru.transition_to("Climbing",{right = true})
	if Input.is_action_pressed("Z") and (subaru.leftCast.is_colliding()):
		subaru.transition_to("Climbing",{left = true})


func enter(subaru: Subaru, _msg:= {}) -> void:
	if _msg.has("do_jump"):
		release = false
		subaru.velocity.y = JUMP_SPEED

	if _msg.has("prior_prev"):
		prior_x = _msg.get("prior_prev")

	if _msg.has("jump_on_wall"):
		release = false
		if _msg.get("lastWall") == LEFT:
			subaru.velocity = Vector2(SPEED,JUMP_SPEED)
		elif _msg.get("lastWall") == RIGHT:
			subaru.velocity = Vector2(-SPEED,JUMP_SPEED)

	subaru.updating= true

	if _msg.has("dash"):
		subaru.velocity.y = 0
		gravity = 0
		await get_tree().create_timer(0.1).timeout

	gravity = GRAVITY


func exit(subaru: Subaru) -> void:
	subaru.updating= false

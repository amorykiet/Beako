extends Moving

@onready var timer_to_fall: Timer = Timer.new()
@onready var falling: bool = false

func _ready():
	timer_to_fall.wait_time = 0.1
	timer_to_fall.one_shot = true
	add_child(timer_to_fall)

func handle_input(subaru: Subaru, _event: InputEvent) -> void:
	if _event.is_action_pressed("LEFT"):
		prior_x = LEFT
	if _event.is_action_pressed("RIGHT"):
		prior_x = RIGHT
	
	#AIRING
	if _event.is_action_pressed("C"):
		subaru.transition_to("Airing",{do_jump = true, prior_prev = prior_x})
	
	#DASHING
	if subaru.can_dash and _event.is_action_pressed("X"):
		if subaru.dash_direction == Vector2.ZERO:
			subaru.dash_direction.x = subaru.face_direction.x
		subaru.transition_to("Dashing",{direction = subaru.dash_direction.normalized()})
		subaru.can_dash = false


func physics_update( subaru: Subaru, _delta: float) -> void:

	#MOVING ON GROUND
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
	if Input.is_action_pressed("UP"):
		subaru.dash_direction.y = -1
	if Input.is_action_pressed("DOWN"):
		subaru.dash_direction.y = 1
	
	#DELAY TO FALL
	if not subaru.is_on_floor() and not falling:
		falling = true
		timer_to_fall.start()
	if falling:
		subaru.velocity.y += GRAVITY*_delta
		if timer_to_fall.is_stopped():
			subaru.transition_to("Airing")
	subaru.move_and_slide()
	if subaru.get_last_slide_collision() and subaru.get_last_slide_collision().get_collider().name == "DeadArea":
		subaru.transition_to("Dead")

	#CLIMBING
	if Input.is_action_pressed("Z") and (subaru.rightCast.is_colliding()):
		subaru.transition_to("Climbing",{right = true})
	if Input.is_action_pressed("Z") and (subaru.leftCast.is_colliding()):
		subaru.transition_to("Climbing",{left = true})

func enter( subaru: Subaru, _msg := {}) -> void:
	subaru.velocity.y = 0
	if subaru.get_last_slide_collision():
		if subaru.get_last_slide_collision().get_collider().name == "Enviroment":
			GamePlayProgress.fruits_collecting = 0
		if subaru.get_last_slide_collision().get_collider().name == "FruitCollectArea":
#			print(subaru.get_last_slide_collision().get_collider().position)
#			print(subaru.position)
			GamePlayProgress.fruits_collected += GamePlayProgress.fruits_collecting
			GamePlayProgress.checkpoint = subaru.get_last_slide_collision().get_collider().position + Vector2(0,-12)
			GamePlayProgress.fruits_collecting = 0
	timer_to_fall.stop()
	falling = false
	subaru.cur_stama = subaru.MAX_STAMA
	subaru.can_dash = true
	subaru.velocity.y = 0
	subaru.updating= true

func exit(subaru: Subaru) -> void:
	subaru.updating = false

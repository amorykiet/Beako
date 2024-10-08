extends Moving
var wallOn := -1
var jumped := false
var direction_jump: Vector2 = Vector2.ZERO
@onready var timer_to_jump: Timer = Timer.new()
#@onready var timer_to_jump_on_top: Timer = Timer.new()
#var jumping_on_top: bool = false

func _ready():
	timer_to_jump.wait_time = 0.1
	timer_to_jump.one_shot = true
	add_child(timer_to_jump)
#	timer_to_jump_on_top.wait_time = 0.1
#	timer_to_jump_on_top.one_shot = true
#	add_child(timer_to_jump_on_top)



func handle_input(subaru: Subaru, _event: InputEvent) -> void:
	if _event.is_action_pressed("UP"):
		prior_y = UP
	if _event.is_action_pressed("DOWN"):
		prior_y = DOWN
	
	#AIRING
	if _event.is_action_released("Z"):
		subaru.transition_to("Airing")
	if _event.is_action_pressed("C"):
#		await get_tree().create_timer(0.02).timeout
		subaru.cur_stama -= ENERGY_REDUCION_JUMP_ON_WALL
		if subaru.cur_stama < 0:
			subaru.cur_stama = 0
		jumped = true
		if (direction_jump == Vector2.UP) or (((wallOn == LEFT and direction_jump.x == -1) or (wallOn == RIGHT and direction_jump.x == 1)) and direction_jump.y == -1):
			subaru.velocity = Vector2.UP * JUMP_ON_WALL_SPEED
			timer_to_jump.start()

		else:
			Input.action_release("Z")
			subaru.transition_to("Airing",{jump_on_wall = true, lastWall = wallOn})


func physics_update( subaru: Subaru, _delta: float) -> void:
	if timer_to_jump.is_stopped() and jumped:
		jumped = false
		subaru.velocity = Vector2.ZERO
	
	#STAMA
	subaru.cur_stama -= ENERGY_REDUCION_CLIMB_SPEED*_delta
	if subaru.cur_stama < 0:
		subaru.cur_stama = 0
#		Input.action_release("Z")
		subaru.transition_to("Airing")
	
	#MOVING IN WALL
	if not jumped:
		direction_jump = Vector2.ZERO
		subaru.velocity.y = 0
		subaru.dash_direction = Vector2.ZERO
		if prior_y == UP:
			if Input.is_action_pressed("UP"):
				subaru.velocity.y = -CLIMB_SPEED
				subaru.dash_direction.y = -1
				direction_jump.y = -1
			elif Input.is_action_pressed("DOWN"):
				subaru.velocity.y = CLIMB_SPEED
				subaru.dash_direction.y = 1
				direction_jump.y = 1
		if prior_y == DOWN:
			if Input.is_action_pressed("DOWN"):
				subaru.velocity.y = CLIMB_SPEED
				subaru.dash_direction.y = 1
				direction_jump.y = 1
			elif Input.is_action_pressed("UP"):
				subaru.velocity.y = -CLIMB_SPEED
				subaru.dash_direction.y = -1
				direction_jump.y = -1
		if Input.is_action_pressed("RIGHT"):
			direction_jump.x = 1
		elif Input.is_action_pressed("LEFT"):
			direction_jump.x = -1
	subaru.move_and_slide()
	
	#CLIMB ON TOP
	if (wallOn == RIGHT) and not subaru.rightCast.is_colliding() and not subaru.rightCast2.is_colliding():
		subaru.velocity = Vector2(1,0)*80
		await get_tree().create_timer(0.1).timeout
		subaru.transition_to("Airing")
	if (wallOn == LEFT) and not subaru.leftCast.is_colliding() and not subaru.leftCast2.is_colliding():
		subaru.velocity = Vector2(-1,0)*80
		await get_tree().create_timer(0.1).timeout
		subaru.transition_to("Airing")

func enter( subaru: Subaru, _msg := {}) -> void:
	jumped = false
	subaru.velocity.y = 0
	if _msg.has("right"):
		prior_x = RIGHT
		wallOn = RIGHT
	elif _msg.has("left"):
		prior_x = LEFT
		wallOn = LEFT
	subaru.updating = true

func exit(subaru: Subaru) -> void:
	subaru.updating = false

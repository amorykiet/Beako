extends State
@onready var timer_to_respawn: Timer = Timer.new()

func _ready():
	timer_to_respawn.wait_time = 1
	timer_to_respawn.one_shot = true
	add_child(timer_to_respawn)

func handle_input(subaru: Subaru, _event: InputEvent) -> void:
	pass

func update(subaru: Subaru, _delta: float) -> void:
	pass

func physics_update( subaru: Subaru, _delta: float) -> void:
	subaru.velocity = Vector2.ZERO
	if timer_to_respawn.is_stopped():
		subaru.position = GamePlayProgress.checkpoint
		subaru.disable_collision(false)
		subaru.show()
		subaru.transition_to("Airing")
		await get_tree().create_timer(0.01).timeout
		GamePlayProgress.current_level.reload()

func enter( subaru: Subaru, _msg := {}) -> void:
	GamePlayProgress.deaths += 1
	if timer_to_respawn.is_stopped():
		timer_to_respawn.start()
	subaru.velocity = Vector2.ZERO
	subaru.disable_collision(true)
	GamePlayProgress.fruits_collecting = 0
	subaru.cur_stama = 0
	subaru.hide()
	subaru.updating = true

func exit(subaru: Subaru) -> void:
	subaru.updating = false

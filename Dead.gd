extends State

func handle_input(subaru: Subaru, _event: InputEvent) -> void:
	pass

func update(subaru: Subaru, _delta: float) -> void:
	pass

func physics_update( subaru: Subaru, _delta: float) -> void:
	subaru.velocity = Vector2.ZERO

func enter( subaru: Subaru, _msg := {}) -> void:
	subaru.velocity = Vector2.ZERO
	GamePlayProgress.fruits_collecting = 0
	subaru.cur_stama = 0
	subaru.hide()
	subaru.updating = true
func exit(subaru: Subaru) -> void:
	subaru.updating = false

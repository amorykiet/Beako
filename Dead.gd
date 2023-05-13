extends State

func handle_input(subaru: Subaru, _event: InputEvent) -> void:
	pass

func update(subaru: Subaru, _delta: float) -> void:
	pass

func physics_update( subaru: Subaru, _delta: float) -> void:
	subaru.velocity = Vector2.ZERO

func enter( subaru: Subaru, _msg := {}) -> void:
	print("dead")
	GamePlayProgress.fruits_collecting = 0
	subaru.hide()

func exit(subaru: Subaru) -> void:
	pass

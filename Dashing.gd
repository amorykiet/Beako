extends State
var direction: Vector2 = Vector2.ZERO
var dashing:= true

func handle_input(subaru: Subaru, _event: InputEvent) -> void:
	pass

func update(subaru: Subaru, _delta: float) -> void:
	pass

func physics_update( subaru: Subaru, _delta: float) -> void:
	subaru.move_and_collide(subaru.velocity*_delta)
	
func enter( subaru: Subaru, _msg := {}) -> void:
	subaru.velocity = _msg.get("direction")*500
	subaru.updating= true
	await get_tree().create_timer(0.08).timeout
	subaru.velocity = Vector2.ZERO
	await get_tree().create_timer(0.05).timeout
	subaru.transition_to("Airing",{dash = true})

func exit(subaru: Subaru) -> void:
	subaru.updating= false


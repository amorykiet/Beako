extends State
var direction: Vector2 = Vector2.ZERO
var dashing:= true
@onready var timer_to_dash: Timer = Timer.new()
@onready var timer_to_end_dash: Timer = Timer.new()
@onready var ending_dash: bool = false

func _ready():
	timer_to_dash.wait_time = 0.08
	timer_to_dash.one_shot = true
	timer_to_end_dash.wait_time = 0.05
	timer_to_end_dash.one_shot = true
	add_child(timer_to_dash)
	add_child(timer_to_end_dash)

func handle_input(subaru: Subaru, _event: InputEvent) -> void:
	pass

func update(subaru: Subaru, _delta: float) -> void:
	pass

func physics_update( subaru: Subaru, _delta: float) -> void:
	subaru.move_and_collide(subaru.velocity*_delta)
	if timer_to_dash.is_stopped() and not ending_dash:
		subaru.velocity = Vector2.ZERO
		timer_to_end_dash.start()
		ending_dash = true
	if ending_dash and timer_to_end_dash.is_stopped():
		subaru.transition_to("Airing",{dash = true})
		
func enter( subaru: Subaru, _msg := {}) -> void:
	ending_dash = false
	timer_to_dash.start()
	subaru.velocity = _msg.get("direction")*500
	subaru.updating= true

func exit(subaru: Subaru) -> void:
	subaru.updating= false


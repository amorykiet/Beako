class_name Subaru
extends CharacterBody2D

@export var initial_state := NodePath()
@onready var state: State = get_node(initial_state)
@onready var rightCast: RayCast2D = get_node("RightSide")
@onready var leftCast: RayCast2D = get_node("LeftSide")
@onready var rightCast2: RayCast2D = get_node("RightSide2")
@onready var leftCast2: RayCast2D = get_node("LeftSide2")
@onready var face_direction: Vector2 = Vector2.ZERO
const MAX_STAMA: int = 360

var updating: bool= false
var can_dash:= true
var dash_direction: Vector2= Vector2.RIGHT
var cur_stama: int = MAX_STAMA

func _ready():
	state.enter(self)

func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(self, event)

func _process(delta: float) -> void:
	if updating:
		state.update(self, delta)

func _physics_process(delta: float) -> void:
	if velocity.x > 0:
		face_direction.x = 1
	elif velocity.x < 0:
		face_direction.x = -1
	if updating:
		state.physics_update(self, delta)

func transition_to(target_state_name: String, msg: Dictionary = {}) -> void:
	if not has_node(target_state_name):
		return
	state.exit(self)
	state = get_node(target_state_name)
	state.enter(self, msg)

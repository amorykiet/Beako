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
	GamePlayProgress.state = state
	state.enter(self)

func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(self, event)

func _process(delta: float) -> void:
	if not can_dash and $Sprite2D.frame == 0:
		$Sprite2D.frame = 1
	elif  can_dash and $Sprite2D.frame == 1:
		$Sprite2D.frame = 0
	if GamePlayProgress.fruits_collecting == 0 and $Sprite2D2.visible:
		$Sprite2D2.hide()
	elif GamePlayProgress.fruits_collecting != 0 and not $Sprite2D2.visible:
		$Sprite2D2.show()
	if updating:
		state.update(self, delta)

func _physics_process(delta: float) -> void:
	GamePlayProgress.stama = cur_stama

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
	GamePlayProgress.state = state
	state.enter(self, msg)


func _on_dead_body_body_entered(body):
	if body.name == "DeadArea":
		transition_to("Dead")

func disable_collision(disable: bool):
	$CollisionShape2D.set_deferred("disabled", disable)

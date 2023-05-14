extends Node

var fruits_collected: int = 0
var fruits_collecting: int = 0
var state: State
var stama: int
var collision: String
var checkpoint: Vector2 = Vector2(30,150)
@onready var current_level: Node
var deaths: int = 0
var time_start: int = 0
var time_end: int = 0

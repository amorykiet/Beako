class_name Moving
extends State

const SPEED : int = 64
const CLIMB_SPEED : int = SPEED/2
const HIGH_DEFAULT: int = 50
const TIME_TO_HIGH: float = 0.365
const JUMP_SPEED: float = (-2*HIGH_DEFAULT)/(TIME_TO_HIGH)
const JUMP_ON_WALL_SPEED: float= 240
const FALL_SPEED: float = -JUMP_SPEED/1.5
const GRAVITY: float = (2*HIGH_DEFAULT)/(TIME_TO_HIGH**2)
const ENERGY_REDUCION_CLIMB_SPEED: int = 100
const ENERGY_REDUCION_JUMP_ON_WALL: int = 90

enum {RIGHT, LEFT}
var prior_x:= RIGHT
enum {UP, DOWN}
var prior_y := UP
var can_climb:= false

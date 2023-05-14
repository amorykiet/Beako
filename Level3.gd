extends Level

func _ready():
	fruits = 0

func reload():
	$Fruit.reload()
	GamePlayProgress.fruits_collected -= fruits
	fruits = 0

func _on_area_2d_body_entered(body):
	%Camera2D.limit_top = -180
	%Camera2D.limit_bottom = 0
	%Camera2D.limit_left = 328
	body.position = $Area2D.position
	GamePlayProgress.current_level = self


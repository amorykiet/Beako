extends Level

func _ready():
	fruits = 0

func reload():
	$Fruit.reload()
	GamePlayProgress.fruits_collected -= fruits
	fruits = 0

func _on_area_2d_body_entered(body):
	%Camera2D.limit_top = -364
	%Camera2D.limit_bottom = -184
	body.position = $Area2D.position
	GamePlayProgress.current_level = self

extends Level

func _ready():
	fruits = 0

func reload():
	$Fruit.reload()
	GamePlayProgress.fruits_collected -= fruits
	fruits = 0

func _on_area_2d_2_body_entered(body):
	GamePlayProgress.current_level = self

extends CanvasLayer

func switch(value: bool = true, time: float = 1):
	if value: 
		Animations.appear($ColorRect, time)
	else:
		Animations.disappear($ColorRect, time)
	await get_tree().create_timer(time).timeout

extends Sprite2D

var ball_scene = preload("res://src/ball.tscn")

signal generate_ball

var screen_size:Vector2

enum mode { WAIT, MOVE, SHOOT}
var current_mode = mode.WAIT

var wait_position:Vector2


func _ready():
	screen_size = get_viewport_rect().size


func _on_waiting_timer_timeout() -> void:
	# 移動先を決定する
	# 右か左か
	var direction = 1 if randf() > 0.5 else -1
	if position.x < 100:
		direction = 1
	elif position.x > screen_size.x - 100:
		direction = -1
	
	# 移動量を決定する
	var move_value =  randi_range(50, 200) * direction
	
	# 移動先を決定する
	var destination = Vector2(clamp(position.x + move_value, 30, screen_size.x - 30), position.y)
	
	# tweenで移動させる
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", destination, 1.5).set_trans(Tween.TRANS_BACK)
	
	generate_ball.emit()
	# FIXME
	# var ball_instance = ball_scene.instantiate()
	# get_tree().get_root().add_child(ball_instance)
	# ball_instance.position = Vector2(position.x, position.y - 40)

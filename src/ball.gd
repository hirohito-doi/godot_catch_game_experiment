extends RigidBody2D

func _ready():
	# オブジェクトを上方向に飛ばす速度を設定
	var x_direction = 1 if randf() < 0.5 else -1
	var initial_velocity = Vector2(75 * x_direction, -500)  # X方向は0、Y方向は負の値で上方向

	# 速度を設定
	linear_velocity = initial_velocity


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	if(position.y > 0):
		queue_free()

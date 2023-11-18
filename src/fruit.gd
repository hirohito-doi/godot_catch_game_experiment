extends RigidBody2D

signal get_fruit(point:int)

func _on_area_2d_area_entered(area: Area2D) -> void:
	get_fruit.emit(1000)
	queue_free()

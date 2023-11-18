extends Control

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()


func set_point(point:int) -> void:
	$Label.text = "+%d" % point

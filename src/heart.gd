extends Control

func _ready() -> void:
	activate()

func activate() -> void:
	$Active.visible = true
	$Inactive.visible = false
	
	
func inactivate() -> void:
	$Active.visible = false
	$Inactive.visible = true

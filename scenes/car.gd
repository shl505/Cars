extends CharacterBody2D

signal car_entered
func _on_area_2d_body_entered(_body):
	car_entered.emit()

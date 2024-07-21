extends HBoxContainer

@onready var texture_rect: TextureRect = $TextureRect


func _ready() -> void:
	texture_rect.modulate.a = 0.0


func _on_mouse_entered() -> void:
	texture_rect.modulate.a = 1.0


func _on_mouse_exited() -> void:
	texture_rect.modulate.a = 0.0

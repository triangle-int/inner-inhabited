extends MeshInstance3D
class_name ComputerScreen

var texture_updated := false

static var viewport: Viewport


func _process(_delta: float) -> void:
	if texture_updated:
		return
	
	if viewport == null:
		return
	
	var material: StandardMaterial3D = get_surface_override_material(0)
	material.albedo_texture = viewport.get_texture()
	texture_updated = true

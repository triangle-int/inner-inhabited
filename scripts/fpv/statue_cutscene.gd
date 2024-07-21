extends Node3D


func _ready() -> void:
	Dialogic.VAR.show_raft = true
	Dialogic.timeline_ended.connect(timeline_ended)


func timeline_ended() -> void:
	if Dialogic.VAR.show_raft:
		await $Statue.hide_and_remove()
		$Wall.position.y = -100.0
		$Raft.show_light()

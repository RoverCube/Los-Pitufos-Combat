extends PlayerState

var attack_index: int
# 0 - hp
# 1 - lp
# 2 - hk
# 3 - lp
# 4 - cp
# 5 - ck

func _on_start_state() -> void:
	pass 
	# try to get attack index here if not use generic changes

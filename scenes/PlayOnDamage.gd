extends AudioStreamPlayer3D

export(Array, AudioStreamSample) var samples := []

func on_repair():
	stop()

func on_damage():
	if samples:
		stream = samples[randi() % len(samples)]
	play()

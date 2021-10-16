extends AudioStreamPlayer3D

export(Array, AudioStreamSample) var samples := []

func on_repair():
	if samples:
		stream = samples[randi() % len(samples)]
	play()

func on_damage():
	stop()

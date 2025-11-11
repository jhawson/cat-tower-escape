extends Node

# Audio players for different channels
var music_player: AudioStreamPlayer
var sound_players: Array[AudioStreamPlayer] = []
const MAX_SOUND_PLAYERS = 8

# Audio streams (to be loaded)
var sounds = {}
var music = {}

func _ready():
	# Create music player
	music_player = AudioStreamPlayer.new()
	add_child(music_player)
	music_player.bus = "Music"

	# Create pool of sound effect players
	for i in range(MAX_SOUND_PLAYERS):
		var player = AudioStreamPlayer.new()
		add_child(player)
		player.bus = "SFX"
		sound_players.append(player)

	# Load audio resources
	_load_audio_resources()

func _load_audio_resources():
	# Load sound effects
	# sounds["jump"] = load("res://assets/sounds/jump.wav")  # Not yet added
	# sounds["fall"] = load("res://assets/sounds/fall.wav")  # Not yet added
	sounds["catnip"] = load("res://assets/sounds/catnip.wav")
	sounds["yarn_spawn"] = load("res://assets/sounds/yarn_spawn.wav")
	sounds["yarn_hit"] = load("res://assets/sounds/yarn_hit.wav")
	# sounds["yarn_bounce"] = load("res://assets/sounds/yarn_bounce.wav")  # Not needed (yarn passes through platforms)
	# sounds["hit"] = load("res://assets/sounds/hit.wav")  # Not yet added
	sounds["game_over"] = load("res://assets/sounds/game_over.wav")

	# Load music
	music["main_theme"] = load("res://assets/music/main_theme.mp3")
	music["victory_theme"] = load("res://assets/music/victory_theme.mp3")
	music["game_over_theme"] = load("res://assets/music/game_over.mp3")

func play_sound(sound_name: String):
	if not sounds.has(sound_name):
		return

	# Find available player
	for player in sound_players:
		if not player.playing:
			player.stream = sounds[sound_name]
			player.play()
			return

	# If all players busy, use first one
	sound_players[0].stream = sounds[sound_name]
	sound_players[0].play()

func play_music(music_name: String):
	if not music.has(music_name):
		return

	music_player.stream = music[music_name]
	music_player.play()

func stop_music():
	music_player.stop()

func set_music_volume(volume_db: float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), volume_db)

func set_sfx_volume(volume_db: float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), volume_db)

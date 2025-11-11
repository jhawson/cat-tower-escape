# Audio Setup Guide

The game has a complete audio management system ready to go. You just need to add the actual audio files!

## Quick Setup

### Step 1: Get Your Audio Files

You'll need these sound effects (as .wav or .ogg files):
- `jump.wav` - Short "boing" or "hop" sound
- `fall.wav` - Optional whooshing sound for falling
- `catnip.wav` - Magical/sparkly collection sound
- `yarn_spawn.wav` - Whoosh or "incoming" sound
- `yarn_hit.wav` - Explosion or impact sound (player hit)
- `yarn_bounce.wav` - Softer bounce sound (platform hit)
- `hit.wav` - Damage/defeat sound
- `game_over.wav` - Sad/dramatic game over sound

Music tracks (as .ogg files for looping):
- `main_theme.ogg` - Tense, suspenseful background music (2-3 min loop)
- `victory_theme.ogg` - Joyous, celebratory music (1-2 min)

### Step 2: Place Files in Correct Folders

```
assets/
├── sounds/
│   ├── jump.wav
│   ├── fall.wav
│   ├── catnip.wav
│   ├── yarn_spawn.wav
│   ├── yarn_hit.wav
│   ├── yarn_bounce.wav
│   ├── hit.wav
│   └── game_over.wav
└── music/
    ├── main_theme.ogg
    └── victory_theme.ogg
```

### Step 3: Enable Audio Loading

Open [scripts/audio_manager.gd](scripts/audio_manager.gd) and uncomment lines 24-36 in the `_load_audio_resources()` function:

```gdscript
func _load_audio_resources():
	# Remove these comment markers (#)
	sounds["jump"] = load("res://assets/sounds/jump.wav")
	sounds["fall"] = load("res://assets/sounds/fall.wav")
	sounds["catnip"] = load("res://assets/sounds/catnip.wav")
	sounds["yarn_spawn"] = load("res://assets/sounds/yarn_spawn.wav")
	sounds["yarn_hit"] = load("res://assets/sounds/yarn_hit.wav")
	sounds["yarn_bounce"] = load("res://assets/sounds/yarn_bounce.wav")
	sounds["hit"] = load("res://assets/sounds/hit.wav")
	sounds["game_over"] = load("res://assets/sounds/game_over.wav")

	music["main_theme"] = load("res://assets/music/main_theme.ogg")
	music["victory_theme"] = load("res://assets/music/victory_theme.ogg")
```

### Step 4: Test!

Run the game and you should hear:
- Jump sound when pressing Space/W
- Catnip sound when collecting green power-ups
- Yarn sounds when flaming yarn appears and hits things
- Background music during gameplay
- Victory music when reaching the top

## Where to Find Free Audio

### Sound Effects
- **SFXR / ChipTone**: Generate retro game sounds
  - [sfxr.me](http://sfxr.me)
  - [sfbgames.itch.io/chiptone](https://sfbgames.itch.io/chiptone)

- **Freesound.org**: Community library (requires attribution)
  - [freesound.org](https://freesound.org)

- **OpenGameArt**: Free game assets
  - [opengameart.org](https://opengameart.org)

### Music
- **Incompetech**: Royalty-free music by Kevin MacLeod
  - [incompetech.com](https://incompetech.com)

- **FreeSound**: Also has music loops
  - [freesound.org/browse/tags/music/](https://freesound.org/browse/tags/music/)

- **LMMS / Bosca Ceoil**: Make your own!
  - [lmms.io](https://lmms.io)
  - [boscaceoil.net](https://boscaceoil.net)

## Audio Guidelines

### Sound Effects
- **Format**: .wav for quality, .ogg for smaller size
- **Sample Rate**: 44100 Hz
- **Bit Depth**: 16-bit
- **Length**: Keep under 2 seconds (except game_over)

### Music
- **Format**: .ogg (better for looping)
- **Sample Rate**: 44100 Hz
- **Looping**: Ensure seamless loop points
- **Volume**: Normalize to -6dB to prevent clipping

### Recommended Vibe

**Main Theme** (tense/suspenseful):
- Minor key
- Moderate tempo (120-140 BPM)
- Driving rhythm
- Strings, synths, or orchestral elements
- Think: escape, climbing, danger

**Victory Theme** (joyous):
- Major key
- Upbeat tempo (140-160 BPM)
- Bright instrumentation
- Celebratory melody
- Think: triumph, happiness, freedom

## Troubleshooting

### "Audio file not found" error
- Check file paths match exactly (case-sensitive!)
- Ensure files are in correct folders
- Re-import project in Godot (Project > Reload Current Project)

### Audio not playing
- Check volume in Project > Project Settings > Audio
- Open Audio bus editor (bottom panel) and check levels
- Make sure AudioManager autoload is enabled in Project Settings

### Audio cutting out
- Increase `MAX_SOUND_PLAYERS` in audio_manager.gd if many sounds overlap
- Check for audio bus clipping in the Audio panel

## Advanced: Adjusting Audio Buses

The game uses two audio buses:
- **Music**: For background music (can be ducked or faded)
- **SFX**: For sound effects

To adjust in Godot:
1. Open the Audio panel (bottom of editor)
2. Adjust volume sliders for Music and SFX buses
3. Add effects like reverb, chorus, etc.

## That's It!

Once you add the audio files and uncomment the loading code, your game will have full sound. The audio system automatically handles:
- Multiple simultaneous sounds
- Music looping
- Volume control
- Preventing audio overlap glitches

Have fun making Cat Tower Escape sound amazing!

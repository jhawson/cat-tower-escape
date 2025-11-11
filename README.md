# Cat Tower Escape

A tense, suspenseful 2D platformer where Kitty must climb from the bottom of a mysterious tower to reach the garden at the top!

## Game Overview

**Cat Tower Escape** is an action-packed vertical platformer where you control Kitty, a brave cat determined to escape a dangerous tower. Navigate through 10 screen heights of treacherous platforms while dodging flaming balls of yarn that rain down from above. Collect catnip for temporary invincibility and make your way to the beautiful garden at the summit!

## Story

Trapped at the bottom of a mysterious tower, Kitty discovers that the only way out is up. Flaming yarn balls mysteriously drop from the darkness above, threatening her escape. But Kitty is brave and determined - with careful jumps and the occasional boost from magical catnip, she will reach the outdoor garden where her friends are waiting!

## Gameplay Features

### Core Mechanics
- **Platforming**: Jump from ledge to ledge to climb the tower
- **Vertical Scrolling**: The camera follows Kitty up and down as she climbs
- **Hazards**: Dodge flaming yarn balls that fall from above
- **Power-ups**: Collect catnip bundles for 30 seconds of invincibility
- **Victory**: Reach the garden at the top to win!

### Controls
- **A / Left Arrow**: Move left
- **D / Right Arrow**: Move right
- **W / Space / Up Arrow**: Jump

### Game Elements

#### The Player - Kitty
- Orange cat sprite (placeholder - can be replaced with custom art)
- Smooth platformer movement with jump mechanics
- Visual feedback when invincible (pulsing transparency)

#### Hazards - Flaming Yarn Balls
- Periodically spawn from the top of the screen
- Fall downward with physics
- Instantly defeat Kitty on contact (unless invincible)
- Create particle effects and sounds

#### Power-ups - Catnip
- Green bundles scattered throughout the tower (5 total)
- Grant 30 seconds of invincibility
- Make Kitty immune to flaming yarn
- Display remaining invincibility time on screen

#### The Tower
- 10 screen heights tall (7200 pixels)
- Contains 11 platforms to jump between
- Walls on both sides to keep Kitty contained
- Dark, moody atmosphere

#### Victory Garden
- Bright green area at the top of the tower
- Represents freedom and celebration
- Triggers victory screen when reached

### Audio Design
The game features a comprehensive audio system (placeholders - add your own audio files):

**Sound Effects Needed:**
- `jump.wav` - Kitty jumping
- `fall.wav` - Kitty falling
- `catnip.wav` - Collecting catnip
- `yarn_spawn.wav` - Yarn ball appearing
- `yarn_hit.wav` - Yarn ball hitting player
- `yarn_bounce.wav` - Yarn ball hitting platform
- `hit.wav` - Player taking damage
- `game_over.wav` - Game over sound

**Music Tracks Needed:**
- `main_theme.ogg` - Tense, suspenseful background music for climbing
- `victory_theme.ogg` - Joyous, celebratory music for winning

### UI Elements
- **Height Progress**: Shows percentage of tower climbed (0-100%)
- **Invincibility Timer**: Displays remaining seconds of invincibility
- **Game Over Screen**: Appears when hit by yarn (with Restart button)
- **Victory Screen**: Appears when reaching the garden (with Play Again button)

## Installation & Setup

### Prerequisites
- **Godot 4.2+** (Download from [godotengine.org](https://godotengine.org/))

### Running the Game

1. **Install Godot**: Download and install Godot 4.2 or later

2. **Open the Project**:
   ```bash
   cd cat-tower-escape
   godot project.godot
   ```
   Or use the Godot Project Manager to import this directory

3. **Run the Game**: Press F5 in the Godot editor or click the "Play" button

### Project Structure

```
cat-tower-escape/
├── project.godot           # Main project configuration
├── icon.svg               # Project icon
├── scenes/                # Scene files (.tscn)
│   ├── main.tscn         # Main game scene
│   ├── player.tscn       # Player character scene
│   ├── flaming_yarn.tscn # Hazard scene
│   ├── catnip.tscn       # Power-up scene
│   └── ui.tscn           # UI overlay scene
├── scripts/               # GDScript files (.gd)
│   ├── main.gd           # Main game logic
│   ├── player.gd         # Player controller
│   ├── flaming_yarn.gd   # Yarn ball behavior
│   ├── catnip.gd         # Catnip collectible
│   ├── yarn_spawner.gd   # Spawn system for yarn
│   ├── catnip_placer.gd  # Catnip placement
│   ├── ui.gd             # UI management
│   └── audio_manager.gd  # Audio system (autoload)
├── assets/                # Game assets
│   ├── sprites/          # Image files (add your art here!)
│   ├── sounds/           # Sound effects (.wav, .ogg)
│   └── music/            # Background music (.ogg)
└── resources/             # Godot resources
```

## Customization Guide

### Adding Custom Sprites

The game currently uses placeholder colored squares. To add custom sprites:

1. Create or find sprite images for:
   - Kitty (cat character)
   - Flaming yarn balls
   - Catnip bundles
   - Platform tiles
   - Tower walls
   - Garden background

2. Place images in `assets/sprites/`

3. In Godot editor:
   - Open the relevant scene (player.tscn, flaming_yarn.tscn, etc.)
   - Select the Sprite2D node
   - In the Inspector, set the Texture property to your image
   - Adjust the scale if needed

### Adding Sound Effects & Music

1. Create or obtain audio files in .wav or .ogg format

2. Place them in the appropriate folders:
   - Sound effects: `assets/sounds/`
   - Music: `assets/music/`

3. Open `scripts/audio_manager.gd`

4. Uncomment and update the file paths in `_load_audio_resources()`:
   ```gdscript
   sounds["jump"] = load("res://assets/sounds/jump.wav")
   sounds["catnip"] = load("res://assets/sounds/catnip.wav")
   # ... etc

   music["main_theme"] = load("res://assets/music/main_theme.ogg")
   music["victory_theme"] = load("res://assets/music/victory_theme.ogg")
   ```

### Adjusting Difficulty

Edit values in the scripts to tune difficulty:

**In `scripts/player.gd`:**
- `SPEED` - Horizontal movement speed (default: 300)
- `JUMP_VELOCITY` - Jump height (default: -500)

**In `scripts/yarn_spawner.gd`:**
- `spawn_interval_min` - Minimum time between yarn spawns (default: 1.5 seconds)
- `spawn_interval_max` - Maximum time between yarn spawns (default: 3.5 seconds)

**In `scripts/flaming_yarn.gd`:**
- `fall_speed` - How fast yarn falls (default: 400)

**In `scripts/catnip_placer.gd`:**
- `catnip_positions` - Array of Vector2 positions for catnip placement
- Add more positions to add more catnip bundles

**In `scripts/main.gd`:**
- `TOWER_HEIGHT` - Total height of tower (default: 7200)

### Adding More Platforms

To make climbing easier or harder:

1. Open `scenes/main.tscn` in Godot
2. Select the "Platforms" node
3. Duplicate an existing platform (Ctrl+D)
4. Move it to desired position
5. Platforms should be spaced for jumpable distances

## Game Design Notes

### Atmosphere
The game is designed to feel:
- **Tense**: Dark colors, suspenseful music, constant threat from above
- **Challenging**: Precise platforming required, limited invincibility
- **Rewarding**: Clear progress indicator, triumphant victory

### Color Scheme (Current Placeholders)
- Background: Dark blue-gray (#262633)
- Walls: Dark brown (#4D4033)
- Platforms: Medium brown (#66594D)
- Kitty: Orange (#FF9933)
- Yarn: Fiery orange-red (#FF4D00)
- Catnip: Bright green (#33FF4D)
- Garden: Lush green (#33CC4D)

### Balance Considerations
- Tower is 10 screens tall, which takes roughly 2-3 minutes to climb
- 5 catnip bundles provide 150 total seconds of invincibility
- Yarn spawns every 1.5-3.5 seconds, creating constant pressure
- Platforming requires precision but is forgiving with generous jump height

## Future Enhancement Ideas

- Add animations for Kitty (idle, run, jump, fall, death)
- Create particle effects for yarn explosions
- Add background parallax layers for depth
- Implement combo scoring system
- Add multiple difficulty levels
- Create different tower themes
- Add more power-up types
- Implement Steam achievements
- Add gamepad support (already works with Godot's default mapping!)

## Technical Details

- **Engine**: Godot 4.2+
- **Language**: GDScript
- **Resolution**: 1280x720 (scalable)
- **Physics**: 2D with custom gravity (980)
- **Collision Layers**:
  - Layer 1: Player
  - Layer 2: World (platforms, walls)
  - Layer 3: Hazards (yarn)
  - Layer 4: Collectibles (catnip)

## Credits

Game created with Godot Engine.

### Asset Placeholders
Current version uses procedurally generated placeholder graphics. Replace with:
- Custom cat sprites
- Animated yarn balls with fire effects
- Beautiful garden tileset
- Atmospheric tower backgrounds

### Audio Placeholders
AudioManager is configured but needs audio files. Recommended sources:
- **Music**: Create with tools like Bosca Ceoil, LMMS, or hire a composer
- **SFX**: Create with tools like SFXR, Audacity, or use royalty-free libraries

## License

This project template is provided as-is for educational and commercial use. Add your own license as needed.

## Development Notes

This game was created as a complete, playable prototype. The code is structured for easy modification and expansion. All core systems are functional:
- Player movement and collision
- Enemy spawning and behavior
- Power-up collection
- Win/lose conditions
- UI feedback
- Audio management (ready for audio files)

Feel free to use this as a base for your own projects!

---

**Have fun climbing, dodging, and escaping! Good luck, Kitty!**

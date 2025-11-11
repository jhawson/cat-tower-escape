# Cat Tower Escape - Complete File Index

Quick reference guide to every file in the project.

## 📋 Documentation Files

| File | Purpose | When to Read |
|------|---------|--------------|
| [README.md](README.md) | Complete game documentation | First! Comprehensive overview |
| [QUICKSTART.md](QUICKSTART.md) | Get running in 5 minutes | Want to play immediately |
| [AUDIO_SETUP.md](AUDIO_SETUP.md) | How to add sound & music | Ready to add audio files |
| [GAME_STRUCTURE.md](GAME_STRUCTURE.md) | Technical architecture | Understanding code organization |
| [PROJECT_SUMMARY.md](PROJECT_SUMMARY.md) | What was created | See what's included |
| [CUSTOMIZATION_CHECKLIST.md](CUSTOMIZATION_CHECKLIST.md) | Track your modifications | Planning customization |
| [FILE_INDEX.md](FILE_INDEX.md) | This file - directory guide | Finding specific files |

## 🎮 Core Game Files

### Configuration
| File | Purpose | Edit? |
|------|---------|-------|
| `project.godot` | Godot project settings | Rarely - use Project Settings UI |
| `icon.svg` | Project icon | Yes - replace with game logo |
| `.gitignore` | Git ignore rules | Only if using version control |

### Scenes (.tscn files)
| File | Contains | Modify for |
|------|----------|-----------|
| `scenes/main.tscn` | Main game scene, tower, platforms | Level layout, platform positions |
| `scenes/player.tscn` | Kitty player character | Player sprite, animations, size |
| `scenes/flaming_yarn.tscn` | Yarn ball hazard | Yarn sprite, particles, effects |
| `scenes/catnip.tscn` | Power-up collectible | Catnip sprite, animations |
| `scenes/ui.tscn` | User interface overlay | UI layout, styling, panels |

### Scripts (.gd files)
| File | Controls | Edit for |
|------|----------|----------|
| `scripts/main.gd` | Game loop, win/lose, camera | Game flow, victory conditions |
| `scripts/player.gd` | Player movement, jumping | Controls, speed, jump height |
| `scripts/flaming_yarn.gd` | Yarn physics, collision | Yarn behavior, fall speed |
| `scripts/catnip.gd` | Catnip collection | Collection effects, behavior |
| `scripts/catnip_placer.gd` | Spawns catnip in world | Catnip positions, count |
| `scripts/yarn_spawner.gd` | Spawns yarn from top | Spawn rate, difficulty |
| `scripts/ui.gd` | UI updates, menus | UI behavior, messages |
| `scripts/audio_manager.gd` | Audio system (autoload) | Sound file loading, volume |

## 📁 Asset Folders

### Sprites (Currently Empty)
```
assets/sprites/
├── (add kitty.png here)
├── (add yarn.png here)
├── (add catnip.png here)
├── (add platforms/ here)
└── (add backgrounds/ here)
```

### Sounds (Currently Empty)
```
assets/sounds/
├── (add jump.wav here)
├── (add catnip.wav here)
├── (add yarn_hit.wav here)
└── (add other SFX here)
```

### Music (Currently Empty)
```
assets/music/
├── (add main_theme.ogg here)
└── (add victory_theme.ogg here)
```

### Resources (Empty - for Godot resources)
```
resources/
└── (for custom resources, shaders, etc.)
```

## 🎯 Quick File Finder

### "I want to..."

**Change player speed/jump**
→ Edit `scripts/player.gd` (lines 4-5: SPEED, JUMP_VELOCITY)

**Adjust difficulty**
→ Edit `scripts/yarn_spawner.gd` (lines 4-5: spawn_interval_min/max)

**Add more platforms**
→ Open `scenes/main.tscn` in Godot, duplicate Platform nodes

**Move catnip locations**
→ Edit `scripts/catnip_placer.gd` (line 6: catnip_positions array)

**Change tower height**
→ Edit `scripts/main.gd` (line 9: TOWER_HEIGHT constant)

**Replace player sprite**
→ Open `scenes/player.tscn`, select Sprite2D, change Texture

**Add sound effects**
→ Place files in `assets/sounds/`, edit `scripts/audio_manager.gd` (line 24+)

**Change colors**
→ Open scenes in Godot, select Sprite2D nodes, change Modulate property

**Modify UI text**
→ Edit `scripts/ui.gd` or open `scenes/ui.tscn` to change labels

**Add new levels**
→ Duplicate `scenes/main.tscn`, modify platforms, update level loading

## 📊 File Statistics

```
Total Files: 26
├── Documentation:  7 .md files
├── Code:           8 .gd scripts  (~800 lines)
├── Scenes:         5 .tscn files
├── Config:         3 files (project.godot, icon.svg, .gitignore)
└── Asset Folders:  3 directories (empty, ready for content)
```

## 🔧 File Dependencies

### Main Scene Dependencies
```
main.tscn
├── Requires: main.gd
├── Instances: player.tscn
├── Instances: flaming_yarn.tscn (via yarn_spawner.gd)
├── Instances: catnip.tscn (via catnip_placer.gd)
├── Instances: ui.tscn
├── Uses: yarn_spawner.gd
└── Uses: catnip_placer.gd
```

### Player Dependencies
```
player.tscn
├── Script: player.gd
└── Calls: AudioManager (autoload)
```

### Yarn Dependencies
```
flaming_yarn.tscn
├── Script: flaming_yarn.gd
└── Calls: AudioManager (autoload)
```

### Catnip Dependencies
```
catnip.tscn
└── Script: catnip.gd
```

### UI Dependencies
```
ui.tscn
└── Script: ui.gd
```

### Autoloads (Global)
```
AudioManager
├── Defined in: scripts/audio_manager.gd
├── Loaded by: project.godot [autoload] section
└── Called by: All scripts that play audio
```

## 📝 Editing Priority

For beginners, edit in this order:

1. **Start Here** (Easy, Visual Changes)
   - `assets/sprites/` - Add your images
   - `scenes/*.tscn` - Replace placeholder sprites
   - Color changes in scene Modulate properties

2. **Next Steps** (Simple Code Changes)
   - `scripts/player.gd` - Adjust SPEED and JUMP_VELOCITY
   - `scripts/yarn_spawner.gd` - Adjust spawn_interval
   - `scripts/catnip_placer.gd` - Move catnip positions

3. **Advanced** (Game Logic)
   - `scripts/main.gd` - Change game flow
   - `scripts/ui.gd` - Modify UI behavior
   - `scripts/flaming_yarn.gd` - Change yarn behavior

4. **Expert** (System Changes)
   - `scripts/audio_manager.gd` - Modify audio system
   - `project.godot` - Change project settings
   - Create new scenes and scripts

## 🎨 Files by Function

### Player Experience
- `scripts/player.gd` - Controls
- `scripts/ui.gd` - Feedback
- `scripts/audio_manager.gd` - Sound

### Level Design
- `scenes/main.tscn` - Layout
- `scripts/catnip_placer.gd` - Collectibles
- `scripts/yarn_spawner.gd` - Hazards

### Game Rules
- `scripts/main.gd` - Win/lose
- `scripts/flaming_yarn.gd` - Damage
- `scripts/catnip.gd` - Power-up

### Visuals
- `scenes/*.tscn` - All visual elements
- `assets/sprites/` - Images (to be added)
- Sprite2D Modulate - Colors

### Audio
- `scripts/audio_manager.gd` - System
- `assets/sounds/` - SFX (to be added)
- `assets/music/` - Tracks (to be added)

## 🔍 Search Tips

**Find where a function is called:**
```bash
grep -r "function_name" scripts/
```

**Find all references to a variable:**
```bash
grep -r "TOWER_HEIGHT" scripts/
```

**Find all scene instances:**
```bash
grep -r "ExtResource" scenes/
```

**Count lines of code:**
```bash
find scripts/ -name "*.gd" -exec wc -l {} + | tail -1
```

## 💾 Backup Important Files

Before major changes, back up:
- `scripts/` - All your code
- `scenes/` - All your scenes
- `project.godot` - Project settings

## 🚀 Next Steps

1. **Explore**: Open each file and read comments
2. **Experiment**: Change one value, test it
3. **Customize**: Follow CUSTOMIZATION_CHECKLIST.md
4. **Create**: Make it your own unique game!

---

**Everything is documented, organized, and ready to modify. Have fun!**

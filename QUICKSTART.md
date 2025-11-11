# Quick Start Guide

Get Cat Tower Escape running in 5 minutes!

## 1. Install Godot

Download Godot 4.2 or later:
- **Website**: [godotengine.org/download](https://godotengine.org/download)
- Choose "Godot Engine - Standard version"
- Windows/Mac/Linux all supported

## 2. Open the Project

**Option A - Godot Project Manager:**
1. Launch Godot
2. Click "Import"
3. Navigate to the `cat-tower-escape` folder
4. Select `project.godot`
5. Click "Import & Edit"

**Option B - Command Line:**
```bash
cd cat-tower-escape
godot project.godot
```

## 3. Run the Game

Once the project opens in Godot:
- Press **F5**, or
- Click the **Play** button (▶) in the top-right corner

## 4. Play!

**Controls:**
- **A** or **Left Arrow** - Move left
- **D** or **Right Arrow** - Move right
- **Space** or **W** or **Up Arrow** - Jump

**Goal:**
- Climb from bottom to top (10 screen heights)
- Dodge flaming yarn balls
- Collect catnip (green) for invincibility
- Reach the garden to win!

## What You'll See

Since this is a prototype, visuals are simple placeholders:
- **Orange square** = Kitty (you!)
- **Brown rectangles** = Platforms
- **Orange-red circles** = Flaming yarn (avoid!)
- **Green circles** = Catnip (collect!)
- **Green rectangle at top** = Victory garden

## Next Steps

### Make It Look Better
See [README.md](README.md) for:
- Adding custom sprites
- Changing colors
- Adjusting difficulty

### Add Sound
See [AUDIO_SETUP.md](AUDIO_SETUP.md) for:
- Where to put audio files
- How to enable sound
- Free audio resources

### Customize Everything
The code is clean and well-commented. Key files:
- `scripts/player.gd` - Player controls
- `scripts/main.gd` - Game logic
- `scripts/yarn_spawner.gd` - Difficulty tuning
- `scenes/main.tscn` - Level layout

## Troubleshooting

**"Can't open project"**
- Make sure you downloaded Godot 4.2+, not Godot 3.x
- The file `project.godot` must exist in the folder

**Game runs but looks weird**
- This is normal! Placeholder graphics are just colored squares
- See README.md to add real sprites

**No sound**
- That's expected - audio files aren't included
- See AUDIO_SETUP.md to add them

**Player falls through floor**
- This shouldn't happen, but if it does:
- In Godot, go to Project > Reload Current Project

**Game is too hard/easy**
- Edit `scripts/yarn_spawner.gd`:
  - Change `spawn_interval_min` and `spawn_interval_max`
  - Bigger numbers = easier (less yarn)

## Having Fun?

Now you have a complete, working game! Feel free to:
- Modify it however you want
- Add new features
- Use it as a learning tool
- Turn it into your own unique game

Check out the full [README.md](README.md) for detailed information on every system.

**Enjoy your Cat Tower Escape!**

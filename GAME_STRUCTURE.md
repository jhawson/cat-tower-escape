# Cat Tower Escape - Game Structure

## Scene Hierarchy

```
Main (Node2D)                    [scripts/main.gd]
├── Background (ColorRect)       - Dark blue backdrop
├── TowerWalls (Node2D)
│   ├── LeftWall (StaticBody2D)  - Bounds player
│   └── RightWall (StaticBody2D) - Bounds player
├── Platforms (Node2D)
│   ├── Platform0 (StaticBody2D) - Starting platform
│   ├── Platform1 (StaticBody2D) - ~620 units up
│   ├── Platform2 (StaticBody2D) - ~1320 units up
│   ├── Platform3 (StaticBody2D) - ~1920 units up
│   ├── Platform4 (StaticBody2D) - ~2620 units up
│   ├── Platform5 (StaticBody2D) - ~3320 units up
│   ├── Platform6 (StaticBody2D) - ~4020 units up
│   ├── Platform7 (StaticBody2D) - ~4720 units up
│   ├── Platform8 (StaticBody2D) - ~5420 units up
│   ├── Platform9 (StaticBody2D) - ~6120 units up
│   └── Platform10 (StaticBody2D)- ~6820 units up
├── Collectibles (Node2D)        [scripts/catnip_placer.gd]
│   └── (Spawns 5 catnip instances at runtime)
├── Player (CharacterBody2D)     [scripts/player.gd]
│   ├── Sprite2D                 - Visual representation
│   ├── CollisionShape2D         - Physics collision
│   ├── AnimationPlayer          - For future animations
│   └── InvincibilityTimer       - 30-second countdown
├── Camera2D                     - Follows player vertically
├── YarnSpawner (Node2D)         [scripts/yarn_spawner.gd]
│   └── SpawnTimer               - Triggers yarn creation
├── VictoryZone (Area2D)         - At Y = -7200
│   ├── CollisionShape2D         - Detection area
│   └── GardenSprite             - Green victory visual
└── UI (CanvasLayer)             [scripts/ui.gd]
    ├── InvincibilityLabel       - Shows time remaining
    ├── HeightLabel              - Shows climb progress
    ├── GameOverPanel            - Hidden until death
    │   └── RestartButton
    └── VictoryPanel             - Hidden until win
        └── RestartButton
```

## Autoloaded Singletons

```
AudioManager [scripts/audio_manager.gd]
├── MusicPlayer (AudioStreamPlayer)
└── SoundPlayers[8] (AudioStreamPlayer pool)
```

## Game Flow Diagram

```
┌─────────────┐
│   START     │
│  (Main.gd)  │
└──────┬──────┘
       │
       ├─→ Position player at (0, 0)
       ├─→ Position victory zone at (0, -7200)
       ├─→ Spawn 5 catnip bundles
       ├─→ Start background music
       ├─→ Start yarn spawner timer
       │
       v
┌──────────────────┐
│   GAME LOOP      │
│                  │
│  Player moves    │◄───┐
│  Camera follows  │    │
│  Yarn spawns     │    │
│  Check collisions│    │
│  Update UI       │    │
└────────┬─────────┘    │
         │              │
         ├─→ Hit by yarn? ──YES──→ GAME OVER ──→ Restart?─┐
         │        │                                        │
         │       NO                                       YES
         │        │                                        │
         ├─→ Collect catnip? ──YES──→ Start invincibility │
         │        │                                        │
         │       NO                                        │
         │        │                                        │
         └─→ Reach top? ──YES──→ VICTORY ──→ Play Again?─┘
                  │
                 NO
                  │
                  └────────────────────────────────────────┘
```

## Physics Collision Layers

```
Layer 1 (Player):        Player character
Layer 2 (World):         Platforms, walls
Layer 3 (Hazards):       Flaming yarn balls
Layer 4 (Collectibles):  Catnip power-ups

Player collides with:    Layers 2 (World) & 3 (Hazards)
World collides with:     Layer 1 (Player) & 3 (Hazards)
Hazards collide with:    Layers 1 (Player) & 2 (World)
Collectibles detect:     Layer 1 (Player)
```

## Signal Flow

```
Player Signals:
┌──────────────┐
│   Player     │
└──────┬───────┘
       │
       ├── hit_by_yarn ────────→ Main.gd ──→ Trigger game over
       ├── catnip_collected ───→ Main.gd ──→ Update UI
       └── (via Area2D enter)──→ VictoryZone ──→ Trigger victory


UI Signals:
┌──────────────┐
│ RestartButton│
└──────┬───────┘
       │
       └── pressed ───→ UI.gd ──→ reload_current_scene()


Timer Signals:
┌──────────────────┐
│ InvincibilityTimer│
└──────┬────────────┘
       │
       └── timeout ───→ Player.gd ──→ Disable invincibility


┌──────────────┐
│ SpawnTimer   │
└──────┬───────┘
       │
       └── timeout ───→ YarnSpawner.gd ──→ Spawn new yarn
```

## Data Flow - Frame by Frame

```
Every Frame (_process or _physics_process):

1. PLAYER
   ├─ Read input (move_left, move_right, jump)
   ├─ Apply gravity if in air
   ├─ Apply velocity
   ├─ Check floor collision
   ├─ Update sprite facing direction
   └─ Call move_and_slide()

2. CAMERA
   └─ Update Y position to match player Y

3. YARN SPAWNER
   ├─ Get camera top Y position
   └─ If timer triggers:
       ├─ Create yarn instance
       ├─ Position above camera
       └─ Reset random timer

4. FLAMING YARN (each instance)
   ├─ Apply downward velocity
   ├─ Rotate for visual effect
   ├─ Check if hit player (Area2D)
   └─ Check if off-screen (destroy if yes)

5. MAIN
   ├─ Update camera position
   ├─ Pass camera Y to yarn spawner
   └─ Update UI with player data

6. UI
   ├─ Update invincibility timer display
   ├─ Update height progress %
   └─ Show/hide panels based on game state
```

## State Management

```
Game States (in Main.gd):
┌─────────────┐
│  game_over  │  boolean - Blocks input when true
│  victory    │  boolean - Blocks input when true
└─────────────┘

Player States (in Player.gd):
┌─────────────────┐
│  is_invincible  │  boolean - Prevents damage
│  velocity       │  Vector2 - Current movement
│  is_on_floor()  │  function - Checks platform contact
└─────────────────┘
```

## Input Mapping

```
Action: "move_left"
├─ Key: A
└─ Key: Left Arrow

Action: "move_right"
├─ Key: D
└─ Key: Right Arrow

Action: "jump"
├─ Key: Space
├─ Key: W
└─ Key: Up Arrow
```

## Audio Trigger Points

```
Sound Effects:
"jump"        ─→ Player.gd:_physics_process() when jump pressed
"catnip"      ─→ Player.gd:collect_catnip()
"yarn_spawn"  ─→ YarnSpawner.gd:spawn_yarn()
"yarn_hit"    ─→ FlamingYarn.gd:_on_body_entered() [player]
"yarn_bounce" ─→ FlamingYarn.gd:_on_body_entered() [world]
"hit"         ─→ Player.gd:hit_by_flaming_yarn()
"game_over"   ─→ Main.gd:_on_player_hit()

Music:
"main_theme"    ─→ Main.gd:_ready()
"victory_theme" ─→ Main.gd:_on_victory_zone_entered()
```

## Performance Considerations

```
Optimization Strategies Used:

1. Object Pooling Potential
   - Yarn balls are instantiated/destroyed
   - Could be pooled for better performance
   - Current approach fine for ~2 yarn/second

2. Collision Layers
   - Prevents unnecessary collision checks
   - Player doesn't check vs collectibles in physics
   - Collectibles use Area2D for detection only

3. Camera Culling
   - Yarn balls auto-destroy when off-screen
   - Prevents infinite accumulation

4. Audio Pooling
   - 8 sound players handle overlapping sounds
   - Prevents audio stacking issues
   - Reuses finished players

5. UI Updates
   - Only updates when values change
   - Timer text updates every frame (acceptable)
   - Height updates every frame (cheap calculation)
```

## File Dependencies

```
Main.tscn requires:
├─ main.gd
├─ player.tscn ──→ player.gd
├─ flaming_yarn.tscn ──→ flaming_yarn.gd
├─ catnip.tscn ──→ catnip.gd
├─ ui.tscn ──→ ui.gd
├─ yarn_spawner.gd
└─ catnip_placer.gd

All scripts reference:
└─ AudioManager (autoload)
```

## Coordinate System

```
Y-Axis (Vertical):
    -7200  ┌───────────┐  ← Victory Garden (top)
           │           │
           │  Platform │
    -6120  │     9     │
           │           │
           │  Platform │
    -4720  │     7     │
           │           │
           │  Platform │
    -3320  │     5     │
           │           │
    -1920  │  Platform │
           │     3     │
           │           │
     -620  │  Platform │
           │     1     │
           │           │
        0  └───────────┘  ← Starting Position (bottom)

X-Axis (Horizontal):
     -620  -300   0   300  620
      │     │    │    │    │
     Wall  (platforms)  Wall
```

## Constants & Magic Numbers

```
Player (scripts/player.gd):
- SPEED = 300.0              (horizontal movement)
- JUMP_VELOCITY = -500.0     (jump strength)
- Invincibility = 30.0 sec   (catnip duration)

Main (scripts/main.gd):
- TOWER_HEIGHT = 7200        (10 screens at 720px each)

YarnSpawner (scripts/yarn_spawner.gd):
- spawn_interval_min = 1.5   (seconds between spawns)
- spawn_interval_max = 3.5   (seconds between spawns)
- spawn_width = 1200.0       (horizontal spawn range)

FlamingYarn (scripts/flaming_yarn.gd):
- fall_speed = 400.0         (downward velocity)
- rotation_speed = 3.0       (visual spin)

AudioManager (scripts/audio_manager.gd):
- MAX_SOUND_PLAYERS = 8      (concurrent sounds)

Project Settings:
- Gravity = 980              (2D physics default)
- Window = 1280x720          (default resolution)
```

This structure gives you a complete overview of how all the pieces fit together!

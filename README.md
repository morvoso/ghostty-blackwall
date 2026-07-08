# Ghostty Blackwall Shaders

Custom GLSL shaders for [Ghostty](https://ghostty.org/) inspired by Cyberpunk 2077's Blackwall UI and old-school Tron red terminals.

## Shaders

### 1. `blackwall-dotmatrix.glsl` (Recommended)
A flat, high-contrast red dot-matrix shader built specifically to keep text clean and readable in terminal apps like Neovim and Fastfetch. 

- **Flat screen (`warp = 0.0`):** Keeps edge-to-edge geometry normal with no warped corners or distorted margins.
- **LED dot-matrix grille:** Breaks characters into distinct circular dots (`● ● ●`) separated by dark micro-gaps.
- **Tron red neon glow:** A tight, rich red bloom around text that stays on top of a pure `#000000` pitch black background.
- **Subtle breathing & rare surges:** The glow breathes gently by default, and occasionally triggers a quick, randomized electrical flicker surge to mimic voltage spikes.
- **Slight gradient & film grain:** A subtle red gradient from top to bottom with about 3% digital noise across luminous areas.

<img width="1753" height="843" alt="image" src="https://github.com/user-attachments/assets/40523c08-5ec9-48ad-8acd-e300282f91ee" />

### 2. `blackwall.glsl` (Classic Curved CRT)
The original analog CRT version with curved screen edges and extra procedural background effects.

- **CRT curvature (`CURVATURE = 0.08`):** Retro rounded monitor geometry.
- **Procedural background snippets:** Occasional tiny code bursts and faint data trails along the sides of the screen.
- **Glitch system:** Periodic subtle screen glitches and rare AI breach artifacts.

![Preview](./preview.png)

## Installation & Setup

1. Copy your shader of choice (`blackwall-dotmatrix.glsl` or `blackwall.glsl`) into `~/.config/ghostty/shaders/`.
2. Add the following to your `~/.config/ghostty/config`:

```conf
# Load the shader
custom-shader = ~/.config/ghostty/shaders/blackwall-dotmatrix.glsl

# Required so the breathing pulse and flicker surges keep animating when you aren't typing
custom-shader-animation = true

# Recommended: Use a red theme and solid black background for the best contrast
theme = blackwall-red
background-opacity = 1.0

# Recommended: A solid block cursor looks great under the dot-matrix grille
cursor-style = block
cursor-opacity = 1.0
```

## Customizing `blackwall.glsl`

If you're using `blackwall.glsl`, you can tweak the `#define` values at the top of the file:

| Constant | Default | Description |
|----------|---------|-------------|
| `SCANLINE_INTENSITY` | `0.12` | Strength of horizontal scanlines |
| `SCANLINE_COUNT` | `1000.0` | Number of scanlines on screen |
| `BLOOM_INTENSITY` | `1.6` | Brightness of the red glow |
| `UI_TINT` | `vec3(1.0, 0.02, 0.05)` | Primary color for UI glitches |
| `CURVATURE` | `0.08` | Amount of CRT edge curvature |
| `VIGNETTE_STRENGTH` | `0.55` | Darkening around the screen edges |

## Credits

Inspired by the "Deep Breach" and Blackwall UI elements from Cyberpunk 2077.

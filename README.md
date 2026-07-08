# Ghostty Blackwall Shader Collection

A Cyberpunk 2077 "Blackwall / Deep Breach" inspired shader collection for [Ghostty](https://ghostty.org/). This repository features high-contrast Tron/Cyberpunk red UI elements, glowing LED dot-matrix masks, rare Blackwall electrical power surges, and analog CRT characteristics.



## Included Shaders

### 1. `blackwall-dotmatrix.glsl` (Flat Tron Red LED Dot-Matrix - Recommended)
Calibrated for **100% razor-sharp readability** across modern TUIs (`neovim`, `fastfetch`) while delivering an electrifying Cyberpunk Blackwall Netrunner aesthetic:
- **Flat Edge-to-Edge Display (`warp = 0.0`):** Zero screen bulging or corner cutoffs.
- **High-Intensity Circular LED Dot-Matrix:** Breaks character strokes into crisp, glowing red matrix diodes (`● ● ●`) separated by deep aperture micro-gaps.
- **Tron Ruby Red Laser Bloom (`getEDEXBloom`):** 36-tap rich neon glow radiating from crisp text onto a rock-solid `#000000` pitch black background.
- **AI Core Breathing & Rare Power Surges (`getGlowFlicker`):** A hypnotic ±15% breathing pulse combined with rare, intense 150ms randomized high-voltage electrical flicker surges (~18% chance every 3 seconds).
- **Red Gradient Theme & Digital Grunge:** Subtle vertical color gradient with 3% analog/digital monitor static.

<img width="1753" height="843" alt="image" src="https://github.com/user-attachments/assets/40523c08-5ec9-48ad-8acd-e300282f91ee" />

### 2. `blackwall.glsl` (Classic Curved CRT Deep Breach Edition)
The classic analog CRT Deep Breach shader featuring:
- **CRT Curvature (`CURVATURE = 0.08`):** Rounded retro screen geometry.
- **Procedural Code Snippets & Streamers:** Subtle tech data bursts and data trails along screen edges.
- **Dual-Cycle Glitch System:** Periodic subtle artifacts and rare AI breach glitches.

![Preview](./preview.png)

## Installation

1. Copy either `blackwall-dotmatrix.glsl` or `blackwall.glsl` to a permanent location on your system (e.g., `~/.config/ghostty/shaders/`).
2. In your Ghostty config (usually `~/.config/ghostty/config`), specify your chosen shader:

```conf
# Use the Flat LED Dot-Matrix Tron Red Edition
custom-shader = ~/.config/ghostty/shaders/blackwall-dotmatrix.glsl
```

## Configuration

You can customize the shader by editing the `#define` constants at the top of `blackwall.glsl`:

| Constant | Default | Description |
|----------|---------|-------------|
| `SCANLINE_INTENSITY` | `0.12` | Strength of the horizontal scanlines. |
| `SCANLINE_COUNT` | `1000.0` | Number of scanlines across the screen. |
| `BLOOM_INTENSITY` | `1.6` | Intensity of the red glow effect. |
| `UI_TINT` | `vec3(1.0, 0.02, 0.05)` | The primary color of the UI/glitches. |
| `CURVATURE` | `0.08` | Amount of CRT screen curvature. |
| `VIGNETTE_STRENGTH` | `0.55` | Darkening of the screen edges. |

## Credits

Inspired by the "Deep Breach" UI from Cyberpunk 2077.

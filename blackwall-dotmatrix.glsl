// eDEX-UI Tron Red / Cyberpunk Blackwall AI Terminal Shader for Ghostty
// Calibrated for 100% crisp readability, deep pitch black background, red gradient theme, and subtle cyberpunk grunge!

// ==========================================
// 1. SUBTLE CRT MONITOR PARAMETERS
// ==========================================
float warp = 0.0; // Flat edge-to-edge display (no CRT curvature)
float scan = 0.25; // Clean scanline texture

// ==========================================
// 2. EDEX-UI TRON RED NEON LASER BLOOM
// ==========================================
vec3 getEDEXBloom(vec2 uv) {
    vec2 texel = 1.0 / iResolution.xy;
    vec3 bloom = vec3(0.0);
    
    // Rich, vibrant 36-tap Tron Red neon bloom (never smears text!)
    const int TAPS = 36;
    float totalWeight = 0.0;
    
    for (int i = 0; i < TAPS; i++) {
        float angle = float(i) * 2.39996323;
        float radius = pow(float(i) / float(TAPS - 1), 0.65) * 11.0; // Rich 11-pixel neon glow!
        
        vec2 offset = vec2(cos(angle), sin(angle)) * radius * texel;
        vec3 sampleCol = texture(iChannel0, uv + offset).rgb;
        
        float lum = dot(sampleCol, vec3(0.2126, 0.7152, 0.0722));
        vec3 highlight = sampleCol * smoothstep(0.02, 0.85, lum);
        
        // Boost Tron Ruby Red / Laser Red frequencies
        highlight.r *= 1.65;
        highlight.gb *= 0.45;
        
        float weight = exp(-radius * 0.22);
        bloom += highlight * weight;
        totalWeight += weight;
    }
    
    return (bloom / totalWeight) * 2.4;
}

// ==========================================
// 3. CYBERPUNK GRUNGE & DIGITAL NOISE
// ==========================================
float getGrungeNoise(vec2 uv, float time) {
    // Subtle analog/digital static on the CRT monitor glass
    float n = fract(sin(dot(uv * iResolution.xy + vec2(time * 12.3, time * 45.6), vec2(12.9898, 78.233))) * 43758.5453);
    return (n - 0.5) * 0.03; // Super subtle 3% grain grit!
}

// ==========================================
// 4. FUTURISTIC CYBERPUNK DOT-MATRIX MASK
// ==========================================
float getDotMatrixMask(vec2 fragCoord) {
    // 3x3 pixel grid per circular matrix dot
    vec2 dotGrid = fract(fragCoord / 3.0);
    
    // Circular dot shape inside each cell
    float dist = length(dotGrid - vec2(0.5, 0.5));
    
    // Soft dot boundary: gentle dot center, subtle grille gap
    return smoothstep(0.55, 0.25, dist);
}

// ==========================================
// 5. RARE RANDOMIZED INTENSE GLOW FLICKER
// ==========================================
float getGlowFlicker(float time) {
    // Break time into 3-second blocks to trigger rare electrical power surges
    float block = floor(time * 0.3333);
    float rareChance = fract(sin(block * 142.531 + 45.12) * 43758.5453);
    
    // Only trigger on ~18% of blocks (rare Blackwall power surges!)
    if (rareChance > 0.82) {
        float localTime = fract(time * 0.3333);
        // Quick 150ms flickering burst at the start of the rare surge block
        if (localTime < 0.05) {
            float chaoticNoise = fract(sin(time * 95.23 + 19.4) * 43758.5453);
            // Intense randomized glow multiplier (1.0x to 2.8x spike!)
            return 1.0 + pow(chaoticNoise, 1.5) * 1.8;
        }
    }
    return 1.0; // Calm, normal glow 98% of the time
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    float t = iTime;
    
    // --- Step A: Subtle CRT Monitor Curvature Warp ---
    vec2 dc = abs(0.5 - uv);
    dc *= dc;
    uv.x -= 0.5; uv.x *= 1.0 + (dc.y * (0.3 * warp)); uv.x += 0.5;
    uv.y -= 0.5; uv.y *= 1.0 + (dc.x * (0.4 * warp)); uv.y += 0.5;
    
    // If outside the curved CRT screen boundary, render pure pitch black casing
    if (uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0 || uv.y > 1.0) {
        fragColor = vec4(0.0, 0.0, 0.0, 1.0);
        return;
    }
    
    vec2 st = uv;
    
    // --- Step B: 100% Crisp Base Text with Subtle Chromatic Aberration ---
    // Sample base texture cleanly so text is razor sharp!
    vec2 eps = vec2(1.2 / iResolution.x, 0.0);
    vec3 col = vec3(0.0);
    col.r = texture(iChannel0, st + eps).r;
    col.g = texture(iChannel0, st).g;
    col.b = texture(iChannel0, st - eps).b;
    
    // --- Step C: Red Gradient Theme (Futuristic Blackwall AI Console) ---
    // Top of screen is bright electric laser red, shading down into deep cyber ruby red at bottom!
    float verticalGradient = mix(0.95, 1.10, st.y);
    col.r *= verticalGradient;
    
    // --- Step D: Vibrant Tron Red Neon Bloom with AI Core Breathing & Rare Flicker ---
    // Calm ±15% breathing pulse combined with rare, intense randomized Blackwall power surges!
    float aiPulse = (1.0 + 0.15 * sin(t * 1.5)) * getGlowFlicker(t);
    vec3 bloom = getEDEXBloom(st) * aiPulse;
    col += bloom;
    
    // Apply pulse and rare intense flicker to text (never to pitch black background!)
    float lum = dot(col, vec3(0.2126, 0.7152, 0.0722));
    if (lum > 0.02) {
        col *= aiPulse;
    }
    
    // --- Step E: Cyberpunk Grungy Atmosphere & LED Dot-Matrix Display ---
    // Add subtle digital grain / grunge static to luminous areas
    if (lum > 0.02) {
        col += getGrungeNoise(st, t) * col;
        
        // Apply subtle Dot-Matrix / LED grid mask to characters!
        // Divides solid strokes into soft, glowing circular matrix dots (● ● ●)
        float dotMask = getDotMatrixMask(fragCoord);
        col *= mix(0.70, 1.15, dotMask);
    }
    
    // Clean viewport edge vignette preserving pitch black
    vec2 vigUV = uv * (1.0 - uv.yx);
    float vig = vigUV.x * vigUV.y * 15.0;
    vig = pow(clamp(vig, 0.0, 1.0), 0.15);
    col *= mix(0.85, 1.0, vig);
    
    float a = texture(iChannel0, st).a;
    fragColor = vec4(col, a);
}

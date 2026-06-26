shader_type canvas_item;

// --- Glitch Uniforms ---
uniform float shake_power = 0.005;
uniform float shake_rate = 0.5;
uniform float shake_speed = 5.0;
uniform float shake_block_size = 10.0;
uniform float color_drift = 0.0005;

// --- Warping Uniforms ---
uniform float curve_x : hint_range(0.0, 1.0) = 0.1; // Horizontal bulge
uniform float curve_y : hint_range(0.0, 1.0) = 0.1; // Vertical bulge

// Helper function to create random noise
float random(float seed) {
    return fract(sin(seed) * 43758.5453123);
}

// Function to handle the barrel distortion
vec2 curve_uv(vec2 uv) {
    // Center coordinates to 0,0 (-0.5 to 0.5)
    vec2 centered_uv = uv * 2.0 - 1.0;
    
    // Calculate the offset based on distance from center
    // Multiplying x by y^2 and vice versa creates the corner pull
    centered_uv.x += (centered_uv.y * centered_uv.y) * centered_uv.x * curve_x;
    centered_uv.y += (centered_uv.x * centered_uv.x) * centered_uv.y * curve_y;
    
    // Return to 0.0 - 1.0 range
    return centered_uv * 0.5 + 0.5;
}

void fragment() {
    // 1. Apply Warping First
    vec2 warped_uv = curve_uv(UV);
    
    // 2. Determine Glitch Shift
    float enable_shift = float(
        random(trunc(TIME * shake_speed)) < shake_rate
    );

    vec2 fixed_uv = warped_uv;

    // 3. Horizontal "Block" Shifting (Applied to warped UVs)
    fixed_uv.x += (
        random(trunc(warped_uv.y * shake_block_size) + TIME) - 0.5
    ) * shake_power * enable_shift;

    // 4. Color Drift / Chromatic Aberration
    vec4 pixel_r = texture(TEXTURE, fixed_uv + vec2(color_drift * enable_shift, 0.0));
    vec4 pixel_g = texture(TEXTURE, fixed_uv);
    vec4 pixel_b = texture(TEXTURE, fixed_uv - vec2(color_drift * enable_shift, 0.0));

    // 5. Final Output
    vec4 final_color = vec4(pixel_r.r, pixel_g.g, pixel_b.b, pixel_g.a);
    
    // Optional: Cut off pixels outside the 0-1 range (creates the black rounded border)
    if (fixed_uv.x < 0.0 || fixed_uv.x > 1.0 || fixed_uv.y < 0.0 || fixed_uv.y > 1.0) {
        final_color.a = 0.0;
    }
    
    COLOR = final_color;
}
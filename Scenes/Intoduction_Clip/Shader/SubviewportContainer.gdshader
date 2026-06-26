shader_type canvas_item;

// These "uniforms" allow you to adjust the glitch intensity in the Inspector
uniform float shake_power = 0.005;
uniform float shake_rate = 0.5;
uniform float shake_speed = 5.0;
uniform float shake_block_size = 10;
uniform float color_drift = 0.0005;

// Helper function to create random noise
float random(float seed) {
    return fract(sin(seed) * 43758.5453123);
}

void fragment() {
    // Determine if we should "twitch" this frame
    float enable_shift = float(
        random(trunc(TIME * shake_speed)) < shake_rate
    );

    vec2 fixed_uv = UV;

    // Horizontal "Block" Shifting
    fixed_uv.x += (
        random(trunc(UV.y * shake_block_size) + TIME) - 0.5
    ) * shake_power * enable_shift;

	// Multiply color_drift by enable_shift so it only splits when it shakes
	vec4 pixel_r = texture(TEXTURE, fixed_uv + vec2(color_drift * enable_shift, 0.0));
	vec4 pixel_g = texture(TEXTURE, fixed_uv);
	vec4 pixel_b = texture(TEXTURE, fixed_uv - vec2(color_drift * enable_shift, 0.0));

    COLOR = vec4(pixel_r.r, pixel_g.g, pixel_b.b, pixel_g.a);
}
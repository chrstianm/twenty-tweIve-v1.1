shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform float curvature : hint_range(0.0, 1.0) = 0.2;
uniform float vignette_softness : hint_range(0.0, 1.0) = 0.5;
uniform float scanline_count : hint_range(0.0, 1080.0) = 10.0;
uniform float static_intensity : hint_range(0.0, 0.5) = 0.05;

// Function to warp UVs for the "fish-eye" CRT look
vec2 curve(vec2 uv) {
	uv = (uv - 0.5) * 2.0;
	uv *= 1.1; // Slight zoom to hide edges
	uv.x *= 1.0 + pow((abs(uv.y) / 5.0), 2.0) * curvature;
	uv.y *= 1.0 + pow((abs(uv.x) / 4.0), 2.0) * curvature;
	uv  = (uv / 2.0) + 0.5;
	return uv;
}

void fragment() {
	vec2 uv = curve(SCREEN_UV);

	// 1. CRT Warping & Screen Clamp
	if (uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0 || uv.y > 1.0) {
		COLOR = vec4(0.0, 0.0, 0.0, 1.0);
	} else {
		// 2. Base Texture
		vec4 text = texture(screen_texture, uv);

		// 3. Scanlines
		float s = sin(uv.y * scanline_count * PI * 2.0);
		s = (s * 0.5 + 0.5) * 0.9 + 0.1;
		vec4 scanline_color = vec4(vec3(s), 1.0);

		// 4. Static / Grain (Analog Horror Factor)
		float noise = (fract(sin(dot(uv + TIME, vec2(12.9898,78.233))) * 43758.5453) - 0.5) * static_intensity;
		text.rgb += noise;

		// 5. Vignette
		float dist = distance(uv, vec2(0.5));
		text.rgb *= smoothstep(0.8, vignette_softness, dist);

		COLOR = text * scanline_color;

		float amount = 0.002 * sin(TIME); // Shimmering color bleed
		float r = texture(screen_texture, uv + vec2(amount, 0.0)).r;
		float g = texture(screen_texture, uv).g;
		float b = texture(screen_texture, uv - vec2(amount, 0.0)).b;
		text = vec4(r, g, b, 1.0);
	}
}
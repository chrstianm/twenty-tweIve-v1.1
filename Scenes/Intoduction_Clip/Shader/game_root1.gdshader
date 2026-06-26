shader_type canvas_item;

// --- Uniforms (Adjust in Inspector) ---
// High value = less warp (flatter screen). Try 4.0 for a subtle curved look.
uniform float warp_intensity : hint_range(0.0, 10.0) = 4.0;
// uniform float scanline_count : hint_range(0.0, 1080.0) = 300.0;
uniform float scanline_softness : hint_range(0.1, 1.0) = 0.5; // (Fixes Moiré)
uniform float vignette_radius : hint_range(0.0, 1.0) = 1.0;
uniform float static_intensity : hint_range(0.0, 0.5) = 0.05;
uniform float chromatic_offset : hint_range(0.0, 0.01) = 0.002;

void fragment() {
	// 1. REFINED SCREEN WARP (Targeted at Edges)
	vec2 uv = UV;

	// Convert UVs from 0...1 to -1...+1
	vec2 norm_uv = uv * 2.0 - 1.0;

	// Apply warp based on distance from the center.
	// The center (0,0) is least affected.
	norm_uv += (norm_uv.yx * norm_uv.yx) * norm_uv * (1.0 / warp_intensity);

	// Convert back to 0...1 UVs
	vec2 warped_uv = (norm_uv + 1.0) / 2.0;

	// 2. Sample the Video (with Chromatic Aberration)
	float r = texture(TEXTURE, warped_uv + vec2(chromatic_offset, 0.0)).r;
	float g = texture(TEXTURE, warped_uv).g;
	float b = texture(TEXTURE, warped_uv - vec2(chromatic_offset, 0.0)).b;
	vec4 video_color = vec4(r, g, b, 1.0);

    // 3. ANALOG HORROR: ADD STATIC (Mandela Catalogue vibe)
    // fract(sin()) is a fast noise generator
    float noise = (fract(sin(dot(warped_uv + TIME, vec2(12.9898, 78.233))) * 43758.5453) - 0.5) * static_intensity;
    video_color.rgb += noise;

	// 4. SOFT SCANLINES (No Star Patterns)
	// 'mix()' smooths the transition to avoid the hard lines that cause moiré
	// float s = sin(warped_uv.y * scanline_count * PI * 2.0);
	// s = mix(1.0 - scanline_softness, 1.0, (s * 0.5 + 0.5));
	// video_color.rgb *= s;

	// 5. VIGNETTE (Creates the dark TV casing edge)
	float d = distance(warped_uv, vec2(0.5));
	video_color.rgb *= smoothstep(vignette_radius, 0.50, d);

	COLOR = video_color;
}
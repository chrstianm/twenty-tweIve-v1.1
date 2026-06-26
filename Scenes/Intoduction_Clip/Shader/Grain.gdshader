shader_type canvas_item;

uniform float vignette_intensity = 0.58;
uniform float noise_opacity = 0.10;

void fragment() {
    // 1. Calculate the Noise (Static)
    float noise = fract(sin(dot(UV + TIME, vec2(12.9898, 78.233))) * 43758.5453);

    // 2. Calculate the Vignette Mask
    // This creates a value where the center is 1.0 and corners approach 0.0
    float dist = distance(UV, vec2(0.5, 0.5));
    float vignette = smoothstep(0.8, vignette_intensity, dist);

    // 3. Combine them correctly
    // We create a white noise base, then multiply it by the vignette
    // so the noise itself gets darker at the edges.
    vec3 combined_rgb = vec3(noise) * noise_opacity;

    // 4. Set the Final Color
    // The RGB is our noise.
    // The Alpha (A) is the inverse of our vignette (darker edges).
	COLOR = vec4(vec3(0.0), (1.0 - vignette) + (noise * noise_opacity));
}
shader_type canvas_item;

// Screen texture hint grabs everything rendered behind the ColorRect
uniform sampler2D screen_texture : hint_screen_texture, filter_nearest;

uniform float contrast : hint_range(0.0, 10.0) = 4.0;
uniform float brightness : hint_range(-1.0, 1.0) = -0.3;
uniform float saturation : hint_range(0.0, 4.0) = 1.6;
uniform float color_levels : hint_range(2.0, 20.0) = 2.0; // The blocky "deep-fried" look

void fragment() {
    // 1. Grab the screen image beneath this pixel
    vec4 screen_color = texture(screen_texture, SCREEN_UV);
    
    // 2. Adjust Brightness
    vec3 color = screen_color.rgb + vec3(brightness);
    
    // 3. Adjust Saturation
    float luma = dot(color, vec3(0.299, 0.587, 0.114));
    color = mix(vec3(luma), color, saturation);
    
    // 4. Boost Contrast (Forces harsh blacks and blown-out whites)
    color = (color - 0.5) * contrast + 0.5;
    
    // 5. Quantize / Posterize (Creates the low-quality digital artifacting)
    color = floor(color * color_levels) / color_levels;
    
    // Keep colors within safe limits
    color = clamp(color, 0.0, 1.0);
    
    COLOR = vec4(color, screen_color.a);
}
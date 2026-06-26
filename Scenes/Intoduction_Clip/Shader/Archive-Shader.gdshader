shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear;
uniform float blur_amount : hint_range(0.0, 5.0) = 1.5;

void fragment() {
    // Get the screen pixel
    vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV);
    
    // Create a horizontal "bleed" by sampling nearby pixels
    // This mimics the way old tube TVs couldn't transition colors instantly
    vec4 blur = texture(SCREEN_TEXTURE, SCREEN_UV + vec2(blur_amount * 0.001, 0.0));
    blur += texture(SCREEN_TEXTURE, SCREEN_UV + vec2(-blur_amount * 0.001, 0.0));
    
    // Mix them together
    COLOR = (color + blur) / 2.0;
    
    // Optional: Add very subtle "Scanlines"
    float scanline = sin(SCREEN_UV.y * 400.0) * 0.05;
    COLOR.rgb -= scanline;
}
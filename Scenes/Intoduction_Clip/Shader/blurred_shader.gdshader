shader_type canvas_item;

// Allows you to control the blur strength from the Inspector
uniform float blur_amount : hint_range(0.0, 5.0) = 2.0;
uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;

void fragment() {
    // lod (Level of Detail) creates the blur effect
    // by reading from lower-resolution versions of the screen
    vec4 color = textureLod(screen_texture, SCREEN_UV, blur_amount);
    COLOR = color;
}
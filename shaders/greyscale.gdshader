shader_type canvas_item;

uniform float saturation : hint_range(0.0, 1.0) = 0.0;

void fragment() {
	vec4 color = texture(TEXTURE, UV);

	// Calculate luminance (perceived brightness)
	float grey = dot(color.rgb, vec3(0.299, 0.587, 0.114));

	// Mix between original color and greyscale based on saturation
	vec3 greyscale = vec3(grey);
	color.rgb = mix(greyscale, color.rgb, saturation);

	// Apply modulate alpha for fade out, but keep greyscale RGB
	color.a *= COLOR.a;
	COLOR = color;
}

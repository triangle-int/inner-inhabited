shader_type spatial;

uniform vec3 albedo_1 : source_color;
uniform vec3 albedo_2 : source_color;
uniform float metallic : hint_range(0.0, 1.0) = 0;
uniform float roughness : hint_range(0.0, 1.0) = 0.02;

uniform sampler2D texture_normal_1;
uniform sampler2D texture_normal_2;

uniform vec2 wave_direction_1 = vec2(2.0, 0.0);
uniform vec2 wave_direction_2 = vec2(0.0, 1.0);

uniform float time_scale : hint_range(0.0, 0.2, 0.005) = 0.025;

uniform sampler2D wave;
uniform sampler2D wave_bump;

uniform float noise_scale = 10.0;
uniform float height_scale = 0.15;

varying float height;
varying vec3 world_pos;

varying float vertex_distance;
varying float vertex_distance_clamped;
varying vec2 vertex_pos;

float fresnel(float amount, vec3 normal, vec3 view) {
	return pow((1.0 - clamp(dot(normalize(normal), normalize(view)), 0.0, 1.0)), amount);
}

float waveheight(vec2 offset, int mode) {
	float h1 = 0.0; // Wave1 texture height
	float h2 = 0.0; // Wave2 texture height
	float hmix = 0.0; // Wave texture heights mixed
	switch (mode) {
		case 0: // For getting only the Wave1 height
			h1 = texture(wave, (world_pos.xz + offset) / noise_scale + (TIME * wave_direction_1) * time_scale).r;
			return h1;
		case 1: // For getting only the Wave2 height
			h2 = texture(wave, (world_pos.xz + offset) / noise_scale + (TIME * wave_direction_2) * time_scale).r;
			return h2;
		case 2: // For getting both Wave1 and Wave2 heights and getting the average
			h1 = texture(wave, (world_pos.xz + offset) / noise_scale + (TIME * wave_direction_1) * time_scale).r;
			h2 = texture(wave, (world_pos.xz + offset) / noise_scale + (TIME * wave_direction_2) * time_scale).r;
			hmix = mix(h1, h2, 0.5);
			return hmix;
	}
}

void vertex() {
	world_pos = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
	
	vertex_distance = distance(world_pos, vec3(0));
	vertex_distance = clamp(vertex_distance, 0.0, 85.0);
	vertex_distance_clamped = vertex_distance / 85.0;
	
	float prev_height_x = waveheight(vec2(-0.3, 0.0), 2);
	float next_height_x = waveheight(vec2(0.3, 0.0), 2);
	float prev_height_y = waveheight(vec2(0.0, -0.3), 2);
	float next_height_y = waveheight(vec2(0.0, 0.3), 2);
	
	float height_mix = waveheight(vec2(0.0, 0.0), 2);
	VERTEX.y += height_mix * height_scale * (1.0 - vertex_distance_clamped);
	
	float fraction_x = fract(round(UV.x * 1000.0) / 10.0);
	float fraction_y = fract(round(UV.y * 1000.0) / 10.0);
	
	if (fraction_x != 0.0) {
		if (fract(UV.y) == 0.0) {
			VERTEX.y = ((prev_height_x + next_height_x) * height_scale * (1.0 - vertex_distance_clamped)) / 2.0;
		}
	}
	if (fraction_y != 0.0) {
		if (fract(UV.x) == 0.0) {
			VERTEX.y = ((prev_height_y + next_height_y) * height_scale * (1.0 - vertex_distance_clamped)) / 2.0;
		}
	}
}

void fragment() {
	vec2 offset_1 = (TIME * wave_direction_1) * time_scale;
	vec2 offset_2 = (TIME * wave_direction_2) * time_scale;
	
	vec3 normal_blend = mix(texture(texture_normal_1, world_pos.xz / 10.0 + offset_1 / 10.0).rgb, texture(texture_normal_2, world_pos.xz / 10.0 + offset_2 / 10.0).rgb, 0.5);
	vec3 wave_normal_blend = mix(texture(wave_bump, world_pos.xz / noise_scale + offset_1).xyz, texture(wave_bump, world_pos.xz / noise_scale + offset_2).xyz, 0.3);
	
	float fresnel_value = fresnel(5.0, NORMAL, VIEW);
	vec3 surface_color = mix(albedo_1, albedo_2, fresnel_value);
	
	ALBEDO = surface_color;
	METALLIC = metallic;
	ROUGHNESS = roughness;
	NORMAL_MAP = mix(wave_normal_blend, normal_blend, 0.5);
	SPECULAR = wave_normal_blend.r;
}

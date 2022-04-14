// NOTE: Shader automatically converted from Godot Engine 3.4.3.stable's SpatialMaterial.

shader_type spatial;
render_mode blend_mix,depth_draw_alpha_prepass,cull_back,diffuse_burley,specular_schlick_ggx;
uniform vec4 albedo : hint_color;
uniform sampler2D texture_albedo : hint_albedo;
uniform float specular;
uniform float metallic;
uniform float roughness : hint_range(0,1);
uniform float point_size : hint_range(0,128);
uniform vec3 uv1_scale;
uniform vec3 uv1_offset;
uniform vec3 uv2_scale;
uniform vec3 uv2_offset;
uniform bool hide = false;

void vertex() {
	UV=UV*uv1_scale.xy+uv1_offset.xy;
}

void fragment() {
	vec2 base_uv = UV;
	vec4 albedo_tex = texture(texture_albedo,base_uv);
	ALBEDO = albedo.rgb * albedo_tex.rgb;
	METALLIC = metallic;
	ROUGHNESS = roughness;
	SPECULAR = specular;
	if(hide){
		vec2 p = vec2(FRAGCOORD.x, FRAGCOORD.y);
		vec2 c = vec2(VIEWPORT_SIZE.x/2f, VIEWPORT_SIZE.y/2f + 25f);
		if(distance(p, c) < 150f + (VERTEX.z * 10f)){
			ALPHA = 0f;
		}
	}
}
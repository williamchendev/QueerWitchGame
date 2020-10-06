//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;

uniform sampler2D alphaTex;

void main()
{
	vec4 AlphaColor = texture2D(alphaTex, v_vTexcoord);
	vec4 Color = texture2D( gm_BaseTexture, v_vTexcoord );
	Color = vec4(Color.r, Color.g, Color.b, max(Color.a - AlphaColor.a, 0.0));
    gl_FragColor = Color;
}

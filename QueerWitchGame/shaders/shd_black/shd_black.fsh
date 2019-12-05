//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;

void main()
{
	vec4 Color = texture2D( gm_BaseTexture, v_vTexcoord );
	if (Color.a > 0.0) {
		Color = vec4(0.0, 0.0, 0.0, 1.0);
	}
    gl_FragColor = Color;
}

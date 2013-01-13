attribute vec3 a_position;
varying vec2 TexCoord;

void main(void)
{
	gl_Position = vec4(a_position, 1.0);
	TexCoord = (a_position.xy + 1.0) * 0.5;
}
uniform sampler2D colorTexture;
uniform sampler2D depthTexture;
varying vec2 TexCoord;


void main (void)
{
    float fog = texture2D(depthTexture,TexCoord).r;
    
    float fogStart = 0.995;
    float fogEnd = 1.0;
    float fogFactor = 1.0;
    
    fog = smoothstep(fogStart, fogEnd, fog) * fogFactor;
    
    vec4 fogColor = vec4(0.5,0.8,1.0,1.0);
    
	gl_FragColor =	texture2D(colorTexture,TexCoord) * (1.0-fog) + fogColor*fog;
}
#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D sampler0;

varying vec2 v_texcoord0;

void main() {
  vec4 c = texture2D(sampler0, v_texcoord0);
  gl_FragColor = vec4(c.rgb, (c.r + c.r + c.g + c.g + c.g + c.b) / 6.0);
}

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D sampler0;

varying vec2 v_texcoord0;

void main() {
  vec4 c = texture2D(sampler0, v_texcoord0);
  gl_FragColor = vec4(c.rgb, c.r * 0.299 + c.g * 0.587 + c.b * 0.114);
  //gl_FragColor = vec4(c.rgb, sqrt(c.r * c.r * 0.299 + c.g * c.g * 0.587 + c.b * c.b * 0.114));
}

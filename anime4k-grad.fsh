#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D sampler0;
uniform vec2 u_texelDelta;

varying vec2 v_texcoord0;

void main() {
  float dx = u_texelDelta.x;
  float dy = u_texelDelta.y;

  float tl = texture2D(sampler0, v_texcoord0 + vec2(-dx, -dy)).a;
  float tc = texture2D(sampler0, v_texcoord0 + vec2(0.0, -dy)).a;
  float tr = texture2D(sampler0, v_texcoord0 + vec2( dx, -dy)).a;

  float ml = texture2D(sampler0, v_texcoord0 + vec2(-dx, 0.0)).a;
  float mr = texture2D(sampler0, v_texcoord0 + vec2( dx, 0.0)).a;

  float bl = texture2D(sampler0, v_texcoord0 + vec2(-dx,  dy)).a;
  float bc = texture2D(sampler0, v_texcoord0 + vec2(0.0,  dy)).a;
  float br = texture2D(sampler0, v_texcoord0 + vec2( dx,  dy)).a;

  // Horizontal gradient
  // [-1  0  1]
  // [-2  0  2]
  // [-1  0  1]
  // Vertical gradient
  // [-1 -2 -1]
  // [ 0  0  0]
  // [ 1  2  1]
  vec2 grad = vec2(-tl + tr - ml - ml + mr + mr - bl + br,
                   -tl - tc - tc - tr + bl + bc + bc + br);

  // Computes the luminance's gradient and saves it in the unused alpha channel
  gl_FragColor = vec4(texture2D(sampler0, v_texcoord0).rgb,
                      1.0 - clamp(length(grad), 0.0, 1.0));
}

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D sampler0;
uniform vec2 u_pixelDelta;
uniform vec4 u_setting;

varying vec2 v_texcoord0;

void main() {
  float dx = u_pixelDelta.x;
  float dy = u_pixelDelta.y;

  // c0 b0 c1
  // b1 a0 b2
  // c2 b3 c3
  vec4 a0 = texture2D(sampler0, v_texcoord0);
  vec4 b0 = texture2D(sampler0, v_texcoord0 + vec2( 0.0, -dy ));
  vec4 b1 = texture2D(sampler0, v_texcoord0 + vec2(-dx ,  0.0));
  vec4 b2 = texture2D(sampler0, v_texcoord0 + vec2( dx ,  0.0));
  vec4 b3 = texture2D(sampler0, v_texcoord0 + vec2( 0.0,  dy ));
  vec4 c0 = texture2D(sampler0, v_texcoord0 + vec2(-dx , -dy ));
  vec4 c1 = texture2D(sampler0, v_texcoord0 + vec2( dx , -dy ));
  vec4 c2 = texture2D(sampler0, v_texcoord0 + vec2(-dx ,  dy ));
  vec4 c3 = texture2D(sampler0, v_texcoord0 + vec2( dx ,  dy ));

  float edge_peak = u_setting.x;
  if (edge_peak != 0.0) {
    b0 = mix(a0, b0, clamp(abs(a0.a - b0.a) / edge_peak, 0.0, 1.0));
    b1 = mix(a0, b1, clamp(abs(a0.a - b1.a) / edge_peak, 0.0, 1.0));
    b2 = mix(a0, b2, clamp(abs(a0.a - b2.a) / edge_peak, 0.0, 1.0));
    b3 = mix(a0, b3, clamp(abs(a0.a - b3.a) / edge_peak, 0.0, 1.0));
    c0 = mix(a0, c0, clamp(abs(a0.a - c0.a) / edge_peak, 0.0, 1.0));
    c1 = mix(a0, c1, clamp(abs(a0.a - c1.a) / edge_peak, 0.0, 1.0));
    c2 = mix(a0, c2, clamp(abs(a0.a - c2.a) / edge_peak, 0.0, 1.0));
    c3 = mix(a0, c3, clamp(abs(a0.a - c3.a) / edge_peak, 0.0, 1.0));
  }

  const float a_weight = 4.0;
  const float b_weight = 2.0;
  const float c_weight = 1.0;
  const float gross_weight = a_weight + b_weight * 4.0 + c_weight * 4.0;

  vec4 a = a0 * (a_weight / gross_weight);
  vec4 b = (b0 + b1 + b2 + b3) * (b_weight / gross_weight);
  vec4 c = (c0 + c1 + c2 + c3) * (c_weight / gross_weight);
  gl_FragColor = a + b + c;
}

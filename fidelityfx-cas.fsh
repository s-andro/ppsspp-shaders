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

  // a b c
  // d e f
  // g h i
  vec3 a = texture2D(sampler0, v_texcoord0 + vec2(-dx, -dy)).rgb;
  vec3 b = texture2D(sampler0, v_texcoord0 + vec2(0.0, -dy)).rgb;
  vec3 c = texture2D(sampler0, v_texcoord0 + vec2( dx, -dy)).rgb;
  vec3 d = texture2D(sampler0, v_texcoord0 + vec2(-dx, 0.0)).rgb;
  vec3 e = texture2D(sampler0, v_texcoord0).rgb;
  vec3 f = texture2D(sampler0, v_texcoord0 + vec2( dx, 0.0)).rgb;
  vec3 g = texture2D(sampler0, v_texcoord0 + vec2(-dx,  dy)).rgb;
  vec3 h = texture2D(sampler0, v_texcoord0 + vec2(0.0,  dy)).rgb;
  vec3 i = texture2D(sampler0, v_texcoord0 + vec2( dx,  dy)).rgb;

  vec3 min_rgb = min(min(min(min(b, d), e), f), h);
  min_rgb += min(min(min(min(min_rgb, a), c), g), i);
  vec3 max_rgb = max(max(max(max(b, d), e), f), h);
  max_rgb += max(max(max(max(max_rgb, a), c), g), i);

  vec3 amp_rgb = sqrt(clamp(min(min_rgb, 2.0 - max_rgb) * (1.0 / max_rgb), 0.0, 1.0));
  float peak = -1.0 / mix(8.0, 5.0, clamp(u_setting.x, 0.0, 1.0));
  vec3 weight_rgb = amp_rgb * peak;
  vec3 weight_rgb_rcp = 1.0 / (1.0 + 4.0 * weight_rgb);
  vec3 window = (b + d) + (f + h);
  gl_FragColor.rgb = clamp((window * weight_rgb + e) * weight_rgb_rcp, 0.0, 1.0);
}

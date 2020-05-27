#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D sampler0;
uniform vec2 u_texelDelta;
uniform vec4 u_setting;

varying vec2 v_texcoord0;

float min3a(vec4 a, vec4 b, vec4 c) {
  return min(min(a.a, b.a), c.a);
}

float max3a(vec4 a, vec4 b, vec4 c) {
  return max(max(a.a, b.a), c.a);
}

vec4 getLargest(vec4 cc, vec4 lightest, vec4 a, vec4 b, vec4 c) {
  cc = cc * (1.0 - u_setting.x) + ((a + b + c) / 3.0) * u_setting.x;
  return cc.a > lightest.a ? cc : lightest;
}

void main() {
  float dx = u_texelDelta.x;
  float dy = u_texelDelta.y;

  vec4 tl = texture2D(sampler0, v_texcoord0 + vec2(-dx, -dy));
  vec4 tc = texture2D(sampler0, v_texcoord0 + vec2(0.0, -dy));
  vec4 tr = texture2D(sampler0, v_texcoord0 + vec2( dx, -dy));

  vec4 ml = texture2D(sampler0, v_texcoord0 + vec2(-dx, 0.0));
  vec4 mc = texture2D(sampler0, v_texcoord0);
  vec4 mr = texture2D(sampler0, v_texcoord0 + vec2( dx, 0.0));

  vec4 bl = texture2D(sampler0, v_texcoord0 + vec2(-dx,  dy));
  vec4 bc = texture2D(sampler0, v_texcoord0 + vec2(0.0,  dy));
  vec4 br = texture2D(sampler0, v_texcoord0 + vec2( dx,  dy));

  vec4 lightestColor = mc;

  //Kernel 0 and 4
  float maxDark = max3a(br, bc, bl);
  float minLight = min3a(tl, tc, tr);
  if (minLight > mc.a && minLight > maxDark) {
    lightestColor = getLargest(mc, lightestColor, tl, tc, tr);
  } else {
    maxDark = max3a(tl, tc, tr);
    minLight = min3a(br, bc, bl);
    if (minLight > mc.a && minLight > maxDark) {
      lightestColor = getLargest(mc, lightestColor, br, bc, bl);
    }
  }

  //Kernel 1 and 5
  maxDark = max3a(mc, ml, bc);
  minLight = min3a(mr, tc, tr);
  if (minLight > maxDark) {
    lightestColor = getLargest(mc, lightestColor, mr, tc, tr);
  } else {
    maxDark = max3a(mc, mr, tc);
    minLight = min3a(bl, ml, bc);
    if (minLight > maxDark) {
      lightestColor = getLargest(mc, lightestColor, bl, ml, bc);
    }
  }

  //Kernel 2 and 6
  maxDark = max3a(ml, tl, bl);
  minLight = min3a(mr, br, tr);
  if (minLight > mc.a && minLight > maxDark) {
    lightestColor = getLargest(mc, lightestColor, mr, br, tr);
  } else {
    maxDark = max3a(mr, br, tr);
    minLight = min3a(ml, tl, bl);
    if (minLight > mc.a && minLight > maxDark) {
      lightestColor = getLargest(mc, lightestColor, ml, tl, bl);
    }
  }

  //Kernel 3 and 7
  maxDark = max3a(mc, ml, tc);
  minLight = min3a(mr, br, bc);
  if (minLight > maxDark) {
    lightestColor = getLargest(mc, lightestColor, mr, br, bc);
  } else {
    maxDark = max3a(mc, mr, bc);
    minLight = min3a(tc, ml, tl);
    if (minLight > maxDark) {
      lightestColor = getLargest(mc, lightestColor, tc, ml, tl);
    }
  }

  gl_FragColor = lightestColor;
}

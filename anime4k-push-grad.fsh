#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D sampler0;
uniform vec2 u_pixelDelta;
uniform vec4 u_setting;

varying vec2 v_texcoord0;

float min3a(vec4 a, vec4 b, vec4 c) {
  return min(min(a.a, b.a), c.a);
}

float max3a(vec4 a, vec4 b, vec4 c) {
  return max(max(a.a, b.a), c.a);
}

vec4 getAverage(vec4 cc, vec4 a, vec4 b, vec4 c) {
  cc = cc * (1.0 - u_setting.x) + ((a + b + c) / 3.0) * u_setting.x;
  return vec4(cc.rgb, 1.0);
}

void main() {
  float dx = u_pixelDelta.x;
  float dy = u_pixelDelta.y;

  vec4 tl = texture2D(sampler0, v_texcoord0 + vec2(-dx, -dy));
  vec4 tc = texture2D(sampler0, v_texcoord0 + vec2(0.0, -dy));
  vec4 tr = texture2D(sampler0, v_texcoord0 + vec2( dx, -dy));

  vec4 ml = texture2D(sampler0, v_texcoord0 + vec2(-dx, 0.0));
  vec4 mc = texture2D(sampler0, v_texcoord0);
  vec4 mr = texture2D(sampler0, v_texcoord0 + vec2( dx, 0.0));

  vec4 bl = texture2D(sampler0, v_texcoord0 + vec2(-dx,  dy));
  vec4 bc = texture2D(sampler0, v_texcoord0 + vec2(0.0,  dy));
  vec4 br = texture2D(sampler0, v_texcoord0 + vec2( dx,  dy));

  //Kernel 0 and 4
  float maxDark = max3a(br, bc, bl);
  float minLight = min3a(tl, tc, tr);
  if (minLight > mc.a && minLight > maxDark) {
    gl_FragColor = getAverage(mc, tl, tc, tr);
    return;
  } else {
    maxDark = max3a(tl, tc, tr);
    minLight = min3a(br, bc, bl);
    if (minLight > mc.a && minLight > maxDark) {
      gl_FragColor = getAverage(mc, br, bc, bl);
      return;
    }
  }

  //Kernel 1 and 5
  maxDark = max3a(mc, ml, bc);
  minLight = min3a(mr, tc, tr);
  if (minLight > maxDark) {
    gl_FragColor = getAverage(mc, mr, tc, tr);
    return;
  } else {
    maxDark = max3a(mc, mr, tc);
    minLight = min3a(bl, ml, bc);
    if (minLight > maxDark) {
      gl_FragColor = getAverage(mc, bl, ml, bc);
      return;
    }
  }

  //Kernel 2 and 6
  maxDark = max3a(ml, tl, bl);
  minLight = min3a(mr, br, tr);
  if (minLight > mc.a && minLight > maxDark) {
    gl_FragColor = getAverage(mc, mr, br, tr);
    return;
  } else {
    maxDark = max3a(mr, br, tr);
    minLight = min3a(ml, tl, bl);
    if (minLight > mc.a && minLight > maxDark) {
      gl_FragColor = getAverage(mc, ml, tl, bl);
      return;
    }
  }

  //Kernel 3 and 7
  maxDark = max3a(mc, ml, tc);
  minLight = min3a(mr, br, bc);
  if (minLight > maxDark) {
    gl_FragColor = getAverage(mc, mr, br, bc);
    return;
  } else {
    maxDark = max3a(mc, mr, bc);
    minLight = min3a(tc, ml, tl);
    if (minLight > maxDark) {
      gl_FragColor = getAverage(mc, tc, ml, tl);
      return;
    }
  }

  gl_FragColor = mc;
}

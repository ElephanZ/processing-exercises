PImage quantize(PImage I, int k) {
  PImage res = I.copy();
  res.loadPixels();
  
  for(int i = 0, q; i < res.pixels.length; i++) {
    q = floor((blue(res.pixels[i]) * k) / 256);
    q = int((float(q) / (k-1)) * 255);
    res.pixels[i] = color(q);
  }
  res.updatePixels();
  
  return res;
}

PImage bitplane(PImage I, int nb) {
  PImage res = I.copy();
  res.loadPixels();
  
  for(int i = 0; i < res.pixels.length; i++) {
    int x = int(blue(res.pixels[i]));
    int r = (x >> nb) & 1;
    res.pixels[i] = color(255 * r); 
  }
  res.updatePixels();
  
  return res;
}

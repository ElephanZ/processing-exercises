PImage replication_2x(PImage I) {
  PImage res = createImage(2*I.width, 2*I.height, RGB);
  
  for (int x = 0; x < I.width; x++) {
    for (int y = 0; y < I.height; y++) {
      res.set(2*x, 2*y, I.get(x,y));
      res.set(2*x+1, 2*y, I.get(x,y));
      res.set(2*x, 2*y+1, I.get(x,y));
      res.set(2*x+1, 2*y+1, I.get(x,y));
    }
  }
  
  return res;
}

float MSE(PImage I1, PImage I2) {
  float res = 0.0;
 
  I1.loadPixels();
  I2.loadPixels();
  
  for (int i = 0; i < I1.pixels.length; i++) res += pow(blue(I1.pixels[i]) - blue(I2.pixels[i]), 2);
  res /= I1.pixels.length;
  
  return res;
}

float PSNR(PImage I1, PImage I2) {
  float mse = MSE(I1, I2);
  return 10 * log(255*255 / mse) / log(10);
}

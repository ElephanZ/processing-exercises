PImage lena, out;

void setup() {
  size(512, 256);
  
  lena = loadImage("lenna.png");
  lena.resize(256, 256);
  lena.filter(GRAY);
  
  out = gamma(lena, int(random(5, 15)));
}

void draw() {
  image(lena, 0, 0);
  image(out, 256, 0);
}

void keyPressed() {
  if (key == 'r' || key == 'R') 
    out = negativo(lena);
}


PImage negativo(PImage I) {
  PImage res = I.copy();
  res.loadPixels();
  
  float r, g, b;

  for (int i = 0; i < res.pixels.length; i++) {
    r = 255 - red(res.pixels[i]);
    g = 255 - green(res.pixels[i]);
    b = 255 - blue(res.pixels[i]);
    res.pixels[i] = color(r, g, b);
  }
  res.updatePixels();
  
  return res;
}

PImage gamma(PImage I, float gamma) {
  PImage res = createImage(I.width, I.height, RGB);
  res.loadPixels();
  
  float r, g, b;
  float C = 1 / pow(255, gamma - 1);
  
  I.loadPixels();
  for (int i = 0; i < res.pixels.length; i++) {
    r = C * pow(red(I.pixels[i]), gamma);
    g = C * pow(green(I.pixels[i]), gamma);
    b = C * pow(blue(I.pixels[i]), gamma);
    res.pixels[i] = color(r, g, b);
  }
  res.updatePixels();
  
  return res;
}

PImage logarithm(PImage I) {
  PImage res = createImage(I.width, I.height, RGB);
  res.loadPixels();
  
  float r, g, b;
  float C = 255 / log(256);
  
  I.loadPixels();
  for (int i = 0; i < res.pixels.length; i++) {
    r = C * log(1 + red(I.pixels[i]));
    g = C * log(1 + green(I.pixels[i]));
    b = C * log(1 + blue(I.pixels[i]));
    res.pixels[i] = color(r, g, b);
  }
  res.updatePixels();
  
  return res;
}

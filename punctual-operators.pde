PImage lena, out;

void setup() {
  size(512, 256);
  
  lena = loadImage("lena.png");
  lena.resize(256, 256);
  lena.filter(GRAY);
  
  out = lena.copy();
}

void draw() {
  image(lena, 0, 0);
  image(out, 256, 0);
}

void keyPressed() {
  if (key == 'n' || key == 'N') 
    out = operator(lena, "negative");
  else if (key == 'g' || key == 'G')
    out = operator(lena, "gamma");
  else if (key == 'l' || key == 'L')
    out = operator(lena, "log");
}


PImage operator(PImage I, String type) {
  PImage res = I.copy();
  res.loadPixels();

  for (int i = 0; i < res.pixels.length; i++) 
    res.pixels[i] = (type == "log" ? logarithm(res.pixels[i]) :
                    (type == "negative" ? negative(res.pixels[i]) :
                    gamma(res.pixels[i], random(2, 8))));

  res.updatePixels();  
  return res;
}

color negative(color c) {
  float r, g, b;
  
  r = 255 - red(c);
  g = 255 - green(c);
  b = 255 - blue(c);
  
  return color(r, g, b);
}

color gamma(color c, float gamma) {
  float r, g, b;
  float C = 1 / pow(255, gamma - 1);
  
  r = C * pow(red(c), gamma);
  g = C * pow(green(c), gamma);
  b = C * pow(blue(c), gamma);
  
  return color(r, g, b);
}

color logarithm(color c) {
  float r, g, b;
  float C = 255 / log(256);
  
  r = C * log(1 + red(c));
  g = C * log(1 + green(c));
  b = C * log(1 + blue(c));
  
  return color(r, g, b);
}

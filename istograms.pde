PImage lena;
lena = loadImage("lena.png");

size(700, 1000);
background(#f2f2f2);

noStroke();
fill(0);
line(0, height-100, width, height-100);

float[] res_green = istogramma(lena, 'g');
fill(0, 255, 0);
for (int i = 0; i < res_green.length; i++)
  line(i + 10, height-100, i + 10, height-100-res_green[i]);

float[] res_blue = istogramma(lena, 'b');
fill(0, 0, 255);
for (int i = 0; i < res_blue.length; i++)
  line(i + 10, height-100, i + 10, height-100-res_blue[i]);

float[] res_red = istogramma(lena, 'r');
fill(255, 0, 0);
for (int i = 0; i < res_red.length; i++)
  line(i + 10, height-100, i + 10, height-100-res_red[i]);


float[] istogramma(PImage I, char color) {
  float[] res = new float[256];
  for (int i = 0; i < 256; i++) res[i] = 0;
  
  I.loadPixels();
  
  for (int i = 0; i < I.pixels.length; i++) {
    if (color == 'r') res[(int)red(I.pixels[i])]++;
    else if (color == 'g') res[(int)green(I.pixels[i])]++;
    else if (color == 'b') res[(int)blue(I.pixels[i])]++;
  }  
  for (int i = 0; i < 256; i++) res[i] /= I.pixels.length;
  
  return res;
}

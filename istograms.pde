class Tuple {
  float r_count, g_count, b_count;
  
  Tuple(float r, float g, float b) {
    r_count = r;
    g_count = g;
    b_count = b;
  }
}

PImage lena;
lena = loadImage("lena.png");

size(700, 1000);
background(#f2f2f2);

noStroke();
fill(0);
line(0, height-100, width, height-100);

Tuple[] res = istogram(lena);

fill(255, 0, 0, 100);
for (int i = 0; i < res.length; i++)
  line(i + 10, height-100, i + 10, height-100-res[i].r_counter);

fill(0, 255, 0, 100);
for (int i = 0; i < res.length; i++)
  line(i + 10, height-100, i + 10, height-100-res[i].g_counter);

fill(0, 0, 255, 100);
for (int i = 0; i < res.length; i++)
  line(i + 10, height-100, i + 10, height-100-res[i].b_counter);


Tuple[] istogram(PImage I) {
  Tuple[] res = new Tuple[256];
  for (int i = 0; i < 256; i++) res[i] = new Tuple(0, 0, 0);
  
  I.loadPixels();
  
  for (int i = 0; i < I.pixels.length; i++) {
    res[(int)red(I.pixels[i])].r_counter++;
    res[(int)green(I.pixels[i])].g_counter++;
    res[(int)blue(I.pixels[i])].b_counter++;
  }  
  for (int i = 0; i < 256; i++) {
    res[i].r_counter /= I.pixels.length;
    res[i].g_counter /= I.pixels.length;
    res[i].b_counter /= I.pixels.length;
  }
  
  return res;
}

PImage equalize(PImage I) {
  PImage res = I.copy();
  res.loadPixels();
  
  Tuple[] counter = istogram(I);
  for(int i = 1; i < 256; i++)
    counter[i].g_counter = counter[i].g_counter + counter[i-1].g_counter;
  
  for(int i = 0; i < res.pixels.length; i++)
    res.pixels[i] = color(255 * counter[int(green(res.pixels[i].g_counter))]); 
  res.updatePixels();
  
  return res;
}

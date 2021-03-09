PImage lena, med_res, max_res, min_res;

void setup() {
  size(1024, 256);
  
  lena = loadImage("lenna.png");
  lena.resize(256, 256);
  lena.filter(GRAY);
  
  med_res = median(lena, int(random(5, 15)));
  max_res = max(lena, int(random(5, 15)));
  min_res = min(lena, int(random(5, 15)));
}

void draw() {
  image(lena, 0, 0);
  image(min_res, 256, 0);
  image(med_res, 512, 0);
  image(max_res, 768, 0);
}

void keyPressed() {
  if (key == 'd' || key == 'D') 
    med_res = median(lena, int(random(5, 15)));
  else if (key == 'x' || key == 'X') 
    max_res = max(lena, int(random(5, 15)));
  else if (key == 'n' || key == 'N') 
    min_res = min(lena, int(random(5, 15)));
}



PImage median(PImage I, int N) {
  PImage res = createImage(I.width, I.height, RGB);
 
  for(int i = 0; i < I.width; i++) {
    float[] pixels_container = new float[N*N];
    float med_color;
  
     for(int j = 0; j < I.height; j++) {   
       PImage tmp = I.get(i-(N/2), j-(N/2), N, N);
       tmp.loadPixels();
       
       for(int k = 0; k < tmp.pixels.length; k++) pixels_container[k] = green(tmp.pixels[k]);
       pixels_container = sort(pixels_container);
       
       if((n*n) % 2 == 1) med_color = pixels_container[(n*n)/2];
       else med_color = (pixels_container[(n*n)/2] + pixels_container[(n*n)/2]) / 2;
       
       res.set(i, j, color(pixels_container));
     }
  }
  
  return res; 
}

PImage min(PImage I, int N) {
  PImage res = createImage(I.width, I.height, RGB);
  float[] pixels_container;
  
  for (int x = 0; x < I.width; x++) {
     for (int y = 0; y < I.height; y++) {
       int xs = x-(N/2), ys = y-(N/2);
       
       PImage tmp = I.get(max(0, xs), max(0, ys), min(N, min(N+xs, I.width-xs)), min(N, min(N+ys, I.height-ys)));
       tmp.loadPixels();
   
       pixels_container = new float[tmp.pixels.length];
       for(int i = 0; i < tmp.pixels.length; i++) pixels_container[i] = green(tmp.pixels[i]);
       
       res.set(x, y, color(min(pixels_container)));
     }
  }
  
  return res;
}

PImage max(PImage I, int N) {
  PImage res = createImage(I.width, I.height, RGB);
  float[] pixels_container;
  
  for (int x = 0; x < I.width; x++) {
     for (int y = 0; y < I.height; y++) {
       int xs = x-(N/2), ys = y-(N/2);
       
       PImage tmp = I.get(x-off, y-off, N, N);
       tmp.loadPixels();
   
       pixels_container = new float[N * N];
       for(int i = 0; i < tmp.pixels.length; i++) pixels_container[i] = green(tmp.pixels[i]);
       
       res.set(x, y, color(max(pixels_container)));
     }
  }
  
  return res;
}

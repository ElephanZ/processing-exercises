PImage lena, med_res;

void setup() {
  size(512, 256);
  
  lena = loadImage("lenna.png");
  lena.resize(256, 256);
  lena.filter(GRAY);
  
  med_res = median(lena, int(random(5, 15)));
}

void draw() {
  image(lena, 0, 0);
  image(med_res, 256, 0);
}

void keyPressed() {
  if (key == 'r' || key == 'R') 
    med_res = median(lena, int(random(5, 15)));
}



PImage median(PImage I, int n) {
  PImage res = createImage(I.width, I.height, RGB);
  
  int offset = n/2;
  
  for(int i = 0; i < I.width; i++) {
    float[] container = new float[n*n];
    float med_color;
  
     for(int j = 0; j < I.height; j++) {
       
       PImage tmp = I.get(i-offset, j-offset, n, n);
       tmp.loadPixels();
       
       for(int k = 0; k < tmp.pixels.length; k++) container[k] = green(tmp.pixels[k]);
       container = sort(container);
       
       if((n*n) % 2 == 1) med_color = container[(n*n)/2];
       else med_color = (container[(n*n)/2] + container[(n*n)/2]) / 2;
       
       res.set(i, j, color(med_color));
       
     }
  }
  
  return res; 
}

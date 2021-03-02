PImage lena, rev_res, med_res;

void setup() {
  size(768, 256);
  
  lena = loadImage("lenna.png");
  lena.resize(256, 256);
  lena.filter(GRAY);
  
  rev_res = rev(lena);
  med_res = median(rev_res, int(random(5, 15)));
}

void draw() {
  image(lena, 0, 0);
  image(rev_res, 256, 0);
  image(med_res, 512, 0);
}

void keyPressed() {
  if (key == 'r' || key == 'R') 
    med_res = median(rev_res, int(random(5, 15)));
}



PImage rev(PImage I) {
  PImage res = I.copy();
  int N = I.width, M = I.height;
  
  image(I, 0, 0);
  PImage leftPart = get(0, 0, int(N/2), M);
  PImage rightPart = get(int(N/2), 0, N, M);
  
  res.set(0, 0, rightPart);
  res.set(int(N/2), 0, leftPart);
  
  res.loadPixels();
  for (int i = 0; i < N; i++) {
    res.set(i, i, #F7F00C);
  }
  
  return res;
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

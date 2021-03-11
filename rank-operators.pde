PImage lena, avg_res, max_res, min_res;

void setup() {
  size(1024, 256);
  
  lena = loadImage("lenna.png");
  lena.resize(256, 256);
  lena.filter(GRAY);
  
  avg_res = rankOperator(lena, int(random(5, 15)), "avg");
  max_res = rankOperator(lena, int(random(5, 15)), "max");
  min_res = rankOperator(lena, int(random(5, 15)), "min");
}

void draw() {
  image(lena, 0, 0);
  image(min_res, 256, 0);
  image(avg_res, 512, 0);
  image(max_res, 768, 0);
}

void keyPressed() {
  if (key == 'd' || key == 'D') 
    avg_res = rankOperator(lena, int(random(5, 15)), "avg");
  else if (key == 'x' || key == 'X') 
    max_res = rankOperator(lena, int(random(5, 15)), "max");
  else if (key == 'n' || key == 'N') 
    min_res = rankOperator(lena, int(random(5, 15)), "min");
}



PImage rankOperator(PImage I, int N, String operator) {
  PImage res = createImage(I.width, I.height, RGB);
  
  for (int x = 0; x < I.width; x++) {
     for (int y = 0; y < I.height; y++) {
       int xs = x-(N/2), ys = y-(N/2);
       
       PImage tmp;
       if (operator == "max" || operator == "avg") tmp = I.get(xs, ys, N, N);
       else tmp = I.get(max(0, xs), max(0, ys), min(N, min(N+xs, I.width-xs)), min(N, min(N+ys, I.height-ys)));
       tmp.loadPixels();
   
       float[] pixels_container = new float[(operator == "max" || operator == "avg" ? N*N : tmp.pixels.length)];
       for(int i = 0; i < tmp.pixels.length; i++) pixels_container[i] = green(tmp.pixels[i]);
       pixels_container = sort(pixels_container);
       
       color sol = color(0, 0, 0);
       if (operator == "max") sol = color(pixels_container[pixels_container.length - 1]);
       else if (operator == "min") sol = color(pixels_container[0]);
       else {
         float avg_color = 0.0;
         if((N*N) % 2 == 1) avg_color = pixels_container[(N*N)/2];
         else avg_color = (pixels_container[(N*N)/2] + pixels_container[(N*N)/2]) / 2;
         sol = color(avg_color);
       }
     
       res.set(x, y, sol);
     }
  }
  
  return res;
}

class Robot {
  int r, g, b;
  int counter;
  int x, y, l;
  
  Robot(int _x, int _y) {
    x = _x;
    y = _y;
    l = 25;
    counter = 0;
    
    r = 0;
    g = 0;
    b = 0;
    switch (int(random(0, 3))) {
      case 0: r = 255; break;
      case 1: g = 255; break;
      case 2: b = 255; break;
      default: break;
    }
  }
  
  void updatePos() {
    noStroke();
    fill(color(r, g, b));
    rectMode(CORNER);
    rect(x, y, l, l);
    
    x += int(random(-5, 5));
    y += int(random(-5, 5));
  }
  
  void updateState() {
    if (counter++ < 100) return;
    
    counter = 0;
    if (r == 255) {
      r = 0;
      g = 255;
    }
    else if (g == 255) {
      g = 0;
      b = 255;
    }
    else if (b == 255) {
      b = 0;
      r = 255;
    }
  }
}


ArrayList<Robot> robots;

void setup() {
  size(500, 500);
  frameRate(60);
  
  robots = new ArrayList<Robot>();
  for (int i = 0; i < 12; i++)
    robots.add(new Robot(int(random(100, width-100)), int(random(100, height-100)))); 
}

void draw() {
  background(0);
  
  for (Robot el: robots) {
    el.updateState();
    el.updatePos();
  }
}

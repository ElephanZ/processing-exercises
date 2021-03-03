class Car {
  float x, y, initial_x;
  float velX;
  float b, h;
  
  Car(float _x, float _y, float _sx) {
    b = 60;
    h = 30;
    x = initial_x = _x;
    y = _y;
    velX = _sx;
  }
  
  void disegna() {
    noStroke();
    fill(0, 255, 0);
    rectMode(CORNER);
    rect(x, y, b, h);
  }
  
  void move() {
    x += velX;
    x %= width;
    disegna();
  }
  
  void reset() {
    x = initial_x;
  }
  
}

class ElectricCar extends Car {
  boolean isEven;
  float gray;
  
  ElectricCar(float _x, float _y, float _sx, float _g) {
    super(_x, _y, _sx);
    gray = _g;
    isEven = true;
  }
  
  void disegna() {
    noStroke();
    fill(gray);
    rectMode(CORNER);
    rect(x, y, b, h);
    if (isEven) {
      fill(#F7F00C);
      triangle(x+(b/2), y, x+(b/2)-15, y+h, x+(b/2)+15, y+h);
    }
  }
  
  void move() {
    x += velX;
    if (x > width) {
      x = 0;
      isEven = !isEven;
    }
    disegna();
  }
  
  void reset() {
    x = initial_x;
    isEven = true;
  }
  
}


Car bmw;
ElectricCar toyota;

void setup() {
  size(512, 512);
  frameRate(30);
  
  float bmw_vel = random(2, 10); 
  bmw = new Car(random(0, width), 1*(height/3), bmw_vel);
  toyota = new ElectricCar(random(0, width), 2*(height/3), bmw_vel/2, random(0, 255));
}

void draw() {
  background(255);
  
  bmw.move();
  toyota.move();  
}

void keyPressed() {
  if (key == 'R' || key == 'r') {
    bmw.reset();
    toyota.reset();
  }
}

class Tri {
  float x1;
  float y1;
  float x2;
  float y2;
  float x3;
  float y3;
  float life = 255;

  Tri(float tempX, float tempY) {
    x1 = tempX;
    y1 = height;
    x2 = 0;
    y2 = height;
    x3 = width;
    y3 = height;
  }

  void move(float speed) {
    //x1 += speed;
    y1 -= speed;
    //x2 -= speed;
    //y2 += speed;
    //x3 += speed;
    //y3 += speed;
  }

  boolean finished() {
    // Balls fade out
    life--;
    if (y1 < -height) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    // Display the circle
    noFill();
    stroke(colorCounter+30, 155, 255, life);
   strokeWeight(weight_hi+5);
    triangle(x1, y1, x2, y2, x3, y3);
  }
}  

class Tri {
  float x1;
  float y1;
  float x2;
  float y2;
  float x3;
  float y3;


  Tri(float tempX, float tempY) {
    x1 = tempX;
    y1 = tempY;
    x2 = tempX;
    y2 = tempY;
    x3 = tempX;
    y3 = tempY;
  }

  void move(float speed) {
    //x1 += speed;
    y1 -= speed;
    x2 -= speed;
    y2 += speed;
    x3 += speed;
    y3 += speed;
  }

  boolean finished() {
    // Balls fade out
    //life--;
    if ((abs(x2)+abs(x3)) >width) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    // Display the circle
    noFill();
    stroke(255);
    //stroke(0,life);
    triangle(x1, y1, x2, y2, x3, y3);
  }
}  

class Tri {
  float x1;
  float y1;
  float x2;
  float y2;
  float x3;
  float y3;
  float slow;
  float fast;
  float life = 360;
  float c;
  float l;
  Tri(float tempX, float tempY, float slow1, float fast1, float colors, float fade) {
    x1 = tempX;
    y1 = tempY;
    x2 = tempX;
    y2 = tempY;
    x3 = tempX;
    y3 = tempY;
    slow =slow1;
    fast = fast1;
    c = colors;
    l = fade;
  }

  void move(float speed ) {
    //x1 += speed;
    y1 -= speed;
    x2 -= speed*slow;
    y2 += speed*slow;
    x3 += speed*fast;
    y3 += speed*fast;
  }

  boolean finished() {
    // Balls fade out
    life-=l;
    if ((abs(x2)+abs(x3)) > width/2) {
      return true;
    } else {
      return false;
    }
  }

  void display(float weight) {
    // Display the circle
    noFill();
    strokeWeight(weight);
    stroke(c, 360, 360, life);

    //stroke(0,life);
    triangle(x1, y1, x2, y2, x3, y3);
    triangle(-x1, y1, -x2, y2, -x3, y3);
  }
}  

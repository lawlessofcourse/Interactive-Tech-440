class Line {
  float x;
  float y;
  float speed;
  float gravity;
  float w;
  float life = 255;
  
  Line(float x, float y, float w) {
    this.x = x;
    this.y = y;
    this.w = w;
    speed=random(1, 3);
    gravity = 0.1;
  }

  void move() {
    w += speed;
    if (w>=50)
    {
      speed*=-1;
    }
  }

  boolean finished() {
    // Balls fade out
    //life--;
    if (w <0) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    blendMode(ADD);
    noFill();
    stroke(255);
    for (float i = x; i <= x+w; i++) 
    {

      float inter = map(i, x, x+w, 0, 1);
      color c = lerpColor(whi, b, inter);
      stroke(c);
      line(i, y-height, i, y+height);
      line(-i, y-height, -i, y+height);
    }
    for (float j = x; j >= x-w; j--) 
    {
      float inter = map(j, x, x-w, 0, 1);
      color c = lerpColor(whi, b, inter);
      stroke(c);
      line(j, y-height, j, y+height);
    }
  }
}  

class Ball {
  float x;
  float y;
  float speed;
  float gravity;
  float w;
  float life = 255;
  
  Ball(float tempX, float tempY) {
    x = tempX;
    y = tempY;
    w = 0;
    speed = 0;
    gravity = 0.1;
  }
  
    void move(float speed) {
    // Add gravity to speed
    //speed = speed + gravity;
    // Add speed to y location
   // y = y + speed;
    // If square reaches the bottom
    // Reverse speed
    //if (y > height) {
      // Dampening
     //speed = speed * -0.8;
      //y = height;
    //}
    w += speed;
  }
  
  boolean finished() {
    // Balls fade out
    //life--;
    if (w > 0.75*width) {
      return true;
    } else {
      return false;
    }
  }
  
  void display(float h, float s, float b) {
    // Display the circle
    noFill();
    //blendMode(ADD);
    strokeWeight(weight_low);
    stroke(h,s,b, 100);
    ellipse(x,y,w,w);
  }
}  

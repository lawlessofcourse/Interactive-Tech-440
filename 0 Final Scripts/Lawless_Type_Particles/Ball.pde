class Ball {
  float x;
  float y;
  float speed;
  float gravity;
  float w;
  float life = 255;
  
  Ball(float tempX, float tempY, float tempW) {
    x = tempX;
    y = tempY;
    w = tempW;
    speed = 0;
    gravity = 0.1;
  }
  
    void move() {
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
    speed =15+ weight_low;
    w += speed;
    
  }
  
  boolean finished() {
    // Balls fade out
    //life--;
    if (w >width+200) {
      return true;
    } else {
      return false;
    }
  }
  
  void display() {
    // Display the circle
    noFill();
    float al = map(w,0,width+200,255,0);
    stroke(darkPurp, al);
    strokeWeight(weight_whole*2+4);
    //stroke(0,life);
    //stroke(0,life);
    ellipse(x,y,w,w);
  }
}  

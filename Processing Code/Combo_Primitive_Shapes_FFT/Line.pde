class Line {

  float x;
  float y;
  float speed;
  float gravity;
  float w;
  //float life = 255;
  

  Line(float x, float y, float w) {
    this.x = x;
    this.y = y;
    this.w = w;
    //speed=1;
    speed=random(1,3);
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
    w += speed;
    if (w>=weight_whole*10)
    {
      speed*=-1;
    } 
    //else if (w<0)
    //{
    //  speed*=-1;
    //}
  }

  boolean finished() {
    // Balls fade out
    life--;
    if (w <0) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    // Display the circle
    blendMode(ADD);
    noFill();
   // stroke(255, 0,255);
    //stroke(0,life);
    //ellipse(x,y,w,w);
    for (float i = x; i <= x+w; i++) 
    {
      //for (float j = x; j>=x-w; i--) 
      //{
        float inter = map(i, x, x+w, 0, 1);
        color c = lerpColor(whi, b, inter);
        stroke(c);
        line(i, y-height, i, y+height);
        line(-i, y-height, -i, y+height);
      //}
    }
    for (float j = x; j >= x-w; j--) 
    {
      //for (float j = x; j>=x-w; i--) 
      //{
        float inter = map(j, x, x-w, 0, 1);
        color c = lerpColor(whi, b, inter);
        stroke(c);
        line(j, y-height, j, y+height);
        //line(-i, y-height, -i, y+height);
      //}
    }
    
  }
}  

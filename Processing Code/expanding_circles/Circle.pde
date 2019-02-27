class Circle
{
  //float x;
  //float y;
  float posX;
  float posY;
  float deltaX;
  float deltaY;
  float ring;
  float weight;
  float size2;
  float circleX;
  float circleY;
  float rad;
  Circle(float x, float y, float size) {
    circleX = x;
    circleY = y;
    size2 = size*2;
    posX = x;
    posY = y;
    deltaX = random(-4, 4);
    deltaY = random(-4, 4);
    weight = 1;
    rad = size2/2;
  }

  void show(float h, float s, float b)
  {
    noFill();
    stroke(h, s, b);
    strokeWeight(0.5);
    
    for (int i = 0; i < size2; i++) 
    {
      ellipse(posX, posY, ring + i, ring+i);
      ring+=0.1;
      if (ring>10) 
      {
        ring = 0;
      }
    }
  }
  void checkEdge() {
    float d = dist(circleX, circleY, posX, posY);
    if (d+ rad > 500|| d- rad > 500) {
      deltaX *= -1;
      deltaY *= -1;
    }
  }
  void move()
  {
    posX += deltaX;
    posY += deltaY;
  }
}  

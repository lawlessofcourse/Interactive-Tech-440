class Diamond
{
  float x1;
  float y1;
  float x2;
  float y2;  
  float x3;
  float y3;
  float x4;
  float y4;
  float speed;
  float life = 255;

  Diamond(float tempX, float tempY, float move)
  {
    x1 = tempX;
    y1 = tempY;
    x2 = tempX;
    y2 = tempY;
    x3 = tempX;
    y3 = tempY;
    x4 = tempX;
    y4 = tempY;
    speed = move;
  }
  boolean finished()
  {
    life-=5;
    if ((abs(x2)+abs(x4)) > width) {
      return true;
    } else {
      return false;
    }
  }
  void move()
  {
    y1 += speed*0.8;
    //x1-=speed;
    x2 += speed*1.2;
    //y2 = 0;
    y3 -= speed*0.8;
    x4 -= speed*1.2;
  }
  void display(float weight, float c)
  {
    noFill();
    stroke(c, 255, 255, life);
    strokeWeight(weight);
    quad(x1, y1, x2, y2, x3, y3, x4, y4);
  }
}

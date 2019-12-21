class Line{
  float x1;
  float x2;
  float y1;
  float y2;
  float life = 255; 
  Line(){
    x1 = 0;
    x2 = width;
    y1 = height;
    y2 = height; 
  }
  void move(float speed){
    y1 -= speed;
    y2 -= speed; 
  }
  boolean finished(){
    life-=2;
    if(y1<0){
      return true;
    }else{
      return false;
    }
  }
  void display(){
    stroke(colorCounter, 155, 255, life);
    strokeWeight(weight_low+10);
    line(x1, y1, x2, y2);
  }
}

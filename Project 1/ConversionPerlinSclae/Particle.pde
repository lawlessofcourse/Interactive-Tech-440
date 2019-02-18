class Particle{
  PVector dir;
  PVector vel;
  PVector pos;
  float speed;
  
  Particle(float x, float y){
   dir = new PVector(0,0);
   vel = new PVector(10,-2.5);
   pos = new PVector(x,y);
   speed = 0.4;
  }
  void move(){
    float angle = noise(pos.x/noiseScale, pos.y/noiseScale)*QUARTER_PI*noiseScale;
    dir.x = cos(angle);
    dir.y = sin(angle);
    vel = dir.copy();
    vel.mult(speed);
    pos.add(vel);
    
  }
  void checkEdge(){
    if(pos.x > width || pos.x < 0 || pos.y > height || pos.y < 0){
      pos.x = random(50, width);
      pos.y = random(50, height);
    }
  }
  void show(float r)
  {
    ellipse(pos.x, pos.y, r, r);
  }
}

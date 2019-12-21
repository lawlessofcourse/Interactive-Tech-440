class Particle
{
  PVector pos,pos2, speed,speed2, grav;
  int margin = 2;
  float splash = 2;
  float r = random(0.5,5);
  float startx, starty;
  float xspeed,yspeed;
    float g, rc, b;
  ArrayList tail;
  float taillength = 1;
  int life=255;


  public Particle(float tmpX, float tmpY, float velY)
  {
      g =random(10, 90);
    rc =random(50, 220); 
    b = random(200, 255);
    startx = tmpX+random(-splash, splash);
    starty = tmpY+random(-splash, splash);
    //startx = constrain(startx, 0, width);
    //starty = constrain(starty, 0, height);
     xspeed = random(-0.0, 0.0);
    //yspeed = random(-8, 8);
    yspeed=velY;
    pos2 = new PVector(startx,starty);
    pos = new PVector(startx, starty);
    
    //grav = new PVector(0, 0.08);

    tail = new ArrayList();
  }
  void run()
  {
   
    //if(yspeed
    speed = new PVector(xspeed, yspeed*gDir);
    speed2 = new PVector(yspeed*0.25,xspeed);
    
    pos.add(speed);
    pos2.add(speed2);
    tail.add(new PVector(pos.x, pos.y, 0));
    if (tail.size() > taillength) {
      tail.remove(0);
    }

    float damping = random(-0.5, 0.5);
    if (pos.x > width - margin || pos.x < margin) {
      speed.x *= damping;
    }
    if (pos.y > height -margin) {
      speed.y *= damping;
    }
    if (pos2.x > width - margin || pos2.x < margin) {
      speed2.y *= damping;
    }
    if (pos2.y > height -margin) {
      speed2.x *= damping;
    }
  }

  boolean finished() {
    // Balls fade out
    
    life-=10;
    if (life < 0) {
      return true;
    } else {
      return false;
    }
  }

  void gravity()
  {
    speed.add(grav);
    
  }

  void update()
  {
    pushStyle();
    noStroke();

    fill(rc, g, b,life);
    ellipse(pos.x, pos.y, r, r*2);
    if(pos2.y>=0||pos2.y<=-125){
      ellipse(pos2.x, pos2.y, r*2, r);
    }
    //ellipse(0,0,20,20);
    popStyle();
  }
  float getX(){return pos.x;}
  float getY(){return pos.y;}
} 
    //for (int i = 0; i < tail.size(); i++) {
    //  PVector tempv = (PVector)tail.get(i);
    
    //  fill(255,0,0);
    //  ellipse(tempv.x, tempv.y, r, r);
    //}

//for (int i=0; i<pnts.length; i++)
//{
//  float d = dist(startx, starty, pnts[i].x, pnts[i].y);
//  println(d);
//  if (d<45&&d>20)
//  { 
//    stroke(255, 0, 0);
//    strokeWeight(1);//random(0,0.5));
//    line(startx, starty, pnts[i].x, pnts[i].y);
//  }
//}

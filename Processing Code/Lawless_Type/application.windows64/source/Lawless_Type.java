import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import geomerative.*; 
import processing.pdf.*; 
import java.util.Calendar; 
import processing.sound.*; 
import geomerative.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Lawless_Type extends PApplet {






ArrayList plist = new ArrayList();
int MAX = 10;
ArrayList<Particle> prt;
ArrayList<Ball> balls;
int ballWidth = 48;
float spacing = 20;
float spaceWidth = 150; // width of letter ' '
int fontSize = 200;
float lineSpacing = fontSize*1.5f;
float stepSize = 2;
float danceFactor = 1;
float letterX = 50;
float textW = 50;
float textH;
float letterY = lineSpacing;

PFont pfont;

RFont font;
RGroup grp;
RPoint[] pnts;

FFT fft;
AudioIn in;
int bands = 64;
float[] spectrum = new float[bands];
float w;

float weight_low, weight_mid, weight_hi, weight_whole;
float fader = 245;
float average1 = 0;
float average2 = 0;
float average3 = 0;
float average4 = 0;
float f=0.01f;

float gDir=1;
float addR=2;
float frameC;
float[] partX, partY;
int start, end;



public void setup() {
  in = new AudioIn(this, 0);
  fft = new FFT(this, bands);
  w = width/bands;
  in.start();

  fft.input(in);
  frameRate(60);
   
  blendMode(SCREEN);
  //balls = new ArrayList<Ball>();
  prt = new ArrayList<Particle>();
  // make window resizable
  surface.setResizable(true);  
  
  // GEOMETRIZE allways initialize the library in setup
  RG.init(this);
  //  ------ get the points on the curve's shape  ------
  // set style and segment resolution
  //RCommand.setSegmentStep(5);
  //RCommand.setSegmentator(RCommand.UNIFORMSTEP);
  RCommand.setSegmentLength(5); // 5 = many points; 125 = only a few points 
  RCommand.setSegmentator(RCommand.UNIFORMLENGTH);

  //RCommand.setSegmentAngle(random(0,HALF_PI));
  //RCommand.setSegmentator(RCommand.ADAPTATIVE);
  font = new RFont("OpenSans-Bold.ttf", fontSize, RFont.LEFT);
  grp = font.toGroup("LAWLESS");
  textW = grp.getWidth();
  textH=grp.getHeight();
  pnts = grp.getPoints();
  //look into converting font to shape
  pfont = createFont("OpenSans-Bold.ttf", fontSize);
}
int cDir = 1;

public void draw() {
  background(0);
  fft.analyze(spectrum);
  translate(width/6, height/2+textH/2);
  frameC+=1;
  fader+=cDir;

  if (fader>150||fader<200)
  {
    cDir*=-1;
  }

  start = color(225, 45, fader, 220);
  end = color(20, 100, 255, 45);


  for (int i = 0; i < 9; i++) 
  {

    average1 += spectrum[i];
  }
  average1 = average1/9;
  for (int i = 10; i <19; i++) 
  {

    average2 += spectrum[i];
  }
  average2 = average2/9;
  for (int i = 25; i <41; i++) 
  {
    average3 += spectrum[i];
  }
  average3 = average3/15;
  for (int i = 0; i < bands; i++)
  {
    average4 += spectrum[i];
  }
  average4 = average4/bands;

  weight_low =  (average1*100);
  weight_mid = 0.5f + (average2*100);
  weight_hi = (average3*100);
  weight_whole = (average4*100);
  println("LOW: "+weight_low);
  //println("Mid: "+weight_mid);
  //println("HIGH: "+weight_hi);
  //println("Whole: "+weight_whole);
  if (weight_low>10) {
    gDir*=-1;
  }
  addR= weight_hi*20;
  if (weight_low>15)
  { 
    //balls.add(new Ball(width/2, height/2, ballWidth));
  }

  //float weight = addR+weight_hi*2;
  //for (int i = balls.size()-1; i >= 0; i--) { 
  //    Ball ball = balls.get(i);
  //    ball.move();
  //    ball.display();
  //    if (ball.finished()) {
  //      balls.remove(i);
  //    }
  //  }
  pushMatrix();
  pushStyle();
  noFill();
  textMode(SHAPE);
  textFont(pfont);
  stroke(255, 255, 255, 51);
  //text("LAWLESS",0,0);
  popMatrix();
  popStyle();

  if (mousePressed && mouseButton == RIGHT) {
    //if (plist.size()>5000) {
    background(0);

    while (plist.size() > 0) {
      for (int i = 0; i < plist.size(); i++) {
        plist.remove(i);
      }
    }
  }

  for (int i = 0; i<plist.size(); i++) {
    Particle p = (Particle)plist.get(i); 
    //makes p a particle equivalent to ith particle in ArrayList
    p.run();
    p.update();
    //partX[i]=p.getX();
    //partY[i]=p.getY();
    //when enabled gravity is now throwing a null pointer exception?
    //p.gravity();
    if (p.finished())
    {
      plist.remove(i);
    }
  }
  if (f>1)
  {
    f=0;
  }
  f+=(average4);
  float f3 = map(f, 0, 1, 1, 0);
  if (grp.getWidth() > 0) {
    noStroke(); 
    for (int i=0; i<pnts.length; i++) {
      /*
      how can i take these points (pnts[i].x, pnts[i].y) and use createShape to make a shape from 
       the letters and them move the points or offset them along a sin wave
       or how can I have the points chase eachother or move along the path of the letters, 
       the library I am using is called Geometrize - search its reference
       
       p5.js has better text functions build in such as textToPoint() so maybe redo in p5.js, reference Daniel Shiffman Coding Challenge #59: Steering Behaviors 
       */
      float d;
      int mod = i;
      if (mod%6==0)
      {
        plist.add(new Particle(pnts[mod].x, pnts[mod].y, random(-8, 8)));
      }
      //float d = dist(tx,ty,pnts[i].x,pnts[i].y);
      //println(d);
      //stroke(255);
      //strokeWeight(1);
      //if(d<815){line(tx,ty,pnts[i].x,pnts[i].y);}
      //fill(random(10, 90),random(50, 220),random(200, 255));
      //println(f3+"     " + f);
      float inter = map(pnts[i].x, 0, pnts.length, f, f3);
      int c = lerpColor(start, end, inter);
      fill(c);
      stroke(c);
      //rectMode(CENTER);
      //strokeWeight(weight);
      //make class for drawing rects from pnts[i]
      //rect(pnts[i].x, pnts[i].y,1,addR);
      ellipse(pnts[i].x, pnts[i].y, 0.1f, random(0.5f, 20)+addR);
      //float shapeX,shapeY,shapeR;
    }
  }
}
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
    gravity = 0.1f;
  }
  
    public void move() {
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
    speed = weight_low;
    w += speed;
  }
  
  public boolean finished() {
    // Balls fade out
    //life--;
    if (w >width*2) {
      return true;
    } else {
      return false;
    }
  }
  
  public void display() {
    // Display the circle
    noFill();
    float al = map(average1,0,1,55,255);
    stroke(40,255,172, al);
    strokeWeight(weight_whole*10);
    //stroke(0,life);
    ellipse(x,y,w,w);
  }
}  


class Letter
{
  char let;
  PFont font;
  RFont fs;

  int x;
  int y;

  public Letter( int x, int y)
  {

    this.x = x;
    this.y = y;
  }
  public void display(char let, RFont fs, RGroup gp)
  {
    this.let = let;
    this.fs = fs;
    gp =fs.toGroup(let+"");
    text(let, x, y);
  }
}
class Particle
{
  PVector pos,pos2, speed,speed2, grav;
  int margin = 2;
  float splash = 2;
  float r = random(0.5f,5);
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
     xspeed = random(-0.0f, 0.0f);
    //yspeed = random(-8, 8);
    yspeed=velY;
    pos2 = new PVector(startx,starty);
    pos = new PVector(startx, starty);
    
    //grav = new PVector(0, 0.08);

    tail = new ArrayList();
  }
  public void run()
  {
   
    //if(yspeed
    speed = new PVector(xspeed, yspeed*gDir);
    speed2 = new PVector(yspeed*0.25f,xspeed);
    
    pos.add(speed);
    pos2.add(speed2);
    tail.add(new PVector(pos.x, pos.y, 0));
    if (tail.size() > taillength) {
      tail.remove(0);
    }

    float damping = random(-0.5f, 0.5f);
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

  public boolean finished() {
    // Balls fade out
    
    life-=10;
    if (life < 0) {
      return true;
    } else {
      return false;
    }
  }

  public void gravity()
  {
    speed.add(grav);
    
  }

  public void update()
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
  public float getX(){return pos.x;}
  public float getY(){return pos.y;}
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
  public void settings() {  size(1200, 800);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Lawless_Type" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}

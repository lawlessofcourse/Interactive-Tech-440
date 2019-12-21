import geomerative.*;
import processing.pdf.*;
import java.util.Calendar;
import processing.sound.*;

ArrayList plist = new ArrayList();
int MAX = 10;
ArrayList<Particle> prt;
ArrayList<Ball> balls;
int ballWidth = 48;
float spacing = 20;
float spaceWidth = 150; // width of letter ' '
int fontSize = 200;
float lineSpacing = fontSize*1.5;
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
float f=0.01;

float gDir=1;
float addR=2;
float frameC;
float[] partX, partY;
color start, end;



void setup() {
  in = new AudioIn(this, 0);
  fft = new FFT(this, bands);
  w = width/bands;
  in.start();

  fft.input(in);
  frameRate(60);
  size(1200, 800); 
  blendMode(SCREEN);
  //balls = new ArrayList<Ball>();
  prt = new ArrayList<Particle>();
  // make window resizable
  surface.setResizable(true);  
  smooth();
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

void draw() {
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
  weight_mid = 0.5 + (average2*100);
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
      color c = lerpColor(start, end, inter);
      fill(c);
      stroke(c);
      //rectMode(CENTER);
      //strokeWeight(weight);
      //make class for drawing rects from pnts[i]
      //rect(pnts[i].x, pnts[i].y,1,addR);
      ellipse(pnts[i].x, pnts[i].y, 0.1, random(0.5, 20)+addR);
      //float shapeX,shapeY,shapeR;
    }
  }
}

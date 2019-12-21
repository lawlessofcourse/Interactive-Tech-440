import geomerative.*;
import processing.pdf.*;
import java.util.Calendar;
import processing.sound.*;

ArrayList plist = new ArrayList();
int MAX = 10;

ArrayList<Particle> prt;
ArrayList<Ball> balls;
color[] colorPal = {#F23827, #050259, #6204BF, #7C05F2, #F205CB};
color darkPurp = color(5, 2, 40, 255);
color midPurp = color(98, 4, 191, 200);
color redH = color(242, 56, 39, 100);
color lightPurp = color(124, 5, 242, 100);
color hotP = color(242, 5, 203, 100);

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


RFont font;
RGroup grp;
RPoint[] pnts;

FFT fft;
AudioIn in;
int bands = 64;
float[] spectrum = new float[bands];
float w;

//Global values
float weight_low, weight_mid, weight_hi, weight_whole;
float fader = 245;
float average1 = 0;
float average2 = 0;
float average3 = 0;
float average4 = 0;

float f=0.01;
int cDir = 1;
float gDir=1;
float addR=2;
float frameC;
float[] partX, partY;
color start, end;
int bassCount=0;
void setup() {
  in = new AudioIn(this, 0);
  fft = new FFT(this, bands);
  w = width/bands;
  in.start();

  fft.input(in);
  frameRate(60);
  size(1280, 720); 

  balls = new ArrayList<Ball>();
  prt = new ArrayList<Particle>();

  // make window resizable
  surface.setResizable(true);  
  smooth();
  // GEOMETRIZE allways initialize the library in setup
  RG.init(this);
  //  ------ get the points on the curve's shape  ------
  RCommand.setSegmentLength(5); // 5 = many points; 125 = only a few points 
  RCommand.setSegmentator(RCommand.UNIFORMLENGTH);

  font = new RFont("OpenSans-Bold.ttf", fontSize, RFont.LEFT);
  grp = font.toGroup("LAWLESS");
  textW = grp.getWidth();
  textH=grp.getHeight();
  pnts = grp.getPoints();
}


void draw() {
  background(darkPurp);
  fft.analyze(spectrum);

  start = color(225, 45, 255, 220);
  end = color(20, 200, 255, 45);

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
  //println("LOW: "+weight_low);
  //println("Mid: "+weight_mid);
  //println("HIGH: "+weight_hi);
  //println("Whole: "+weight_whole);

  if (weight_low>8) {
    bassCount+=1;
  }
  if(bassCount%3==0)
  {
    gDir*=-1;
  }
  println(bassCount);
  addR= weight_hi*20;

  pushMatrix();
  translate(width/6, height/2+textH/2);
  blendMode(SCREEN);
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
    if (p.finished())
    {
      plist.remove(i);
    }
  }
  
  //Move gradient back and forth along text according to whole average of spectrum
  if (f>1||f<0)
  {
    cDir*=-1;
  }
  f+=(average4*cDir);
  float f3 = map(f, 0, 1, 1, 0);
  //println(f+" "+f3);
  
  //Draw points on text path
  if (grp.getWidth() > 0) {
    noStroke(); 
    for (int i=0; i<pnts.length; i++) {
       //Add particle spawn point on every sixth index of the ArrayList
      int mod = i;
      if (mod%6==0)
      {
        plist.add(new Particle(pnts[mod].x, pnts[mod].y, random(-8, 8)));
      }
      float inter = map(pnts[i].x, 0, pnts.length, f, f3);
      color g2 =lerpColor(lightPurp, redH, inter);
      fill(g2);
      stroke(g2);
      ellipse(pnts[i].x, pnts[i].y, 0.1, random(0.5, 20)+addR);
    }
  }
    popMatrix();
      /*
      how can i take these points (pnts[i].x, pnts[i].y) and use createShape to make a shape from 
       the letters and them move the points or offset them along a sin wave
       or how can I have the points chase eachother or move along the path of the letters, 
       the library I am using is called Geometrize - search its reference
       
       p5.js has better text functions build in such as textToPoint() so maybe redo in p5.js, reference Daniel Shiffman Coding Challenge #59: Steering Behaviors 
       */

  
  pushMatrix();
  blendMode(BLEND);
  //Draw expanding circles
  //Think about doing switch case so on every other (or so) beat it draws a different shape
  for (int i = balls.size()-1; i >= 0; i--) { 
    Ball ball = balls.get(i);
    ball.move();
    ball.display();
    if (ball.finished()) {
      balls.remove(i);
    }
  }
  //AUDIO REACTION, on low hit draw mask expanding circle, and reverse direction of particles with gDir
  if (weight_low>9)
  { 
    balls.add(new Ball(random(pnts[0].x, width-pnts[0].x), height/2, ballWidth));
    
  }
  popMatrix();
}

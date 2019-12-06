import processing.sound.*;

ArrayList<Line> lines;
int lineWidth = 0;
color whi;
color b;
float life = 255;

ArrayList<Tri> triangles;

ArrayList<Ball> balls;
int ballWidth = 48;

FFT fft;
AudioIn in;
int bands = 64;
float[] spectrum = new float[bands];
float w;

float weight_low;
float weight_mid;
float weight_hi;
float weight_whole;

float average1 = 0;
float average2 = 0;
float average3 = 0;
float average4 = 0;
void setup()
{
 
  in = new AudioIn(this, 0);
  fft = new FFT(this, bands);
  w = width/bands;
  in.start();

  fft.input(in);
  size(1280, 720);
  noStroke();
  whi = color(172, 255, 40);
  b = color(0, 0, 0);
  lines = new ArrayList<Line>();

  triangles = new ArrayList<Tri>();
  
  balls = new ArrayList<Ball>();
}

void draw()
{  
  background(0);
  fft.analyze(spectrum);
  //Spectrum Averages
  for (int i = 0; i < 9; i++) 
  {
    average1 += spectrum[i];
  }
  average1 = average1/9;
  for (int i = 10; i <18; i++) 
  {
    average2 += spectrum[i];
  }
  average2 = average2/9;
  for (int i = 20; i <41; i++) 
  {
    average3 += spectrum[i];
  }
  average3 = average3/20;
  for(int i = 0; i < bands; i++)
  {
    average4 += spectrum[i];
  }
  average4 = average4/bands;
  
  //Weighted Averages for control
  weight_low = 0.5+ (average1*100);
  weight_mid = 0.5 + (average2*100);
  weight_hi = 0.5+(average3*100);
  weight_whole = (average4*100);

  //Import/Draw classes
  for (int i = lines.size()-1; i >= 0; i--) { 
    Line line = lines.get(i);
    line.move();
    line.display();
    if (line.finished()) {
      lines.remove(i);
    }
  }

  for (int i = triangles.size()-1; i >= 0; i--) { 
    Tri newTri = triangles.get(i);
    newTri.move(5);
    newTri.display();
    if (newTri.finished()) {
      triangles.remove(i);
    }
  }

  for (int i = balls.size()-1; i >= 0; i--) { 
    Ball ball = balls.get(i);
    ball.move();
    ball.display();
    if (ball.finished()) {
      balls.remove(i);
    }
  }
  
  //Draw based on Averages of spectrum
  if(weight_mid>5)
  {
    //strokeWeight(0.5);
    //lines.add(new Line(random(0,width), height/2, lineWidth));
  }

  if(weight_hi>4.2)
  {
    triangles.add(new Tri(width/3, height/2));
    triangles.add(new Tri(width*2/3, height/2));
  }
    if (weight_low>20)
  { 
    balls.add(new Ball(width/2,height/2, ballWidth));
  }
}


void mousePressed() {
  
//lines.add(new Line(random(0,width), height/2, lineWidth));
}

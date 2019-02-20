import processing.sound.*;
import themidibus.*;

MidiBus myBus;
 
Circle[] circles = new Circle[1000];
Circle[] circles2 = new Circle[1000];

int onsetCounter=0;
FFT fft;
AudioIn in;
int bands = 64;
float[] spectrum = new float[bands];
float w;

float cc[] = new float[256];
float bc[] = new float[256];

boolean toggle = false;
int count;

//WAVE VARIABLES
float freq = 10;
float amp = 80;
float w2 = 20;
float h = 20;

//GEOMETRY VARIABLES
float t;
float angle2 = 0;
int NUM_LINES = 500;
float v1 =0.4;
float v2;
boolean increment = false;
float fator =0.00001;
//fft averages
float average1 = 0;
float average2 = 0;  
//FLOWFIELD VARIABLES
float xoff, yoff, zoff, inc, col;
int rez, cols, rows, num;
PVector[] vectors;
ArrayList<Particle> particles;
ArrayList<Particle> particles_b;
void setup() {
  size(1080, 720);
  //fullScreen();
  colorMode(HSB);
  MidiBus.list();
  myBus = new MidiBus(this, 0, 3);
  // Create an Input stream which is routed into the Amplitude analyzer
  fft = new FFT(this, bands);
  in = new AudioIn(this, 0);
  w = width/bands;
  // start the Audio Input
  in.start();

  // patch the AudioIn
  fft.input(in);
  for (int i = 0; i < circles.length; i++) {
    circles[i] = new Circle();
    circles2[i] = new Circle();
  }
  init();
}      
void init() {
  background(0);
  rez = 10;
  inc = 0.1;
  num = 10000;
  col = random(255);
  cols = floor(width / rez) + 1;
  rows = floor(height / rez) + 1;
  vectors = new PVector[cols * rows];
  particles = new ArrayList<Particle>();
  particles_b = new ArrayList<Particle>();
  for (int i=0; i<num; i++)
    particles.add(new Particle());
     particles_b.add(new Particle());
}
void draw() { 
  background(cc[49]*360,cc[50]*360,cc[51]*360 );

  yoff = 0;
  for (int y=0; y<rows; y++) {
    xoff = 0;
    for (int x=0; x<cols; x++) {
      float angle = noise(xoff, yoff, zoff) * TWO_PI * 5;
      PVector v = PVector.fromAngle(angle);
      v.setMag(1);
      vectors[x + y * cols] = v;
      xoff += inc;
    }
    yoff += inc;
  }
  zoff += 0.005;
  if (col < 255)col += 0.1;
  else col = 0;
  for (Particle p : particles)p.run();

  ////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////
  //DRAW CIRCLES
  float xx = random(-width, width);
  float yy = random(-height, height);
  for (int i =0; i<onsetCounter; i++)
  {
    pushMatrix();
    circles[i].move(200);
    circles[i].show(xx,yy,i, 255, 255, 50);
    popMatrix();
    pushMatrix();
    translate(width/2, height/2);
    circles2[i].move(2000);
    circles2[i].show(0,0, i, cc[50]*360, 255, cc[29]*360);
    popMatrix();
  }
  ////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////
  //DRAW FFT SPECTRUM HALF CIRCLE AND BAR SCALE
 
  fft.analyze(spectrum);
  for (int i = 0; i < bands; i++) {
    pushMatrix();
    translate(width/2, height/2);
    // The result of the FFT is normalized
    // draw the line for frequency band i scaling it up by 5 to get more amplitude.
    float angle = map(i, 0, spectrum.length, 0, -PI);
    float r = map(spectrum[i], 0, 1, 100, width);
    float vert = map(spectrum[i], 0, 1, 1, height*4);
    float x = r*cos(angle);
    float y = r*sin(angle);
    stroke(i, 255, 255);
    //line(0, 0, x, y);
    popMatrix();

    fill(i, 255, 255);
    //rect( i*w, height-vert, w, vert );
    //rect( i*w, y, w, height-y );
    //println(average(spectrum[i], 3));
  }
  ////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////
  //TAKE AVERAGE OF FIRST 4 BANDS//MAKE THIS INTO A FUNCTION THAT RETURNS VALUE?

  for (int i = 0; i < 3; i++) {
    average1 += spectrum[i]*100;
  }
  average1 = average1/3;
  
  for (int i = 0; i <5; i++) {
    average2 += spectrum[i]*100;
  }
  average2 = average2/5;
  //println(average2);
  ////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////
  //IF AVERAGE IS ABOVE TWO DRAW NEW CIRCLE
  if (average1>2) {
   if(onsetCounter<25){
    onsetCounter=onsetCounter+1;
    }else{onsetCounter=0;}
    v1 = random(0.4)+0.2;
  } else {
    increment = false;
  }
  ////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////

if(toggle == true){
  pushMatrix();
  pushStyle();
  noStroke();
  colorMode(RGB);
  translate(0, height/2);
  amp = average2*100;
  fill(0, 0, 50, 40);
  //rect(0, 0, width, height);

  for (int i = 0; i < width; i++) {
    // Middle blue
    //fill(220, 255, 255, 0);
    //rect(i*20, sin((frameCount+i*3)/freq)*(amp*1), w2, h, 0);

    for (int x = 1; x < 16; x++) {
      // Top blue
      fill(230-(x*40), 255, 255, cc[77]*255-(x*32));
      rect(i*20, ((x*20)) + sin((frameCount+i*3)/freq) * (amp*(1-(x*0.13))), w2*(1-(x*0.075)), h*(1-(x*0.075)), 75-(x*3.5));

      // Bottom blue
      fill(230-(x*40), 255, 255, cc[77]*255-(x*32));
      rect(i*20, ((x*20)) + sin((frameCount+i*3)/freq) * (amp*(1-(x*0.13))), w2*(1-(x*0.075)), h*(1-(x*0.075)), 75-(x*3.5));

      // Top purple
      fill(255, 230-(x*20), 255, cc[77]*15);
      rect(i*20+10, ((x*20)) + cos((frameCount+i*3)/freq) * (amp*(1-(x*0.13))), w2*(1-(x*0.125)), h*(1-(x*0.125)), 75-(x*3.5));

      // Bottom purple
      fill(255, 200-(x*20), 255, cc[77]*15);
      rect(i*20+10, ((x*20)) + cos((frameCount+i*3)/freq) * (amp*(1-(x*0.13))), w2*(1-(x*0.125)), h*(1-(x*0.125)), 75-(x*3.5));
    }
  }
  popStyle();
  popMatrix();
}else{}
  ////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////
  pushMatrix();
  pushStyle();
  angle2 += cc[14]/100;
  //stroke(25, 150, 190, cc[78]*256);
 
  translate(width/2, height/2);
  //float grow = map(average2, 0 ,1, 1.0, 1.2);
   scale(cc[13]*4);
  rotate(TWO_PI*angle2);
  for (int i=1; i < NUM_LINES; i++) {
    stroke(cc[49]*360,cc[79]*360,cc[80]*360);
    strokeWeight(3);
    point(x(t+i), y(t+i));
    point(x2(t+i), y2(t+i));
    strokeWeight(1);
    line(x(t+i), y(t+i), x2(t+i), y2(t+i));
  }
  t += 0.005;
  if (increment)    v1+=fator;

  popStyle();
  popMatrix();
  noise();
  ////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////
}
void mousePressed()
{
  background(255);
  init();
}



float x(float t) {
  return sin(t/10)*100 + cos(t/v1)*100;
}

float y(float t) {
  return cos(t/10)*100 + sin(t/v1)*100;
}

float x2(float t) {
  return sin(t/10)*10 + cos(t/v1)*100;
}

float y2(float t) {
  return cos(t/10)*10 + sin(t/v1)*100;
}


static double average(float a[], int n) {

  float sum = 0;
  for (int f = 0; f < n; f++)

    sum += a[f];
  //println(sum/n);
  return sum/n;
}
void noise() {
  noStroke();
  strokeWeight(1);
  for (int i = -width; i < width - 1; i += 5) {
    for (int j = -height; j < height - 1; j += 5) {
      fill(random(0, 255), random(30, 50));
      rect(random(i - 5, i), random(j - 5, j), 1, 1);
    }
  }
  for (int i = 0; i < 5; i++) {
    fill(random(0, 255), 255);
    rect(random(0, width), random(0, height), 2, 2);
  }
}
void controllerChange(int channel, int number, int value)
{
  println(number);
  println(value);
  cc[number] = map(value, 0, 127, 0, 1);
}
void noteOn(int channel, int pitch, int velocity) {
  // Receive a noteOn
  println();
  println("Note On:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
  bc[pitch] = map(velocity, 0, 127, 0, 1);
  
  count = count +1;
  count = count%2;
  println(count);
  if(count == 1&&pitch == 41){
    toggle = true;
  }else if(count == 0){
    toggle = false;
  }
}

void noteOff(int channel, int pitch, int velocity) {
  // Receive a noteOff
  println();
  println("Note Off:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);

  
}

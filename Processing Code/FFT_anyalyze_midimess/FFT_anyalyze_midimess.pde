import processing.sound.*;
import themidibus.*;

MidiBus myBus;



int onsetCounter=0;
FFT fft;
AudioIn in;
int bands = 64;
float[] spectrum = new float[bands];
float w;

float cc[] = new float[256];
float bc[] = new float[256];

boolean toggle = false;
boolean toggle2 = false;
boolean toggle3 = false;
boolean toggle4 = false;
int count;
int value; 
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
//EXPANDING CIRCLE VARS
ArrayList<Ball> balls;
int ballWidth = 48;

void setup() {
  size(1080, 720);
  //fullScreen();
  colorMode(HSB);
  MidiBus.list();
  myBus = new MidiBus(this, 0, 1);
  // Create an Input stream which is routed into the Amplitude analyzer
  fft = new FFT(this, bands);
  in = new AudioIn(this, 0);
  w = width/bands;
  // start the Audio Input
  in.start();

  // patch the AudioIn
  fft.input(in);

  init();
  // Create an empty ArrayList (will store Ball objects)
  balls = new ArrayList<Ball>();

  // Start by adding one element
  balls.add(new Ball(width/2, height/2, ballWidth));
}  

void init() 
{
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

void draw()
{ 
  background(cc[49]*360, cc[50]*360, cc[51]*360 );
  ////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////
  //DRAW FFT SPECTRUM HALF CIRCLE AND BAR SCALE

  fft.analyze(spectrum);
  //for (int i = 0; i < bands; i++) {
  //  pushMatrix();
  //  //translate(width/2, height/2);
  //  // The result of the FFT is normalized
  //  // draw the line for frequency band i scaling it up by 5 to get more amplitude.
  //  float angle = map(i, 0, spectrum.length, 0, -PI);
  //  float r = map(spectrum[i], 0, 1, 100, width);
  //  float vert = map(spectrum[i], 0, 1, 1, height*4);
  //  float x = r*cos(angle);
  //  float y = r*sin(angle);
  //  stroke(i, 255, 255);
  //  //line(0, 0, x, y);
  //  popMatrix();

  //  fill(i, 255, 255);
  //  //rect( i*w, height-vert, w, vert );
  //  //rect( i*w, y, w, height-y );
  //  //println(average(spectrum[i], 3));
  //}
  ////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////
  //TAKE AVERAGE OF FIRST 4 BANDS//MAKE THIS INTO A FUNCTION THAT RETURNS VALUE?

  for (int i = 0; i < 3; i++) {
    average1 += spectrum[i];
  }
  average1 = average1/3;
  //println(average1);
  for (int i = 0; i <5; i++) {
    average2 += spectrum[i];
  }
  average2 = average2/5;
  //println(average2);
  //IF AVERAGE IS ABOVE TWO DRAW NEW CIRCLE
  if (average1>2) {
    balls.add(new Ball(random(-width, width), random(-height, height), ballWidth));
    v1 = random(0.4)+0.2;
  } else {
    increment = false;
  }
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
//TOGGLE STATEMENTS FOR MIDI CONTROL
  if (toggle == true) {
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
  } 
  if (toggle2 == true) 
  {
    for (int i = balls.size()-1; i >= 0; i--) { 
      // An ArrayList doesn't know what it is storing so we have to cast the object coming out
      Ball ball = balls.get(i);
      ball.move();
      ball.display();
      if (ball.finished()) {
        // Items can be deleted with remove()
        balls.remove(i);
      }
    }
  } 

  if (toggle3 == true) 
  {
    pushMatrix();
    pushStyle();
    angle2 += cc[14]/100;
    //stroke(25, 150, 190, cc[78]*256);

    translate(width/2, height/2);
    //float grow = map(average2, 0 ,1, 1.0, 1.2);
    scale(cc[13]*4);
    rotate(TWO_PI*angle2);
    for (int i=1; i < NUM_LINES; i++) {
      stroke(cc[49]*360, cc[79]*360, cc[80]*360);
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
  } 
  if (toggle4 == true) {
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
  }
  ////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////

  noise();
  ////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////

  ////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////
}
void mousePressed()
{
  //background(255);
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
  if (pitch == 41) {
    toggle = true;
  } else if (pitch == 42) {
    toggle2 = true;
  } else if (pitch == 43) {
    toggle3 = true;
  } else if ( pitch == 44) {
    toggle4 = true;
  } else if (pitch == 73) {
    toggle = false;
  } else if (pitch == 74) {
    toggle2 = false;
  } else if (pitch == 75) {
    toggle3 = false;
  } else if (pitch == 76) {
    toggle4 = false;
  } else {
    toggle = false;
    toggle2 = false;
    toggle3 = false;
    toggle4 = false;
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

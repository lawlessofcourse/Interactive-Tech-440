import processing.sound.*;
//import themidibus.*;

//MidiBus myBus;
FFT fft;
AudioIn in;

int bands = 64;
float[] spectrum = new float[bands];
float w;
float w2;

float average1 = 0;
float average2 = 0;
float average3 = 0;
float wholeAvg = 0;

float weight_low;
float weight_mid;
float weight_hi;
float weight_whole;

ArrayList<Line> lines;
int lineWidth = 0;
color whi;
color b;

void setup() {
  size(1280, 720);
  //fullScreen();
  //colorMode(HSB);
    //size(1280, 720);
  noStroke();
  whi = color(255, 255, 255);
  b = color(0, 0, 0);
  lines = new ArrayList<Line>();
  // Create an Input stream which is routed into the Amplitude analyzer
  fft = new FFT(this, bands);
  in = new AudioIn(this, 0);
  w = width/64;
  w2= width/8;
  // start the Audio Input
  in.start();
  // patch the AudioIn
  fft.input(in);
}      

void draw() { 
  background(0);
  ////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////
  //DRAW FFT SPECTRUM HALF CIRCLE AND BAR SCALE

  fft.analyze(spectrum);

  //WORK//
  //ANALYZE BANDS//
  for (int i = 41; i < 48; i++) {
    average1 += spectrum[i];
  }
  average1 = average1/7;

  for (int i = 0; i <2; i++) {
    average2 += spectrum[i];
  }
  average2 = average2/2;

  for (int i = 14; i <17; i++) {
    average3 += spectrum[i];
  }
  average3 = average3/4;
  for(int i =9; i<13;i++)
  {
    wholeAvg += spectrum[i];
  }
  wholeAvg = wholeAvg/4;
  //Create weighted averages
  weight_low = 0.5+ (average2*30);
  weight_hi = 0.5 + (average1*100);
  weight_mid = 0.5+(average3*200);
  weight_whole = 0.5+(wholeAvg*1000);
   println(weight_whole);
   
  //Draw Lines 
   for (int i = lines.size()-1; i >= 0; i--) { 
    Line line = lines.get(i);
    line.move();
    line.display();
    if (line.finished()) {
      // Items can be deleted with remove()
      lines.remove(i);
    }
  }
  //add line on pluck
  if(weight_whole>9)
  {
    lines.add(new Line(random(0,width), 0,lineWidth));
  }
  
  
  
  
 // FFT SPECTRUM DISPLAY
  //for (int i = 0; i < bands; i++) {
  //  pushMatrix();
  //  translate(width/2, height/2);
  //  // The result of the FFT is normalized
  //  // draw the line for frequency band i scaling it up by 5 to get more amplitude.
  //  float angle = map(i, 0, spectrum.length, 0, -PI);
  //  float r = map(spectrum[i], 0, 1, 100, width);
  //  float vert = map(spectrum[i], 0, 1, 1, height*20);
  //  float x = r*cos(angle);
  //  float y = r*sin(angle);
  //  stroke(i, 255, 255);
  //  line(0, 0, x, y);
  //  popMatrix();

  //  pushStyle();
  //  fill(i, 255, 255);
  //  rect( i*w, height-vert, w-2, vert );
  //  popStyle();
  //  pushStyle();
  //  stroke(255);
  //  fill(255, 255, 255, 25);
  //  rect( i*(w*8), 0, w, height);
  //  popStyle();

  //  //println(average(spectrum[i], 3));
  //}
  //for (int i = 0; i < bands/8; i++) {
  //  pushStyle();
  //  colorMode(RGB);

  //  fill(255, 255, 255, 25);
  //  //rect(i*w2, 0, w2, height);
  //  //rect(w*8, 0, w*8, height);
  //  popStyle();
  //}
}

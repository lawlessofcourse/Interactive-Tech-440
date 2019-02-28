import processing.sound.*;
import themidibus.*;

MidiBus myBus;


FFT fft;
AudioIn in;
int bands = 64;
float[] spectrum = new float[bands];
float w;
float w2;


void setup() {

  size(1080, 720);
  //fullScreen();
  colorMode(HSB);
  MidiBus.list();
  myBus = new MidiBus(this, 2, 3);
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
    line(0, 0, x, y);
    popMatrix();
pushStyle();
    fill(i, 255, 255);
    rect( i*w, height-vert, w-2, vert );
    popStyle();
    pushStyle();
    stroke(255);
    fill(255,255,255,25);
    rect( i*(w*8), 0, w, height);
       popStyle();
      
    //println(average(spectrum[i], 3));
  }
  for(int i = 0; i < bands/8; i++){
    pushStyle();
    colorMode(RGB);
    
    fill(255, 255, 255, 25);
    //rect(i*w2, 0, w2, height);
    //rect(w*8, 0, w*8, height);
    popStyle();
  }


}

import processing.sound.*;



FFT fft;
AudioIn in;
int bands = 64;
float[] spectrum = new float[bands];
float w;
void setup() {
  size(1080, 720);
  background(255);
  colorMode(HSB);
  // Create an Input stream which is routed into the Amplitude analyzer
  fft = new FFT(this, bands);
  in = new AudioIn(this, 0);
  w = width/bands;
  // start the Audio Input
  in.start();
  
  // patch the AudioIn
  fft.input(in);
}      

void draw() { 
  background(255);
  fft.analyze(spectrum);
  
  for(int i = 0; i < bands; i++){
  // The result of the FFT is normalized
  // draw the line for frequency band i scaling it up by 5 to get more amplitude.
  
  float y = height-spectrum[i]*height*10;
  float amp = spectrum[i];
  float y2 = map(amp, 0 , 1, height, 0);
  println(spectrum[6]);
  //float ys= map(amp, 0 , 10, height, 0);
 // println(ys);
  //println(y);
 // println(spectrum.length);
  //println(spectrum[i]);
  //println(spectrum);
  //println("y"+y);
  fill(i, 255, 255);
  rect( i*w, y2, w, height-y2 );
  //rect( i*w, y, w, height-y );
  
  } 
}

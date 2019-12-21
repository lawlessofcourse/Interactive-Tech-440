import processing.sound.*;
//import spout.*;
//Spout spout;
FFT fft;
AudioIn in;

String senderName;

float cc[] = new float[256];

int nums =200;
float noiseScale = 1000;

int bands = 64;
float[] spectrum = new float[bands];
float w;
float w2;
float average1;
float average2;
float average3;
float colorCounter = 0;
float  weight_low;
float weight_hi;
float  weight_mid;

Particle[] particles_a = new Particle[nums];
Particle[] particles_b = new Particle[nums];
Particle[] particles_c = new Particle[nums];

void setup() {
  size(1920, 1080, P3D);
  colorMode(HSB);
  background(0);

  textureMode(NORMAL);
  //spout =  new Spout(this);
  //senderName = "PERLIN SCALE1";
  //spout.createSender(senderName, width, height);
  fft = new FFT(this, bands);
  in = new AudioIn(this, 0);
  w = width/64;
  w2= width/8;
  // start the Audio Input
  in.start();

  // patch the AudioIn
  fft.input(in);

  for (int i = 0; i < nums; i++) {
    particles_a[i] = new Particle(random(0, width), random(0, height));
    particles_b[i] = new Particle(random(0, width), random(0, height));
    particles_c[i] = new Particle(random(0, width), random(0, height));
  }
}

void draw() {
  fft.analyze(spectrum);
  for (int i = 41; i < 48; i++) {
    average1 += spectrum[i];
  }
  average1 = average1/7;

  for (int i = 0; i <6; i++) {
    average2 += spectrum[i];
  }
  average2 = average2/5;
  for (int i = 16; i <20; i++) {
    average3 += spectrum[i];
  }
  average3 = average3/5;
  if (average2>0.05)
  {
    //println(average2);
    //lines.add(new Line());
  }
  weight_low = 0.5+ (average2*30);
  weight_hi = 0.5 + (average1*100);
  weight_mid = 0.5+(average3*200);
    if (spectrum[0]>0.3) {
    //println(spectrum[0]);
    if (colorCounter > 300) {
      colorCounter = floor(random(1, 300));
    }
    colorCounter +=5;
  }
  noStroke();
  smooth();
  for (int i = 0; i < nums; i++) {
    float radius = map(i, 0, nums, 1, 2);
    float alpha = map(i, 0, nums, 0, 250);

    fill(colorCounter+69, 200, 124, alpha);
    particles_a[i].move();
    particles_a[i].show(radius);
    particles_a[i].checkEdge();

    fill(colorCounter+7, 153, 242, alpha);
    particles_b[i].move();
    particles_b[i].show(radius);
    particles_b[i].checkEdge();

    fill(colorCounter, 255, 255, alpha);
    particles_c[i].move();
    particles_c[i].show(radius);
    particles_c[i].checkEdge();
  }
  //spout.sendTexture();
}

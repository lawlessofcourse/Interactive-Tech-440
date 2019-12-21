import processing.sound.*;
//import spout.*;
//Spout spout;

ArrayList<Line> lines;
ArrayList<Tri> triangles;

FFT fft;
AudioIn in;
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

String senderName;

void setup() {

  size(1920 , 1080, P3D);
  //fullScreen();
  textureMode(NORMAL);
  //spout =  new Spout(this);
  senderName = "Spout Processing Projection";
  //spout.createSender(senderName, width, height);
  
  colorMode(HSB);
  // Create an Input stream which is routed into the Amplitude analyzer
  fft = new FFT(this, bands);
  in = new AudioIn(this, 0);
  w = width/64;
  w2= width/8;
  // start the Audio Input
  in.start();

  // patch the AudioIn
  fft.input(in);

  lines = new ArrayList<Line>();
  lines.add(new Line());
  triangles = new ArrayList<Tri>();

  // Start by adding one element
  triangles.add(new Tri(width/2, height/2));
}      

void draw() { 
  background(0, 0,0,0);
  fft.analyze(spectrum);
  for (int i = lines.size()-1; i >=0; i--) {
    Line newLine = lines.get(i);
    newLine.move(15);
    newLine.display();
    if (newLine.finished()) {
      lines.remove(i);
    }
  }
  for (int i = triangles.size()-1; i >= 0; i--) { 
    // An ArrayList doesn't know what it is storing so we have to cast the object coming out
    Tri newTri = triangles.get(i);
    newTri.move(15);
    newTri.display();
    if (newTri.finished()) {
      // Items can be deleted with remove()
      triangles.remove(i);
    }
  }
  ////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////
  //DRAW FFT SPECTRUM HALF CIRCLE AND BAR SCALE
  
  //for (int i = 0; i < bands; i++) {
  //  pushMatrix();
  //  translate(width/2, height/2);
  //  // The result of the FFT is normalized
  //  // draw the line for frequency band i scaling it up by 5 to get more amplitude.
  //  float angle = map(i, 0, spectrum.length, 0, -PI);
  //  float r = map(spectrum[i], 0, 1, 100, width);
  //  float vert = map(spectrum[i], 0, 1, 1, height*4);
  //  float x = r*cos(angle);
  //  float y = r*sin(angle);
  //  //stroke(i, 255, 255);
  //  line(0, 0, x, y);
  //  popMatrix();
  //  pushStyle();
  //  fill(i, 255, 255);
  //  rect( i*w, height-vert, w-2, vert );
  //  popStyle();
  //  pushStyle();
  //  stroke(255);
  //  fill(255, 255, 255, 25);
  //  //rect( i*(w*8), 0, w, height);
  //  popStyle();

  //////  //println(average(spectrum[i], 3));
  //}
  for (int i = 0; i < bands/8; i++) {
    pushStyle();
    colorMode(RGB);

    fill(255, 255, 255, 25);
    //rect(i*w2, 0, w2, height);
    //rect(w*8, 0, w*8, height);
    popStyle();
  }

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
  
  
  pushMatrix();
  blendMode(DIFFERENCE);
  noStroke();
  fill(colorCounter+60, 255, 55);
  float vert2 = map(average2, 0, 1, 1, height*10);
  rect(0, height+200, width, -vert2  );
  popMatrix();
  pushMatrix();
  blendMode(ADD);
  if (average1>0.005) {
    //println(average1);
    strokeWeight(weight_mid);
    triangles.add(new Tri(width/2, height/2));
  }
  popMatrix();
  if (spectrum[0]>0.3) {
    //println(spectrum[0]);
    lines.add(new Line());
    if (colorCounter > 300) {
      colorCounter = floor(random(1, 300));
    }
    colorCounter +=5;
  }
  //spout.sendTexture();
}
//void mousePressed() {
//  // A new ball object is added to the ArrayList (by default to the end)
//  lines.add(new Line());
//}

import themidibus.*;

// The Chaos Game
// Daniel Shiffman
// Part 1: https://youtu.be/7gNzMtYo9n4
// https://thecodingtrain.com/CodingChallenges/123.1-chaos-game
// Part 2: https://youtu.be/A0NHGTggoOQ
// https://thecodingtrain.com/CodingChallenges/123.2-chaos-game
MidiBus myBus;

float ax, ay;
float bx, by;
float cx, cy;
float dx, dy;
float x, y;


void setup() {
  //fullScreen();
  MidiBus.list();
  myBus = new MidiBus(this, 0,1);
  ax = 0;
  ay = 0;
  bx = 0;
  by = height;
  cx = width;
  cy = height;
  dx = width; 
  dy = 0;
  x = random(width);
  y = random(height);
  //background(0);
  stroke(255);
  strokeWeight(8);
  point(ax, ay);
  point(bx, by);
  point(cx, cy);
  point(dx, dy);
}

void draw() {
  background(0);
  int channel = 0;
  int pitch = 64;
  int velocity = 127;

  myBus.sendNoteOn(channel, pitch, velocity); // Send a Midi noteOn
  delay(200);
  myBus.sendNoteOff(channel, pitch, velocity); // Send a Midi nodeOff

  int number = 0;
  int value = 90;

  myBus.sendControllerChange(channel, number, value); // Send a controllerChange
  delay(2000);
  float prob = myBus.sendControllerChange(0, 41, 10);
  for (int i = 0; i < 100; i++) {
    strokeWeight(2);
    point(x, y);
    int r = floor(random(4));
    if (r == 0) {
      stroke(255, 0, 255);
      x = lerp(x, ax, prob);
      y = lerp(y, ay, prob);

    } else if (r == 1) {
      stroke(0, 255, 255);
      x = lerp(x, bx, prob);
      y = lerp(y, by, prob);
    } else if (r == 2) {
      stroke(255, 255, 0);
      x = lerp(x, cx, prob);
      y = lerp(y, cy, prob);
    }else if(r == 3){
      stroke(255,255,255);
      x=lerp(x, dx, prob);
      y=lerp(y,dy,prob);
    }
  }
}

void noteOn(int channel, int pitch, int velocity) {
  // Receive a noteOn
  println();
  println("Note On:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
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

void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
  println();
  println("Controller Change:");
  println("--------");
  println("Channel:"+channel);
  println("Number:"+number);
  println("Value:"+value);
}

void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}

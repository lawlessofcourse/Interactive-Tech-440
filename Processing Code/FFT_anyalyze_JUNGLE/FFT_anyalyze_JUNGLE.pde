import processing.sound.*;
import themidibus.*;
import processing.video.*;

Movie forestVid;
SoundFile file;
MidiBus myBus;

int onsetCounter=0;
FFT fft;
//AudioIn in;
int bands = 64;
float[] spectrum = new float[bands];
float w;

float cc[] = new float[256];
float bc[] = new float[256];

boolean toggle = false;
boolean toggle2 = false;
boolean toggle3 = false;
boolean toggle4 = false;
boolean toggle5 = false;
int count;
int value;
float colorCounter = 0;


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
float average3 = 0;

//EXPANDING CIRCLE VARS
ArrayList<Ball> balls;
int ballWidth = 48;
//EXPANDING TRI VARS
ArrayList<Tri> triangles;
ArrayList<Tri> triangles_b;
ArrayList<Diamond> diamond;
float weight_low;
float weight_mid;
float weight_hi;

void setup() {
  frameRate(30);
  size(1920, 1080);
  //fullScreen();
  colorMode(HSB);
  MidiBus.list();


  file = new SoundFile(this, "Jungle_War.wav");
  myBus = new MidiBus(this, 2, 3);
  // Create an Input stream which is routed into the Amplitude analyzer
  fft = new FFT(this, bands);
  w = width/bands;
  file.play();
  fft.input(file);

  forestVid = new Movie(this, "Forest_edit.mp4");
  //forestVid.speed(2.0);
  // Create an empty ArrayList (will store Ball objects)
  balls = new ArrayList<Ball>();
  balls.add(new Ball(width/2, height/2));
  // Create an empty ArrayList (will store Tri objects)
  triangles = new ArrayList<Tri>();
  triangles.add(new Tri(width/2, height/2, 1, 1, colorCounter, 2));
  triangles_b = new ArrayList<Tri>();
  triangles_b.add(new Tri(width/2, height/2, 1, 1, colorCounter, 2));
  // Create an empty ArrayList (will store Diamond objects)
  diamond = new ArrayList<Diamond>();
  diamond.add(new Diamond(width/2, height/2, 10));
}



void draw()
{
  translate(width/2, height/2);
  background(cc[49]*360, cc[50]*360, cc[51]*360 );
  fft.analyze(spectrum);

  //for (int i = 0; i < bands; i++) {
  //  pushMatrix();
  //  translate(width/2, height/2);
  //  // The result of the FFT is normalized
  //  // draw the line for frequency band i scaling it up by 5 to get more amplitude.
  //  float vert = map(spectrum[i], 0, 1, 1, height);
  //  stroke(i, 255, 255);
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
  //}
  ////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////
  //AVERAGES
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
  ////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////
  // Create audio reactive weights for strokeWeight
  weight_low = 0.5+ (average2*30);
  weight_hi = 0.5 + (average1*100);
  weight_mid = 0.5+(average3*200);

  //Implement averages to create audio react
  if (average1>0.04) {
    triangles.add(new Tri(width/4, 0, 1.2, 0.6, colorCounter, 3));
    triangles.add(new Tri(-width/4, 0, 0.6, 1.2, colorCounter, 3));
    if (colorCounter > 300) {
      colorCounter = floor(random(1, 300));
    }
    colorCounter +=5;
  }
  if (average2>1.2) {
    println(average2);
    balls.add(new Ball(0, 0));
    v1 = random(0.4)+0.2;
  }

  if (average3>0.07) {
    strokeWeight(weight_mid);
    diamond.add(new Diamond(0,0,10));
    triangles_b.add(new Tri(0, 0, 1, 1, colorCounter -60, 4));
  }

  ////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////
  //TOGGLE STATEMENTS FOR MIDI CONTROL

  //VIDEO
  if (toggle == true) {
    tint(cc[35]*255, cc[36]*255);
    image(forestVid, -width/2, -height/2, width, height);
  }
  //GEOMETRY
  if (toggle2 == true)
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
  //MIRRORED TRIANGLES
  if (toggle3 == true) 
  {
    for (int i = triangles.size()-1; i >= 0; i--) { 
      // An ArrayList doesn't know what it is storing so we have to cast the object coming out
      Tri newTri = triangles.get(i);
      newTri.move(5);
      newTri.display();
      if (newTri.finished()) {
        // Items can be deleted with remove()
        triangles.remove(i);
      }
    }
  }
  //EXPANDING CIRCLES
  if (toggle4 == true)
  {
    //blendMode(ADD);
    for (int i = balls.size()-1; i >= 0; i--) {
      // An ArrayList doesn't know what it is storing so we have to cast the object coming out
      //colorCounter = colorCounter + i;
      Ball ball = balls.get(i);
      ball.move(10);
      ball.display(colorCounter+60, 200, 255);
      if (ball.finished()) {
        // Items can be deleted with remove()
        balls.remove(i);
      }
    }
  }
  //CENTER TRIANGLES
  if (toggle5 == true)
  {
    for (int i = diamond.size()-1; i >= 0; i--) { 
      // An ArrayList doesn't know what it is storing so we have to cast the object coming out
      pushMatrix();
      rotate(cc[53]*TWO_PI);
      Diamond newDiamond = diamond.get(i);
      newDiamond.move();
      newDiamond.display();
      if (newDiamond.finished()) {
        // Items can be deleted with remove()
        diamond.remove(i);
      }
      popMatrix();
    }
    //for (int i = triangles_b.size()-1; i >= 0; i--) { 
    //  // An ArrayList doesn't know what it is storing so we have to cast the object coming out
    //  pushMatrix();
    //  rotate(cc[53]*TWO_PI);
    //  Tri newTris = triangles_b.get(i);
    //  newTris.move(5);
    //  newTris.display();
    //  if (newTris.finished()) {
    //    // Items can be deleted with remove()
    //    triangles_b.remove(i);
    //  }
    //  popMatrix();
    //}
  }

  ////////////////////////////////////////////////////////////////////////////////////////
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

void movieEvent(Movie m) {
  m.read();
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

    forestVid.loop();
  } else if (pitch == 42) {
    toggle2 = true;
    forestVid.stop();
  } else if (pitch == 43) {
    toggle3 = true;
  } else if ( pitch == 44) {
    toggle4 = true;
  } else if (pitch == 57) {
    toggle5 = true;
  } else if (pitch == 73) {
    toggle = false;
  } else if (pitch == 74) {
    toggle2 = false;
  } else if (pitch == 75) {
    toggle3 = false;
  } else if (pitch == 76) {
    toggle4 = false;
  } else if (pitch == 89) {
    toggle5 = false;
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

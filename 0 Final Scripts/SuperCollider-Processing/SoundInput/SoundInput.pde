//IMPORT OSCP5 FOR SUPERCOLLIDER ANALYSIS
import netP5.*;
import oscP5.*;
import themidibus.*;

MidiBus myBus;

//controller change array
float cc[] = new float[256];

//DRAW VARIABLES
Drop[] drops = new Drop[1000];
Circle[] circles = new Circle[1000];

static final int NUM_DOTS = 1000;
float col = 0;
float redVar = 0;
float blueVar = 0;
float greenVar = 0;
static final int NUM_LINES = 100;
float t;
float r;
int onsetCounter = 1;


//OSC VARIABLES
float ampSlow;
float ampFast;
float note;
float ampSlow2;
float ampFast2;
float note2;
int onset;
OscP5 oscP5;
NetAddress myRemoteLocation;

float red = ampSlow/255;

void setup(){
  //background(20);
 size(1080, 720);
  //change size to screen size when presenting
  //fullScreen();
  frameRate(60);
  
 //List available Midi devices
  MidiBus.list();
  //select the correct midi device
  myBus = new MidiBus(this, 0, 1);
  
  //set osc ip and port
  oscP5 = new OscP5(this,7000);
  for (int i = 0; i < drops.length; i++) {
    drops[i] = new Drop();
  }
  for(int i = 0; i < circles.length; i++){
    circles[i] = new Circle();
  }
}

void draw(){
  background(20);
  //DRAW RAIN
  for (int i = 0; i < drops.length; i++) {
    drops[i].fall();
    drops[i].show(redVar, greenVar, blueVar, cc[78]*256);//ampFast*1000);
  }
  // IF STATEMENT TO DRAW A NEW CIRCLE EVERYTIME THERE IS AN ONSET
  //FOR LOOP is to draw the circles
    if(onset == 1){
      onsetCounter = onsetCounter + 1;
    }
  for(int i = 0; i < onsetCounter; i ++){
    circles[i].move();
    circles[i].show(blueVar, blueVar, redVar, cc[77]*256);
  }
  
 //DRAW ABSRTACT VISUALS
  translate(width/2, height/2);
   stroke(greenVar,redVar,blueVar, 255);
   float y = map(ampFast, 0, 1, 1, 5);
   float x = map(ampSlow, 0 , 1, 5, 15);
   if(note<50&&ampFast>0)
   {
    strokeWeight(x);
   }
   else
   {
    strokeWeight(1);  
   }
  for(int i = 0; i < 5000; i++)
  {
     point(x1(t+ i), y1(t+ i));
     point(-x1(t+i), -y1(t+i));
    //point(x2(t+ i), y2(t+ i));
    }
  for(int i = 0; i <NUM_LINES; i++)
  {
    line(x3(t + i), y3(t + i), x2(t + i), y2(t + i) );
  }
    float ampMap = map(ampSlow, 0, 1, 0.5, 20);
    t+= ampSlow*100;
    r+= ampMap;
    //colalpha = random(150, 200 );
  //size of cicles in sine wave variable dependent upon mouse.
  //size = map(mouseX, 0, width, 5, 15);
  

  //Color changes due to note(needs work and needs a color scheme based upon instrument)
  //I would like to make acolor algorithm that scales from one color to another based upon note.
  //ex. if note is low blue if it goes higher scale to green then scale to red if it goes even higher.
  if(note<20){
    redVar = random(155, 200);
    greenVar = random(0, 50);
    blueVar = random(200, 256);
   //  ellipse(0, height/2, pos, pos);
  }else if(note>20&&note<40){
    redVar = random(0,20);
    greenVar = random(50, 80);
    blueVar = random(220, 250);
  }else if(note>40&&note<60){
    redVar = random(0, 10);
    greenVar = random(200, 230);
    blueVar = random(230, 255);
  }else if(note>60&&note<80){
    redVar = random(0, 10);
    greenVar = random(200, 255);
    blueVar = random(10, 20);
  }else if(note>80&&note<150){
    redVar = random(0, 10);
    greenVar = random(230, 255);
    blueVar = random(200, 240);
  }else{
    redVar = random(0, 255);
    greenVar = random(0, 255);
    blueVar = random(0, 255);
  }
    //if(note<20){
    //  redVar--;
    //  greenVar--;
    //  blueVar++;
    //  if(redVar < 155){
    //    redVar=154;
    //  }
    //  if(blueVar < 11){
    //    redVar=10;
    //  }
    //}
}

/////////////////////////////////////////
//ABSTRACT VISUAL INPUTS/DESIGN CONTROL//
/////////////////////////////////////////
float x1(float t){
  
  // 1) return sin(sin(t/r) ) * 500   ;
  return sin(sin(t/(cc[13]*200))+r/20)  * (width/2);
  //return -sin(FREQUENCY) * AMPLITUDE + sin(FREQ) * AMP;
}

float y1(float t){
  // 1) return cos(t / 15) *(cos(t/20)*400);
  return cos(cos(t /(cc[14]*200))+r/20) *height/2;
}

float x2(float t){
  return sin(t / cc[13]*200) * width/2 ;
  //return -sin(FREQUENCY) * AMPLITUDE + sin(FREQ) * AMP;
}

float y2(float t){
  return cos(t / cc[14]*200) * height/2;
}

float x3(float t){
  return sin(t / cc[13]*200) + width/2;//cos(t/12)*20;
  //return -sin(FREQUENCY) * AMPLITUDE + sin(FREQ) * AMP;
}
float y3(float t){
  return cos(t / cc[14]*200) * sin(t) * 2;
}
float x4(float t){
  return sin(t/15)*(ampFast*1000)+ sin(t/20)* (100 + ampFast2*2000);
  //return -sin(FREQUENCY) * AMPLITUDE + sin(FREQ) * AMP;
}
float y4(float t){
  //println(note2/5);
  return cos(t/(note2/5)) * (200+ ampFast*1000);
}

//HOW TO BRING IN ONSET?
//THIS IS WHERE THE AUDIO INPUT MAGIC HAPPENS
//BRING IN OSC VARIABLES FROM SC AND NAME THEM ACCORDINGLY
void oscEvent(OscMessage theOscMessage) {
  ////////////////////
  // MIC 1 ANALYSIS //
  ////////////////////
  if(theOscMessage.addrPattern().equals("1: ampSlow") == true){
    //println(theOscMessage.get(0).floatValue());
    //println(theOscMessage.addrPattern());
    ampSlow = (theOscMessage.get(0).floatValue());
  }if(theOscMessage.addrPattern().equals("1: ampFast") == true){
    //println(theOscMessage.get(0).floatValue());
    //println(theOscMessage.addrPattern());
    ampFast = (theOscMessage.get(0).floatValue());
  }if(theOscMessage.addrPattern().equals("1: note") == true){
    //println(theOscMessage.get(0).floatValue());
    //println(theOscMessage.addrPattern());
    note = (theOscMessage.get(0).floatValue());
  }if(theOscMessage.addrPattern().equals("1: ONSET") == true){
    //println(theOscMessage.addrPattern());
   onset = 1;
  }else{onset = 0;}
  ////////////////////
  // MIC 2 ANALYSIS //
  ////////////////////
  if(theOscMessage.addrPattern().equals("2: ampSlow") == true){
    //println(theOscMessage.get(0).floatValue());
   // println(theOscMessage.addrPattern());
    ampSlow2 = (theOscMessage.get(0).floatValue());
  }if(theOscMessage.addrPattern().equals("2: ampFast") == true){
    //println(theOscMessage.get(0).floatValue());
    //println(theOscMessage.addrPattern());
    ampFast2 = (theOscMessage.get(0).floatValue()); 
  }if(theOscMessage.addrPattern().equals("2: note") == true){
    //println(theOscMessage.addrPattern());
    note2 = (theOscMessage.get(0).floatValue());
  }
}

//sends messages when a controllers value is changed
void controllerChange(int channel, int number, int value)
{
  println(number);
  println(value);
  cc[number] = map(value, 0 , 127, 0, 1);
}

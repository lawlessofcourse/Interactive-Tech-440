//IMPORT OSCP5 FOR SUPERCOLLIDER ANALYSIS
import netP5.*;
import oscP5.*;

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
 // size(1920, 1080);
  //change size to screen size when presenting
  fullScreen();
  frameRate(60);
  
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
    drops[i].show(redVar, greenVar, blueVar, 200);//ampFast*1000);
  }
  // IF STATEMENT TO DRAW A NEW CIRCLE EVERYTIME THERE IS AN ONSET
  //FOR LOOP is to draw the circles
    if(onset == 1){
      onsetCounter = onsetCounter + 1;
    }
  for(int i = 0; i < onsetCounter; i ++){
    circles[i].move();
    circles[i].show(blueVar, blueVar, redVar, ampSlow*1000);
  }
  
  translate(width/2, height/2);
  for(int i = 0; i < 5000; i++){
   stroke(greenVar,redVar,blueVar, ampFast*250);
    strokeWeight(random( 5, 15));
    //line(x1(t + i), y1(t + i), x2(t + i), y2(t + i) );
     point(x1(t+ i), y1(t+ i));
     point(-x1(t+i), -y1(t+i));
    //point(x2(t+ i), y2(t+ i));
    }
    t+= ampSlow*100;
    r+=ampFast*20;
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
 
  } else if(note>20&&note<40){
    redVar = random(0,20);
    greenVar = random(50, 80);
    blueVar = random(220, 250);
  }else if(note>40&&note<50){
    redVar = random(0, 10);
    greenVar = random(200, 230);
    blueVar = random(230, 255);
  }else if(note>50&&note<60){
    redVar = random(0, 10);
    greenVar = random(200, 255);
    blueVar = random(10, 20);
  }else if(note>60&&note<100){
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

void drawCircles(){

}
//Maybe do IF statements to change design of work in process.

//Static visuals that appear when certain note or amp hits?

///////////////////////////////
//MIC 1 INPUTS/DESIGN CONTROL//
///////////////////////////////
float x1(float t){
  
  // 1) return sin(sin(t/r) ) * 500   ;
  return sin(sin(t/50)+r/20 )  * ((width/2)) ;
  //return -sin(FREQUENCY) * AMPLITUDE + sin(FREQ) * AMP;
}

float y1(float t){
  // 1) return cos(t / 15) *(cos(t/20)*400);
  return cos(cos(t /150)+r/20) *height/2;
}

float x2(float t){
  return sin(t / r) * width/2 ;
  //return -sin(FREQUENCY) * AMPLITUDE + sin(FREQ) * AMP;
}

float y2(float t){
  return cos(t / 20) * width/2;
}

///////////////////////////////
//MIC 2 INPUTS/DESIGN CONTROL//
///////////////////////////////
float x3(float t){
  return cos(t / 20) * 500 + cos(t/12)*20;
  //return -sin(FREQUENCY) * AMPLITUDE + sin(FREQ) * AMP;
}
float y3(float t){
  return sin(t / floor(note2/10)) * (500 + ampSlow2*1000) + sin(t) * 2;
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

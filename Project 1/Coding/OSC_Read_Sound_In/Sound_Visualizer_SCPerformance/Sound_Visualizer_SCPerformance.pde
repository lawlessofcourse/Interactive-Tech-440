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
float bassVol;
float beautVol;
float wubVol;
float hatVol;
float lfoBus;
float rateBus;
float constVol;
float rateBus2;
OscP5 oscP5;
NetAddress myRemoteLocation;



void setup(){
 
}

void draw(){
  background(20);
}

void oscEvent(OscMessage theOscMessage) {
  ////////////////////
  // MIC 1 ANALYSIS //
  ////////////////////
  if(theOscMessage.addrPattern().equals("1: bassVol") == true){
    //println(theOscMessage.get(0).floatValue());
    //println(theOscMessage.addrPattern());
    bassVol = (theOscMessage.get(0).floatValue());
  }if(theOscMessage.addrPattern().equals("1: beautVol") == true){
    //println(theOscMessage.get(0).floatValue());
    //println(theOscMessage.addrPattern());
    beautVol = (theOscMessage.get(0).floatValue());
  }if(theOscMessage.addrPattern().equals("1: wubVol") == true){
    //println(theOscMessage.get(0).floatValue());
    //println(theOscMessage.addrPattern());
    wubVol = (theOscMessage.get(0).floatValue());
  }if(theOscMessage.addrPattern().equals("1: hatVol") == true){
    //println(theOscMessage.addrPattern());
   hatVol = (theOscMessage.get(0).floatValue());
  }if(theOscMessage.addrPattern().equals("1: lfoBus") == true){
    //println(theOscMessage.addrPattern());
   lfoBus = (theOscMessage.get(0).floatValue());
  }if(theOscMessage.addrPattern().equals("1: rateBus") == true){
    //println(theOscMessage.addrPattern());
   rateBus = (theOscMessage.get(0).floatValue());
  }if(theOscMessage.addrPattern().equals("1: constVol") == true){
    //println(theOscMessage.addrPattern());
   constVol = (theOscMessage.get(0).floatValue());
  }
}

/**
 * oscP5sendreceive by andreas schlegel
 * example shows how to send and receive osc messages.
 * oscP5 website at http://www.sojamo.de/oscP5
 */
 
import oscP5.*;
import netP5.*;
float ampSlow;
float ampFast;
float note;
float ampSlow2;
float ampFast2;
float note2;
OscP5 oscP5;
NetAddress myRemoteLocation;

void setup() {
  size(400,400);
  frameRate(30);
  background(0);
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,7000);
}

void draw() {
  background(0);
  Rain();
  
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  // MIC 1 ANALYSIS //
  if(theOscMessage.addrPattern().equals("1: ampSlow") == true){
    println(theOscMessage.get(0).floatValue());
    println(theOscMessage.addrPattern());
    ampSlow = (theOscMessage.get(0).floatValue());
  }if(theOscMessage.addrPattern().equals("1: ampFast") == true){
    println(theOscMessage.get(0).floatValue());
    println(theOscMessage.addrPattern());
    ampFast = (theOscMessage.get(0).floatValue());
  }if(theOscMessage.addrPattern().equals("1: note") == true){
    println(theOscMessage.get(0).floatValue());
    println(theOscMessage.addrPattern());
    note = (theOscMessage.get(0).floatValue());
  }  
  //Mic 2 analysis
  if(theOscMessage.addrPattern().equals("2: ampSlow") == true){
    println(theOscMessage.get(0).floatValue());
    println(theOscMessage.addrPattern());
    ampSlow2 = (theOscMessage.get(0).floatValue());
  }if(theOscMessage.addrPattern().equals("2: ampFast") == true){
    println(theOscMessage.get(0).floatValue());
    println(theOscMessage.addrPattern());
    ampFast2 = (theOscMessage.get(0).floatValue()); 
  }if(theOscMessage.addrPattern().equals("2: note") == true){
    println(theOscMessage.get(0).floatValue());
    println(theOscMessage.addrPattern());
    note2 = (theOscMessage.get(0).floatValue());
  }
}


void Rain(){
int radius =150; 
//Define local variables
int diameter = radius*2;
int colr = floor(random(150, 255));
int colg = floor(random(125, 255));
int colb = floor(random(50, 255));
float lineLength = 0.0;
lineLength = random(0, 5);

//generate random color for stroke

if(note > 80 && note < 90){
  stroke(10, 10, colb);
}if(note > 70 && note < 80){
  stroke(colr, 10, 10);
}if(note > 60 && note < 70){
  stroke(10, colg, 10);
}if(note > 50 && note < 60){
  stroke(colr, 10, colb);
}if(note >30 && note < 51){
  stroke(colr, colg, colb);
}else{stroke(255);}
//ellipse(x, y, diameter); REFERENCE FOR CIRCLE BOUNDS THAT CONTAIN THE RAIN
//TRANSLATE TO INPUT ORIGIN

//FOR LOOPs to create grid of lines
  for(float i = -height; i < height; i += random(3, 9)){
    for(float x =  -width; x <  width; x += random(8, 45)){
      //Create distance variable to create boundaris
      //Draw line inside of circle bound
      line(x, i, x, i + lineLength);
         
      
    }
    //set in motion
    //i += random(0, 0.2);
   
  }
}
//focus right scarlett 2i2
//download driver
//what are the visuals
//

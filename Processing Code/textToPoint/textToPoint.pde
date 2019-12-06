import geomerative.*;
import processing.pdf.*;
import java.util.Calendar;
 
boolean recordPDF = false;
 
char typedKey = 'a';
float spacing = 20;
float spaceWidth = 150; // width of letter ' '
int fontSize = 200;
float lineSpacing = fontSize*1.5;
float stepSize = 2;
float danceFactor = 1;
float letterX = 50;
float textW = 50;
float letterY = lineSpacing;
 
float offset=0;
 
RFont font;
RGroup grp;
RPoint[] pnts;
 
boolean freeze = false;
 
void setup() {
  size(1200, 800); 
  // make window resizable
  surface.setResizable(true);  
  smooth();
 
  frameRate(15);
 
  // allways initialize the library in setup
  RG.init(this);
  
 
  //  ------ get the points on the curve's shape  ------
  // set style and segment resolution
 
  //RCommand.setSegmentStep(10);
  //RCommand.setSegmentator(RCommand.UNIFORMSTEP);
 
  RCommand.setSegmentLength(5); // 5 = many points; 125 = only a few points 
  RCommand.setSegmentator(RCommand.UNIFORMLENGTH);
 
  //RCommand.setSegmentAngle(random(0,HALF_PI));
  //RCommand.setSegmentator(RCommand.ADAPTATIVE);
  font = new RFont("OpenSans-Bold.ttf", fontSize, RFont.LEFT);
  grp = font.toGroup(typedKey+"");
  textW = grp.getWidth();
  pnts = grp.getPoints(); 
 
  background(255);
}
 
void draw() {
  noFill();
  pushMatrix();

  // translation according the amount of letters
  translate(letterX, letterY);
 
  translate(offset, offset); // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 
  // are there points to draw?
  if (grp.getWidth() > 0) {
 
    noStroke(); 
    fill(255, 0, 0); 
 
    for (int i=0; i<pnts.length; i++) {
      ellipse(pnts[i].x, pnts[i].y, 1, 1);
    }
  }//if
 
  popMatrix();
 
  offset+=4;
}

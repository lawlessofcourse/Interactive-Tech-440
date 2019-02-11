void setup(){
   size(1080, 720);
   background(0);
   frameRate(30);
};

void draw(){
  Rain();
  
};
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
stroke(colr, colg, colb);
//ellipse(x, y, diameter); REFERENCE FOR CIRCLE BOUNDS THAT CONTAIN THE RAIN
//TRANSLATE TO INPUT ORIGIN

//FOR LOOPs to create grid of lines
  for(float i = -height; i < height; i += random(20, 40)){
    for(float x =  -width; x <  width; x += random(20, 60)){
      //Create distance variable to create boundaris
      //Draw line inside of circle bound
      line(x, i, x, i + lineLength);
         
      
    }
    //set in motion
    i += random(0, 2);
   
  }
}

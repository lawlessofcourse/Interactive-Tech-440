

//DRAW VARIABLES
static final int NUM_LINES = 100;
float t;
float r;



void setup(){
  background(20);
  //fullScreen();
  size(1000, 1000);



}

void draw(){
  background(20);
  
  translate(width/2, height/2);
  
  for(int i = 0; i < 5000; i++){
   stroke(random(155, 200),random(200, 255),random(155, 200), random(200, 255));
  strokeWeight(random( 5, 6));
  //line(x1(t + i), y1(t + i), x2(t + i), y2(t + i) );
  point(x1(t+ i), y1(t+ i));
  //point(x2(t+ i), y2(t+ i));
  }
  t+= 0.5;
    r+=2;
    println(r);
   
}

float x1(float t){
  
  // 1) return sin(sin(t/r) ) * 500   ;
  return sin(sin(t/50)+r/20 )  * 400  ;
  //return -sin(FREQUENCY) * AMPLITUDE + sin(FREQ) * AMP;
}

float y1(float t){
  // 1) return cos(t / 15) *(cos(t/20)*400);
  return cos(cos(t /150)+r/50) *400;
}
float z1(float t){
  return cos(t/15) * 100;
}
float x2(float t){
  return sin(t / r) * 200 ;
  //return -sin(FREQUENCY) * AMPLITUDE + sin(FREQ) * AMP;
}

float y2(float t){
  return cos(t / 20) * 200;
}

import themidibus.*;

MidiBus myBus;

float cc[] = new float[256];

Circle[] circles = new Circle[800];

void setup(){
  frameRate(60);
  size(1080,720);
  colorMode(HSB);
  myBus = new MidiBus(this, 0, 1);
  for (int i = 0; i < circles.length; i++) {
    circles[i] = new Circle(0,0, 100);
  }
}
void draw(){
  //background(cc[41]*360,cc[42]*360,cc[43]*360);
  background(0);
  for (int i =0; i<10; i++)
    {
     
      translate(width/2, height/2);
      
      //circles[i].show( cc[21]*360, cc[22]*360, cc[23]*360);
      circles[i].show(200, 90, 300);
      circles[i].checkEdge();
      circles[i].move();
     
    }
}
void controllerChange(int channel, int number, int value)
{
  println(number);
  println(value);
  cc[number] = map(value, 0, 127, 0, 1);

  
}

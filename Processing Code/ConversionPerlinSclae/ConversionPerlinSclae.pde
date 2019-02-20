import themidibus.*;

MidiBus myBus;
float cc[] = new float[256];

int nums =200;
float noiseScale = 1000;

Particle[] particles_a = new Particle[nums];
Particle[] particles_b = new Particle[nums];
Particle[] particles_c = new Particle[nums];

void setup(){
  //List available Midi devices
  MidiBus.list();
  //select the correct midi device
  myBus = new MidiBus(this, 0, 1);
  fullScreen(0);
  background(21, 8, 50);
  for(int i = 0; i < nums; i++){
    particles_a[i] = new Particle(random(0, width),random(0,height) );
    particles_b[i] = new Particle(random(0, width),random(0,height));
    particles_c[i] = new Particle(random(0, width),random(0,height));
  }
}

void draw(){
   
  noStroke();
  smooth();
    for(int i = 0; i < nums; i++){
    float radius = map(i,0,nums,1,2);
    float alpha = map(i,0,nums,0,250);

    fill(69,33,124,alpha);
    particles_a[i].move();
    particles_a[i].show(radius);
    particles_a[i].checkEdge();

    fill(7,153,242,alpha);
    particles_b[i].move();
    particles_b[i].show(radius);
    particles_b[i].checkEdge();

    fill(255,255,255,alpha);
    particles_c[i].move();
    particles_c[i].show(radius);
    particles_c[i].checkEdge();
  }  
}
void controllerChange(int channel, int number, int value)
{
  println(number);
  println(value);
  cc[number] = map(value, 0 , 127, 0, 1);
}

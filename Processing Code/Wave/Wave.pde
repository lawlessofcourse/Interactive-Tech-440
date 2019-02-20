float freq = 10;
float amp = 80;
float w = 20;
float h = 20;
 
 
void setup() {
  fullScreen();
  noStroke();
}
 
 
void draw() {
  background(0,0,50);
  translate(0,height/2);
  fill(0, 0, 50, 40);
  rect(0, 0, width, height);
   
  for (int i = 0; i < width; i++) {
    // Middle blue
    fill(220, 255, 255, 255);
    rect(i*20, sin((frameCount+i*3)/freq)*(amp*1), w, h, 50);
     
    for (int x = 1; x < 16; x++) {
      // Top blue
      fill(230-(x*40), 255, 255, 255-(x*32));
      rect(i*20, ((x*20)) + sin((frameCount+i*3)/freq) * (amp*(1-(x*0.13))), w*(1-(x*0.075)), h*(1-(x*0.075)), 25-(x*3.5));
       
      // Bottom blue
      fill(230-(x*40), 255, 255, 255-(x*32));
      rect(i*20, ((x*20)) + sin((frameCount+i*3)/freq) * (amp*(1-(x*0.13))), w*(1-(x*0.075)), h*(1-(x*0.075)), 25-(x*3.5));
       
      // Top purple
      fill(255, 230-(x*20), 255, 15);
      rect(i*20+10, ((x*20)) + tan((frameCount+i*3)/freq) * (amp*(1-(x*0.13))), w*(1-(x*0.125)), h*(1-(x*0.125)), 25-(x*3.5));
       
      // Bottom purple
      fill(255, 200-(x*20), 255, 15);
      rect(i*20+10, ((x*20)) + tan((frameCount+i*3)/freq) * (amp*(1-(x*0.13))), w*(1-(x*0.125)), h*(1-(x*0.125)), 25-(x*3.5));
    }
  }
}
 
 
void mouseMoved() {
  //freq = 10 * (1.0-mouseX/(float)width+1);
  //amp = 50 * (1.0-mouseY/(float)height+1);
}

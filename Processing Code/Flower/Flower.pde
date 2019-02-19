float t;

void setup() {
  //size(500, 500);
  fullScreen();
}

void draw() {     
  background(0);
  t = (sin(frameCount*0.005));
  flower(800*t + 100, 16, 11, 200, 50, 0.45*t + 0.1, 0.4, TWO_PI*(1-t));
}

void flower(float r, float c, float petalCount, float circleCount, float  maxRad, float minRad, float frac, float rot) {  
  float rad = 0;
  noStroke();

  pushMatrix();
  translate(width/2, height/2);  
  for (int j = 0; j< petalCount; j++)       
    for (float i = c; i <= circleCount; i = i + 1) {
      float tt = i/circleCount;
      float x  = r*tt*cos( tt*rot + (2*TWO_PI*j)/petalCount-TWO_PI/2);
      float y  = r*tt*sin( tt*rot + (2*TWO_PI*j)/petalCount-TWO_PI/2);

      if (i < frac*circleCount) {
        rad = map(i, 0, frac*circleCount, minRad, maxRad);
      } else {
      rad = map(i, 0, frac*circleCount, maxRad, minRad);
      }
      fill(lerpColor(color(255*t, 255, 0, 10), color(50*t + 205, 127*(1-t), 0, 100), i/circleCount));      
      ellipse(x, y, 2*rad, 2*rad);
    }
  popMatrix();
}

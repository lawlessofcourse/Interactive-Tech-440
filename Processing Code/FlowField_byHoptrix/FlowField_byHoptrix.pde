float xoff, yoff, zoff, inc, col;
int rez, cols, rows, num;
PVector[] vectors;
ArrayList<Particle> particles;

void setup() {
  size(700, 500);
  colorMode(HSB);
  init();
}
void init() {
  background(0);
  rez = 10;
  inc = 0.1;
  num = 1000;
  col = random(255);
  cols = floor(width / rez) + 1;
  rows = floor(height / rez) + 1;
  vectors = new PVector[cols * rows];
  particles = new ArrayList<Particle>();
  for (int i=0; i<num; i++)
    particles.add(new Particle());
}
void draw() {
  yoff = 0;
  for (int y=0; y<rows; y++) {
    xoff = 0;
    for (int x=0; x<cols; x++) {
      float angle = noise(xoff, yoff, zoff) * TWO_PI * 2;
      PVector v = PVector.fromAngle(angle);
      v.setMag(1);
      vectors[x + y * cols] = v;
      xoff += inc;
    }
    yoff += inc;
  }
  zoff += 0.005;
  if (col < 255)col += 0.1;
  else col = 0;
  for (Particle p : particles)p.run();
}
void mousePressed()
{
  background(255);
  init();
}

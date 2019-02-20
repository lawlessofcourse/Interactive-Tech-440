//Code from Ariadne Bai
final int nb = 55;
final int step = 8;
final float DIST = 50;
final float DISTORTION = 15;
Part[][] parts = new Part[nb][nb];
Boolean mode = true;

void setup() {
  size(500, 500, P2D);
  int dx = (width-nb*step)/2;
  for (int i = 0; i < nb; i ++) {
    for (int j = 0; j < nb; j ++) {
      parts[i][j] = new Part(i*step+dx, j*step+dx);
    }
  }
}

void draw() {
  background(160);
  PVector m = new PVector(mouseX, mouseY); 
  for (int i = 0; i < nb; i ++) {
    for (int j = 0; j < nb; j ++) {
      parts[i][j].update(m);
    }
  }
}



void mousePressed() {
  mode = !mode;
}

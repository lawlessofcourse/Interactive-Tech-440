ArrayList<Line> lines;
int lineWidth = 0;
color whi;
color b;
float life = 255;

void setup() {
  size(1280, 720);
  noStroke();
  whi = color(255, 0, 255);
  b = color(0, 0,0);
  lines = new ArrayList<Line>();
  //lines.add(new Line(width/2, height/2, lineWidth));
}

void draw() {
  background(0);
  for (int i = lines.size()-1; i >= 0; i--) { 
    Line line = lines.get(i);
    line.move();
    line.display();
    if (line.finished()) {
      // Items can be deleted with remove()
      lines.remove(i);
    }
  }
}

void mousePressed() {
  lines.add(new Line(mouseX, mouseY,lineWidth));
}

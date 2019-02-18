PVector[] points;
PVector current;
float percent = 0.5;
PVector previous;

void setup() {
  fullScreen();
  int n = 4;
  points = new PVector[n];

  for (int i = 0; i < n; i++) {
    float angle = i * TWO_PI / n;
    PVector v = PVector.fromAngle(angle);
    v.mult(width / 2);
    v.add(width / 2, height / 2);
    points[i] = v;
  }
  reset();
}

void reset() {
  current = new PVector(random(width), random(height));
  background(0);
  stroke(255);
  strokeWeight(8);
  for (PVector p : points) {
    point(p.x, p.y);
  }    

}

void draw() {

  if (frameCount % 100 == 0) {
    //reset();
  }

  for (int i = 0; i < 1000; i++) {
    strokeWeight(random(1,2));
    stroke(random(100,255),random(0,255),random(0,255) );
    PVector next = points[floor(random(points.length))];
    if (next != previous) {
      current.x = lerp(current.x, next.x, percent);
      current.y = lerp(current.y, next.y, percent);
      point(current.x, current.y);
    }
    previous = next;
  }
}

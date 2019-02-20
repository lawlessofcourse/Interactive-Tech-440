
ArrayList<Circle> circles = new ArrayList<Circle>();
boolean colour = true;

void setup() {
  size(500, 500);
  for (float i = width; i > 0; i -= width/20) {
    Circle circle = new Circle();
    circle.size = i;
    circle.colour = colour;
    colour = !colour;
    circles.add(circle);
  }
  background(230);
}

void draw() {
  noStroke();
  for (int i = circles.size() - 1; i >= 0; i--) {
    Circle circle = circles.get(i);
    Circle circleShow = circles.get(circles.size() - 1 - i);
    if (circle.colour) {
      fill(20, 50, 50);
    } else {
      fill(230);
    }
    ellipse(width/2, height/2 + 50, circleShow.size, circleShow.size);
    circle.size += 2;
    if (circle.size >= width) {
      Circle newCircle = new Circle();
      newCircle.size = 1;
      newCircle.colour = colour;
      circles.add(newCircle);
      colour = !colour;
      circles.remove(circle);
    }
  }
  strokeWeight(450);
  stroke(230);
  noFill();
  triangle(width/2, -350, -350, height + 150, width +375, height + 150);
  noise();
}

void noise() {
  noStroke();
  strokeWeight(1);
  for (int i = 0; i < width - 1; i += 5) {
    for (int j = 0; j < height - 1; j += 5) {
      fill(random(0, 255), random(30, 50));
      rect(random(i - 5, i), random(j - 5, j), 1, 1);
    }
  }
  for (int i = 0; i < 5; i++) {
    fill(random(0, 255), 255);
    rect(random(0, width), random(0, height), 2, 2);
  }
}

class Circle {
  float size;
  boolean colour;
}

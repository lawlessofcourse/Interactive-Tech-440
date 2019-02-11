class Drop {
  float x;
  float y;
  float z;
  float len;
  float yspeed;

  Drop() {
    x  = random(width);
    y  = random(-500, -50);
    z  = random(0, 20);
    len = map(z, 0, 20, 10, 50);
    yspeed  = map(z, 0, 20, 1, 20);
  }

  void fall() {
    y = y + yspeed;
    float grav = map(z, 0, 20, 0, 0.2);
   // yspeed = yspeed + grav;
    yspeed = yspeed + grav ;

    if (y > height) {
      y = random(-200, -100);
      yspeed = map(z, 0, 20, 4, 50);
      println(ampFast);
    }
  }

  void show(float r, float g, float b) {
    float thick = map(z, 0, 20, 1, 5);
    strokeWeight(thick);
    stroke(r, g, b);
    line(x, y, x, y+len);
  }
}

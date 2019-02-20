class Part {
  PVector pos, speed, origin;
  Part(int x, int y) {
    pos = new PVector(x, y);
    origin = pos.get();
    speed = new PVector(0, 0);
  }
  void update(PVector m) {
    PVector tmp = origin.get();
    tmp.sub(m);
    float d = tmp.mag();
    float c = map(d, 0, DIST, 0, PI);
    tmp.normalize();
    if (mode) {
      tmp.mult(DISTORTION*sin(c));
    }
    if (d < DIST) {
      strokeWeight(1+10*abs(cos(c/2)));
      if (!mode) {
        tmp.mult(DISTORTION*sin(c));
      }
    } else {
      strokeWeight(map(min(d, width), 0, width, 5, .1));
    }

    PVector target = new PVector(origin.x+tmp.x, origin.y+tmp.y);
    tmp = pos.get();
    tmp.sub(target);
    tmp.mult(-map(m.dist(pos), 0, 2*width, .1, .01));
    speed.add(tmp);
    speed.mult(.87);
    pos.add(speed);

    point(pos.x, pos.y);
  }
}

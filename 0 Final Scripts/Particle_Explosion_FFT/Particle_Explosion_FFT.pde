//Copyright Jonathan Fraser 2011
//Free to use for non-commercial purposes
//Enjoy :)

ArrayList plist = new ArrayList();
int MAX = 200;

void setup() {
  size(1080,720);
  background(0);
  colorMode(HSB);
}

void draw() {
  background(0);
  if(mousePressed && mouseButton == RIGHT) {
    background(0);
    boolean clearall = true;
    while(plist.size() > 0) {
      for(int i = 0; i < plist.size(); i++) {
        plist.remove(i);
      }
    }
  }

  for(int i = 0; i < plist.size(); i++) {
    
    Particle p = (Particle) plist.get(i); 
    //makes p a particle equivalent to ith particle in ArrayList
    p.run();
    p.update();
    p.gravity();
  }
}

void mousePressed() {
  for (int i = 0; i < MAX; i ++) {
    plist.add(new Particle(mouseX,mouseY)); // fill ArrayList with particles

    if(plist.size() > MAX) {
      plist.remove(0);
    }
  }
}

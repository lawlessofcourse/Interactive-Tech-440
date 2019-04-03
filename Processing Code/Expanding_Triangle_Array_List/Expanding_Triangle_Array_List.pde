import spout.*;
Spout spout;

ArrayList<Tri> triangles;

String senderName;

void setup() {
  size(1920, 1080, P3D);
  noStroke();
  textureMode(NORMAL);
  spout =  new Spout(this);
  senderName = "Spout Processing";
  spout.createSender(senderName, width, height);
  
  // Create an empty ArrayList (will store Ball objects)
  triangles = new ArrayList<Tri>();

  // Start by adding one element
  triangles.add(new Tri(width/2, height/2));
}

void draw() {
  background(0);
  //translate(width/2, height/2);
  // With an array, we say balls.length, with an ArrayList, we say balls.size()
  // The length of an ArrayList is dynamic
  // Notice how we are looping through the ArrayList backwards
  // This is because we are deleting elements from the list  
  for (int i = triangles.size()-1; i >= 0; i--) { 
    // An ArrayList doesn't know what it is storing so we have to cast the object coming out
    Tri newTri = triangles.get(i);
    newTri.move(5);
    newTri.display();
    if (newTri.finished()) {
      // Items can be deleted with remove()
      triangles.remove(i);
    }
  }
  spout.sendTexture();
}

void mousePressed() {
  // A new ball object is added to the ArrayList (by default to the end)
  triangles.add(new Tri(mouseX, mouseY));
}

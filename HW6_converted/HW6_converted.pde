//Jack Lawless
//Creative Coding 220 Section 51
//October 18th, 2017

//I couldn't seem to organize the top variables into an myObj = {}; without corrupting the program
float angle = 0.0;
float offset = 0.75;
int scalar = 20;
float speed = 0.05;
int size = 5;
float x ;
float y = 0 ;
 int colr= 0;
 int colg= 0;
 int colb= 255;
 float colalpha= 255;

//position variable for background ellipse
int pos = 0;


void setup(){
size(600 , 600);
background(99, 0, 145);
}

void draw(){
  noStroke();
  translate(width/2, 0);
  //randomize alpha value between 150 and 200
  colalpha = random(150, 200 );
  //size of cicles in sine wave variable dependent upon mouse.
  //size = map(mouseX, 0, width, 5, 15);

//Sandbox for background circle
  pushMatrix();
  noFill();
  stroke(colr , 150, 0, 75);
  ellipse(0, height/2, pos, pos);
  //randomize movement speed of ellipse
  pos += floor(random(2, 10));
  //bound ellipse to width of canvas
  pos = pos % width;
  popMatrix();
// If statement to bound pattern and increase scalar upon each pass
  if(y > height){
    y = 0;
    scalar += pow(2, 4);
  //x + 500;
  }
  //reset after scalar after it has become very large
  if(scalar > 500){
    angle = 0.0;
    scalar = 20;
  }
//randomize r g and b to a nice set of colors
  colr = floor(random(0, 255));
  colg = floor(random(0 , 100));
  colb = floor(random( 100, 200));
  fill(colr, colg, colb, colalpha);
  ellipse(x,  y, size, size);
  ellipse(-x,  y, size, size);
  //create sin wave movement (horizontal)
  x = ((offset + sin(angle)) * scalar);
  //create vertical movement
  y += 2;
  // update angle based upon speed.
  angle += speed;

}

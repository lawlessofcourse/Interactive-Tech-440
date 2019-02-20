float posx;
float posy;

Triangle[] triangles = new Triangle[100];
float movex;
float movey;


void setup()
{
  size(1080,720);
  frameRate(30);
  for(int i = 0; i < triangles.length; i++)
  {
    triangles[i] = new Triangle();
  }
}
void draw()
{
  float r = 0;
  
  if(r>359){
  r = 0;
  }
  background(20);
  translate(width/2, height/2);
  rotate(degrees(r));
  noFill();
  stroke(0);
  strokeWeight(4);
  for(int i = 0; i<triangles.length; i++)
  {
    triangles[i].display(i, 255, 255, movex, movey);
    //triangles[i].display(i, 255, 255, -movex, -movey);

  }
  if(movex>width/2)
  {
    movex = 0;
    movey = 0;
  }
  movex += 5;
  movey += 5;
  r+=1;
  
  
  
  //triangle(0,posy, -posx, -posy, posx, -posy);
}

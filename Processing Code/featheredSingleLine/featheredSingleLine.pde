//Lines[] line = new Lines[50];
float posX;
float posY;
color whi;
color b;
float w=0;
float speed=0.5;
int x=0, y=0;

void setup()
{
  size(1280, 720);
  whi = color(255, 255, 255);
  b = color(0, 0, 0);

}

void draw()
{
  translate(width/2, height/2);
  rectMode(CENTER);
  background(0);
  noFill();
  if (w>=25)
  {
    speed*=-1;
  }else if(w<0)
  {
    speed*=-1;
  }
  if (mousePressed==true)
  {
    w +=speed;
  }
  for (int i = x; i <= x+w; i++) {
      float inter = map(i, x, x+w, 0, 1);
      //float inter2 = map(i,x,x-w,0,1);
      color c = lerpColor(whi, b, inter);
      //color c2 = lerpColor(whi,b,inter2);
      stroke(c);
      line(i, y-height, i, y+height);
      //stroke(c2);
      line(-i, y-height, -i, y+height);
      //line(i+width/2, y, i, y+h);
    }
}

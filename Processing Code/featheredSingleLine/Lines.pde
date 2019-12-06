class Lines
{
  int x;
  int y;
  public Lines(int x, int y)
  {
    this.x=x;
    this.y=y;
  }
  void update(float vel, float wid)
  {
    if (wid>=25)
    {
      vel*=-1;
    } else if (wid<0)
    {
      wid=0;
    }
    wid +=vel;
  }
  void display(int x1, int y1)
  {
    x=x1;
    y=y1;
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
}

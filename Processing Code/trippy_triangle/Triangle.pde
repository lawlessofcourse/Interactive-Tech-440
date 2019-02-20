class Triangle
{
  float posx;
  float posy;
  Triangle()
  {
    posx += 1;
    posy += 1;
  }
  void display(float h, float s, float b)
  {
   stroke(h,s,b);
   strokeWeight(2);
   triangle(0,posy, -posx, -posy, posx, -posy);
  }
}

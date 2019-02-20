class Triangle
{
  
  Triangle()
  {
    posx += 1;
    posy += 1;
  }
  void display(float h, float s, float b, float posx, float posy)
  {
   stroke(h,s,b);
   strokeWeight(2);
   triangle(0,posy, -posx, -posy, posx, -posy);
   //triangle(0-15,posy-15, -posx+15, -posy+15, posx-15, -posy-15);    
   //triangle(0+15,posy+15, -posx-15, -posy-15, posx+15, -posy+15);

  }
}

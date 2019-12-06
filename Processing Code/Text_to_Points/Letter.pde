class Letter
{
  String let;
  PFont font;
  int x;
  int y;
  PShape shape;
  public Letter( int x, int y)
  {
    
    this.x = x;
    this.y = y;
  }
  void display(String let, PFont font)
  {
    this.let = let;
    this.font = font;
    shape = createShape();  
   
    textFont(font);
    text(let, x, y);
  } 
}

import geomerative.*;

class Letter
{
  char let;
  PFont font;
  RFont fs;

  int x;
  int y;

  public Letter( int x, int y)
  {

    this.x = x;
    this.y = y;
  }
  void display(char let, RFont fs, RGroup gp)
  {
    this.let = let;
    this.fs = fs;
    gp =fs.toGroup(let+"");
    text(let, x, y);
  }
}

//DO NOT EDIT USE FOR REFERENCE

/* 
Title: Scrolling Fonts
Author: Jack Lawless
Date: 12/3/2019
*/

int fontSize=200;

PFont fontOTF;
PFont fontOTF2; 
PFont fontTTF;
String[] fontList; 
String[] letters = {"L","A","W","L","E","S","S"};
int duh=0;

Letter[] lets = new Letter[7];

int count=0;
int speed = 1;

//DO NOT EDIT USE FOR REFERENCE
void setup()
{
  size(1280,720);
  frameRate(60);
  //Get's list of installed fonts.. I prefer downloading the font and then putting it in the sketches folder and referencing it that way
  fontList = PFont.list();
  printArray(fontList);
  //If I want to use Geomerative library (RFont) you HAVE to use TrueType Font (.ttf) and not OpenType(.otf)
  fontOTF = createFont("Azonix.otf",fontSize);
  fontOTF2 = createFont("CODE.otf",fontSize*1.5);
  
  for(int i =0; i<lets.length;i++)
  {
    lets[i] = new Letter(width/6+(i*145),height/2);
  }

  textAlign(CENTER,CENTER);
  
}

void draw()
{
  background(0);

  count+=1;
  if(count%7==0)
  {
    duh+=speed;
  }
    if(duh>=6||duh<1)
  {
    speed*=-1;
  }
  println(duh);
  
  for(int i =0; i<lets.length;i++)
  {
    //lets[doi].display(letters[doi],font3);
    lets[duh].display(letters[duh],fontOTF2);
    
    if(i!=duh)
    {
      lets[i].display(letters[i], fontOTF);
    }
  }
}

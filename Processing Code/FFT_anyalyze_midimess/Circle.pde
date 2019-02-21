class Circle
{
  //float x;
  //float y;
  float pos;
  float weight;
  Circle(){
    //x = random(width, -width);
    //y = random(height, -height);
    pos = 0;
    weight = 1;
  }
void move(int size)
{
  pos += 8;
  pos = pos % size;
}
void show(float x,float y, float r, float g, float b, float a)
{

  //println(circ);
  noFill();
  stroke(r,g,b,a);
  if(weight >=2 && weight < 6){
    weight = 3;   
  } else{
    weight = 2;
  }
    weight= weight*(average2/2)+1;
  
  strokeWeight(weight);
    //scale(cc[13]*2);
  ellipse(x, y, pos, pos);
}

}  

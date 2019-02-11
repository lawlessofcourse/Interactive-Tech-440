class Circle{
  float x;
  float y;
  int pos;
  float weight;
  Circle(){
    x = width/2;
    y = height/2;
    pos = 0;
    weight = 1;
  }
void move(){
  pos += 10+(500*ampSlow);
  //pos = pos % width;
}
void show(float r, float g, float b, float a){
  noFill();
  stroke(r,g,b,a);
  if(weight >=1 && weight < 6){
    weight = 100*ampSlow;   
  } else{
    weight = 1;
  }
  strokeWeight(weight);
  ellipse(x, y, pos, pos);
}

}     

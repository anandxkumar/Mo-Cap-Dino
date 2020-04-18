
// Created To Show Some Lines randomly on the floor

class Ground
{
  float posX = width;
  float posY=height;
  int w = floor(random(1,10));
  int h=floor(random(1,20));
 
  
  void show()
  {
    stroke(0);
    strokeWeight(3); // THICKNESS OF LINE
    line(posX,posY-50-h, posX + w, posY-50-h);
  }
  
  void move(float speed)
  {
    posX -= speed;    // Moves right to left
  } 

}

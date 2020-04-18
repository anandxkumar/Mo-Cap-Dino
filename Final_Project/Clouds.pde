class Cloud
{
  
  float posX = width;
  float posY=height;
 
  
  void show()
  {
    image(cloud, posX - cloud.width/2, height - 600);
  }
  
  void move(float speed)
  {
    posX -= speed;
  } 
};

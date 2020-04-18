class Smallcone
{
  
  int w;
  int h;
  
  float posX;
  
  Smallcone()  // Constructor
  {
    w=10;
    h=60;
    posX=width;  
  }
  
  void show()
  {

    image(smallCone, posX-smallCone.width/2, height-100-smallCone.height);   //  To display the image we loaded 
  }
  
  void move(float speed)
  {
    
    posX-=speed;
      
  }
 boolean collided(float playerX, float playerY, float playerWidth, float playerHeight)  // centre coordinates of player and then player width and height
 {

    float playerLeft = playerX-playerWidth/2;     // left x coordinate of player
    float playerRight = playerX+playerWidth/2;    // right x coordinate of player
    float coneLeft = posX-w/2;                    // left x coordinate of cone        
    float coneRight = posX+w/2;                   // right x coordinate of cone
    float playerDown = playerY-playerHeight/2;  // bottom y coordinate of player
    float coneUp = h;  // cone top coordinate
    if ((playerLeft<= coneRight && playerRight >= coneLeft ) || (coneLeft <= playerRight && coneRight >= playerLeft)) // Small cone is in between the player
    {
      if (playerDown <= coneUp)  // JUMP
      {
        return true;
      }
    }
    return false;
  }
}
    

class Shield
{
  
  int w;
  int h;
  int c;
  int flag=0;
  float posX;
  float posY;
  
  Shield()
  {
    c=0;
    w=40;
    h=60;
    posX=width;
    posY=0;
  }
  
  void show()
  {
    image(shield,posX-shield.width/2,height - 120 - (posY + shield.height-20));   //  To display the image we loaded 
  }
  
  void move(float speed)
  {
    // To bounce the Shield
    if(posY<=0 )
    {
      flag=0; 
      posX-=speed;
    }
    if(flag==0)
    {
     posY+=5;  
     posX-=speed;
    }
    
    if(posY>150)
    {
      flag=1; 
      posX-=speed;
    }
    if(flag==1)
    {
     posY-=5; 
     posX-=speed;
    }
            
    
      
  }  
   boolean collided(float playerX, float playerY, float playerWidth, float playerHeight)
   {

    float playerLeft = playerX - playerWidth/2;
    float playerRight = playerX + playerWidth/2;
    float birdLeft = posX - w/2 ;
    float birdRight = posX + w/2;

    if ((playerLeft<= birdRight && playerRight >= birdLeft ) || (birdLeft <= playerRight && birdRight >= playerLeft)) {
      float playerUp = playerY + playerHeight/2;
      float playerDown = playerY - playerHeight/2;
      float birdUp = posY + h/2;
      float birdDown = posY - h/2;
      if (playerDown <= birdUp && playerUp >= birdDown) {
        return true;
      }
    }
    return false;
  }
}

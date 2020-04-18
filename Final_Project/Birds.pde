class Bird 
{
  float w = 60;
  float h = 50;
  float posX;
  float posY;
  float flapCount = 0;
  

 //constructor
  Bird(int type) {
    posX = width;
    
    switch(type) {
    case 0://flying low
      posY = 10+h/2;
      break;
    case 1://flying middle
      posY = 69;
      break;
    case 2://flying high
      posY = 180;
      break;
    }
  }

  //show the bird
  void show() {
    flapCount++;
    // to switch between to images of bird
    if (flapCount < 0) {//flap the bird
      image(bird1,posX-bird1.width/2,height - 100 - (posY + bird1.height-20));
    }
    else
    {
      image(bird2,posX-bird2.width/2,height - 100 - (posY + bird2.height-20));
    }
    if(flapCount > 15)
    {
     flapCount = -15;   
    }
  }

  // move the bird
  void move(float speed)
  {
    posX -= speed;
  }

  //returns whether or not the bird collides with the player
  boolean collided(float playerX, float playerY, float playerWidth, float playerHeight) {

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

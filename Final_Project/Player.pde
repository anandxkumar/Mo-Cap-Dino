int run=0;  // run counts to alter between images of running player
int bluecol=0;   // check whether player has collided with shield
int bluetime=0;   // Shield activation time;
int time=0; // To initate duck

class Player
  {
    float posY=0;    // Position abover Ground Of our player
    float velY=0;      // when 
    float gravity=0.5;
    float speed= 5;
    int size=20;
   
    ArrayList<Cloud> badal=new ArrayList<Cloud>(); // To Create Clouds
    ArrayList<Bird> bird=new ArrayList<Bird>();   // To Display birds
    ArrayList<Smallcone> obstacles=new ArrayList<Smallcone>(); // we need to display many cones at a time so arraylist
    ArrayList<Ground> obstacle1=new ArrayList<Ground>();  // to display lines on the ground
    ArrayList<Shield> blue=new ArrayList<Shield>();   // blue
    
    Player()
    { 
      
    }
    
  void show()
  {
   
   //------------------------------------------------------------  
    if(bluecol==1)    // If PowerUp has be aquired !
    {
      
      if(duck && time<=30 && time>=0  )  // Used time variable to duck the player for a while 
     {
        time++;
     }
     else    
     {
       duck=false; 
       time=0;
     }
      // To display the frames of player jump , running sequences
     if (duck && posY == 0)  // Duck is true
     {
      if (run < 5) 
      {
        image(playerDuck1k, 100 - playerDuck1k.width/2, height - 100 - (posY + playerDuck1k.height));
      } else 
      {
        image(playerDuck2k, 100 - playerDuck2k.width/2, height - 100 - (posY + playerDuck2k.height));
      }
    }
    else
     {
     if (posY==0 ) {   // posY=0 means player is grounded 
        if (run < 5) 
        {
          image(playerRun1k,100  - playerRun1k.width/2, height - 100 - (posY + playerRun1k.height));
        } else
        {
          image(playerRun2k, 100 - playerRun2k.width/2, height - 100 - (posY + playerRun2k.height));
        }
      } 
      else  // JUMP is true
      {
        image(playerJumpk,100 - playerJumpk.width/2, height - 100 - (posY + playerJumpk.height));
      }
     }
    }
     
     else
     {
       
       if(duck && time<=30 && time>=0  )  // Used time variable to duck the player for a while 
     {
        time++;
     }
     else    
     {
       duck=false; 
       time=0;
     }
      // To display the frames of player jump , running sequences
     if (duck && posY == 0  ) {
      if (run < 5) 
      {
        image(playerDuck1, 100 - playerDuck1.width/2, height - 100 - (posY + playerDuck1.height));
      } else 
      {
        image(playerDuck2, 100 - playerDuck2.width/2, height - 100 - (posY + playerDuck2.height));
      }
    }
    else
     {
     if (posY==0 ) {   // posY=0 means player is grounded 
        if (run < 5) 
        {
          image(playerRun1,100  - playerRun1.width/2, height - 100 - (posY + playerRun1.height));
        } else
        {
          image(playerRun2, 100 - playerRun2.width/2, height - 100 - (posY + playerRun2.height));
        }
      } 
      else 
      {
        image(playerJump,100 - playerJump.width/2, height - 100 - (posY + playerJump.height));
      }
     }
       
       
       
 }
      
      bluetime++;
      if(bluetime>450 && bluetime<600 && bluecol==1)
      {
        strokeWeight(3);
       text("SHIELD ABOUT TO END ", 600,400); 
        
      }
       if(bluetime==600)
       {
          bluetime=0;
          bluecol=0;
       }

   
    
    run++;
    if (run > 10) {      // For 5 Frames each one image will be shown of both run and duck
      run = 0;
    }
    
     for(int i=0;i<bird.size();i++)  // shows all the cones in arraylist
    {
      bird.get(i).show();
    }  
    
    for(int i=0;i<obstacles.size();i++)  // shows all the cones in arraylist
    {
      obstacles.get(i).show();
    }  
    for(int i=0;i<obstacle1.size();i++)  // shows all the lines in ground object in arraylist
    {
      obstacle1.get(i).show();
    } 
    for(int i=0;i<badal.size();i++)  // shows all clouds
    {
      badal.get(i).show();
    } 
    for(int i=0;i<blue.size();i++)  // shows all powerUP
    {
      blue.get(i).show();
    } 
  }
  
  //------------------------------------------------------------------------
  void move()
  {
    posY+=velY;       // Initial velY is equal to 0
    if(posY>0)
    {
      velY-=gravity;  // Decreases posY
    }
    else
    {
      velY=0;
      posY=0;
    }
    for(int i=0;i<bird.size();i++)
    {
      bird.get(i).move(speed);   // moves all the ground lines in arraylist
    } 
    for(int i=0;i<obstacles.size();i++)
    {
      obstacles.get(i).move(speed);   // moves all the cones in arraylist
    } 
    for(int i=0;i<obstacle1.size();i++)
    {
      obstacle1.get(i).move(speed);   // moves all the cones in arraylist
    }  
    for(int i=0;i<badal.size();i++)
    {
      badal.get(i).move(speed);   // moves all the cones in arraylist
    } 
    for(int i=0;i<blue.size();i++)
    {
      blue.get(i).move(6);   // moves all the PowerUp in arraylist
    } 
}
//-----------------------------------------------------------------------------
void texts()   // TO show all texts highscore , score , generation
{
  text("SCORE ", 700, 40);   // TO DISPLAY SCORE
      text(score[index],800,40);
      // HIGHSCORE  
      for(int i=0;i<=index;i++)
      {
        if(highscore<=score[index])
        {
          highscore=score[index];
        }
      }
      text("HIGHSCORE ", 900, 40);   // TO DISPLAY HIGHSCORE
      text(highscore,1000,40);
      // GENERATION
       text("GENERATION ",900,60);
       text(index,1000,60);
       
  
}

//------------------------------------------------------------
void collision()
{
      fill(0);
      float x1;  // x center of player
      float y1;  // y center of player
      float a1;  // width
      float b1;  // thickness
      
      

      if(duck)       // when duck height becomes breadth and vice versa
      {
        x1=100+size/2;
        y1=posY+size;
        a1=size*2.5;
        b1=size;
      }
      else
      {
         x1= 100+size/2;
         y1=posY+size;
         a1=size;
         b1=size*2.5;
      }
  
  for(int i=0;i<bird.size();i++)   // Collision with Bird
    {
      
   if(bird.get(i).collided(x1,y1,a1,b1))
   {
      game=1;  // To load GAME OVER Screen
      t=0;   // To start time from starting
      blue=new ArrayList<Shield>();
      bird = new ArrayList<Bird>();
      obstacles = new ArrayList<Smallcone>();
      badal = new ArrayList<Cloud>();
      col=1;
   }
    }
  for(int i=0;i<obstacles.size();i++)   // collsion with cones
    {
      
       if(obstacles.get(i).collided(x1,y1,a1,b1))
       {
          game=1;
          t=0;
          blue=new ArrayList<Shield>();
          obstacles = new ArrayList<Smallcone>();
          bird = new ArrayList<Bird>();
          badal = new ArrayList<Cloud>();
          col=1;
        }
  
   } 
   for(int i=0;i<blue.size();i++)
    {
      
       if(blue.get(i).collided(x1,y1,a1,b1))
       {
          blue=new ArrayList<Shield>();
          bluecol=1;
        }
  
   } 
   
}
//------------------------------------------------------------------------
  void addSmall()   // function to add new cone in the frame
  {
    //obstacle2.add(obstacles.collided(50+10,height-100-(posY+size)+20,size,size*2));
    Smallcone temp=new Smallcone();
    obstacles.add(temp);  // adding cone in obstacle array list
  }
  void addGround()
  {
    Ground temp=new Ground();
    obstacle1.add(temp);
  }
  void addBird()
  {
    int k=floor(random(0,2));  
    Bird temp=new Bird(k);
    bird.add(temp);
  }
  void addCloud()
  {
    Cloud temp=new Cloud();
    badal.add(temp);
  }
  void addShield()
  {
    Shield temp=new Shield();
    blue.add(temp);
  }
  
  };

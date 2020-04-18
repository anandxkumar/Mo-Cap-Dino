Player player;   // player is object of class  Player
float t=0;   // To start time from starting when collision
int shieldpop=0;  // Minimum Time To Spawn PowerUp
int col=0,i=0;    // col is to check whether player has collided
int highscore=0;   // to show highscore of the game
int[] score =new int[1000];  // To Store Score and Use to shpow High Score
int timePeriod=0;  // used to spawn ground and clouds after a certain time period
int index=0;    // TO COUNT NO. OF DEATHS
int count=0;    // TO GENERATE CONES OR BIRDS
boolean duck=false; // DUCK 
int game=0;  // IF COLLISION OCCURS THEN GAMEOVER SCREEN SHOULD APPEAR

// Images Loading

PImage cloud;
PImage smallCone;
PImage playerJump;
PImage playerRun1;
PImage playerRun2;
PImage playerDuck1;
PImage playerDuck2;
PImage bird1;
PImage bird2;
PImage playerJumpk;
PImage playerRun1k;
PImage playerRun2k;
PImage playerDuck1k;
PImage playerDuck2k;
PImage shield;
PImage gameover;

boolean checkPrime(int n)  
{
  boolean flag = false;
  for(int i = 2; i <= n/2; ++i)
  {
      if(n%i == 0)
      {
          flag = true;
          break;
      }
  }
  return flag;
}

void setup()     // It Runs Once 
{
  // socket communication
  myClient = new Client(this, "127.0.0.1", 5204);
  
  size(1280,720);
  player=new Player();
  smallCone = loadImage("SMALLCONE.png");
  playerJump = loadImage("PLAYERJUMP.png");
  playerRun1 = loadImage("PLAYERRUN1.png");
  playerRun2 = loadImage("PLAYERRUN2.png");
  playerDuck1 = loadImage("PLAYERDUCK1.png");
  playerDuck2 = loadImage("PLAYERDUCK2.png");
  bird1 = loadImage("BIRD1.png");
  bird2 = loadImage("BIRD2.png");
  cloud=loadImage("CLOUD.png");
  playerJumpk = loadImage("PLAYERJUMPK.png");
  playerRun1k = loadImage("PLAYERRUN1K.png");
  playerRun2k = loadImage("PLAYERRUN2K.png");
  playerDuck1k = loadImage("PLAYERDUCK1K.png");
  playerDuck2k = loadImage("PLAYERDUCK2K.png");
  shield = loadImage("SHIELD.png");
  gameover = loadImage("GAMEOVER.png");
}


void draw()    // It Runs 60 times in a second
{
  frameRate(60);
  fill(0); 
  ////////Receives 
  if (myClient.available() > 0) { 
    dataIn = myClient.read();
    //myClient.write('c');
  } 
  //background(dataIn); 
  if (dataIn == 'u')
  {
   if(player.posY>0)  // If the player is in air then space key won't work
    {
      
    }
    else
    {
      player.velY=11;
    } 
    dataIn=' ';
  }
  if (dataIn == 'd')
  {
   if(player.posY>0)  // If the player is in air then space key won't work
    {
      duck=false;
    }
    else
    {
      duck=true;
      time=1;
    }     
    dataIn = ' ';
   }
  
  
  //////////////////
  if(game==1)    // Means Collision has occured and GAMEOVER 
  {
     image(gameover,100,0);  
  }
  else
  {
  score[index]=score[index]+1;
  i++;
  background(255);  // background becomes white when frame refreshes
  stroke(0);  // coor of line is set to black
  line(0,height-100,width,height-100); // initial and final coordinates
  player.move(); // shows all elements int the game
  player.show();    // moves all the elements in the game
  
  int r1=floor(random(1,4));
  
    
  if(timePeriod<120)
  {
    timePeriod++;
      
      if((timePeriod==1 || timePeriod==30  || timePeriod==60 )  && (r1==1 || r1==2))   // TO ADD LINES RANDOMLY ON GROUND
      {
        player.addGround();
      }
    
      if(timePeriod==1 && r1==2)   // TO ADD CLOUDS 
      {
         player.addCloud(); 
      }
  }
  else
  {
   timePeriod=0;
   count++;
   if( count % 10 == 0)
   {
     player.addSmall();
   }
   else if (count % 5 == 0) 
   {
     
     player.addBird();
      
   }
 }
 shieldpop++;
 
 if(shieldpop==600)
 {
   if(r1==1 )
      {
        player.addShield(); 
      }
   shieldpop=0;
 }
  
  if(bluecol==1)  // If the player has acquired shield then collision will be disable
  {
    
  }
  else
  {
    player.collision();  // checks whether player has collided or not
  }
  player.texts();   // prints all the texts
  if(col==1)
  { 
    col=0;
    index++;
    score[index]=0;
  }
  }
}

void keyPressed()    // When key is pressed jump or duck will be initated
{
  switch(key)
  {
    case ' ' :   // space
              if(player.posY>0)  // If the player is in air then space key won't work
              {
              }
              else
              {
                player.velY=11;
              }
    case 'x' : if(player.posY>0)  // If the player is in air then space key won't work
              {
                duck=false;
              }
              else
              {
                duck=true;
                time=1;
              }    
    case 'f' : game=0;    // Restarts The Game 
            
  }
}

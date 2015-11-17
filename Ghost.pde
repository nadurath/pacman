class Ghost
{
  boolean North = false;
  boolean South = false;
  boolean East  = false;
  boolean West  = false;
  Boolean isOutofBox = false;
  Boolean isCloseToPacMan = false;
  int xLocation;
  int yLocation;
  int prevX;
  int prevY;
  int Yinitial = 220;
  int Xinitial;
  int ghostNum;
  int size = 25;
  int count=0;
  PImage img;
  ArrayList<pmap> MAP;
  boolean finished = false;
  
  Ghost(int numofGhost,ArrayList<pmap> pacmap)
  {
    MAP = pacmap;
    ghostNum = numofGhost;
    img = loadImage("ghost"+ghostNum%4+".jpg");
    System.out.println(ghostNum%4); 
    xLocation = 900+ghostNum*20;
    yLocation = 220;
  }
  
  boolean getOutofBox()
  {
    if(xLocation>940)
     { 
            xLocation-=2;
     }
    if(xLocation<940)
      {
            xLocation+=2;
      }
      if(ghostNum%2 == 0 && xLocation==940 && yLocation!=174)
        {
             yLocation = yLocation-2;
             System.out.println(yLocation);
        }
       else if(ghostNum%2 == 1 && xLocation==940 && yLocation!=250)
       {
            yLocation = yLocation+2;
       }
       else
       {
         
       }
     if(xLocation==940 && (yLocation == 250 || yLocation == 174))
     {
       return true;
     }
     else
     {
       return false;
     }
  }
  
  Point moving(PVector Pacman)
  {
    if(count > 120+ghostNum*15)
    {
      finished = getOutofBox();
      if(finished)
       {
         startTrackingPacman();
       }
    }
    
    int pacmanX = (int)Pacman.x;
    int pacmanY = (int)Pacman.y;
    if(xLocation>1280)
    {
      xLocation=640;
    }
    if(yLocation>480)
    {
      yLocation=0;
    }
    for(pmap mapVals: MAP)
    {
      int[] temp = mapVals.vals();
      int x = temp[0];
      int y = temp[1];
      int xSize = temp[2];
      int ySize = temp[3];
      if((xLocation>x-size && xLocation<x+xSize) && (yLocation>y-size && yLocation<y+ySize))
         { 
           yLocation = prevY;
           xLocation = prevX;
         }
     }
      image(img,xLocation,yLocation,size,size);
      prevY = yLocation;
      prevX = xLocation;
    if(isOutofBox)
    {
      if(isCloseToPacMan)
      {
        if(xLocation>pacmanX)
        {
          xLocation = xLocation-2;
        }
        else if(xLocation == pacmanX)
        {
          if(yLocation == pacmanY)
          {
            
          }
          if(yLocation>pacmanY)
          {
            if(Math.abs(yLocation-pacmanY)<3)
              yLocation = pacmanY;
              else
               yLocation = yLocation-2;
          }
          else
          {
            if(Math.abs(yLocation-pacmanY)<3)
              yLocation = pacmanY;
              else
              yLocation = yLocation+2;
          }
        }
        else
        {
          xLocation = xLocation+2;
        }
      }
      else
      {
        
      } 
    }
    else
    {
      if(yLocation>220)
      {
        if(count%5==0)
        {
          yLocation = Yinitial-2;
        }
      }
      else
      {
        if(count%5==0)
        {
          yLocation = Yinitial+2;
        }
      }
    }
    count++;
    Point temp = new Point(yLocation,xLocation);
    return temp;
  }
  
  void startTrackingPacman()
  {
    isCloseToPacMan = true;
    isOutofBox = true;
  }
  
  
}


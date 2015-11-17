class Pacman
{
  boolean North = false;
  boolean South = false;
  boolean East  = false;
  boolean West  = false;
  boolean xchanged = false;
  boolean ychanged = false;
  int xLocation;
  int yLocation;
  int prevX;
  int prevY;
  int size = 27;
  int Yinitial = 200;
  int Xinitial;
  int count=0;
  PImage img;
  ArrayList<pmap> MAP;

  Pacman(ArrayList<pmap> pacmap) 
  {
    MAP = pacmap;
    img = loadImage("pacmanEast.jpg");
    xLocation = 666;
    yLocation = 52;
    
  }

  PVector moving(PVector p, int depth)
  {
    if(xLocation>1280)
       xLocation=640;
    if(yLocation>480)
       yLocation=0;
    if(xLocation<640)
       xLocation=1280;
    if(yLocation<0)
       yLocation=480;
    for(pmap mapVals: MAP)
    {
      int[] temp = mapVals.vals();
      int x = temp[0];
      int y = temp[1];
      int xSize = temp[2];
      int ySize = temp[3];
      if((xLocation>x-size && xLocation<x+xSize) && (yLocation>y-size && yLocation<y+ySize))
         { 
           xLocation= prevX;
           yLocation = prevY;
         }
    }
    image(img, xLocation, yLocation, size, size);
    prevY = yLocation;
    prevX = xLocation;
    if (GameStart)
    {
      if (depth<1050 && p.x<320 && p.x>250)
      {
        fill(247,179,5);
        rect(0,0,640,480);
        img = loadImage("pacmanNorth.jpg");
        yLocation = yLocation-2;
      } 
      else if (depth>1100 && p.x<320 && p.x>250)
      {
        fill(44,247,5);
        rect(0,0,640,480);
        img = loadImage("pacmanSouth.jpg");
        yLocation = yLocation+2;
      } 
      else if (p.x<250)
      {
        fill(5,39,247);
        rect(0,0,640,480);
        img = loadImage("pacmanWest.jpg");
        xLocation = xLocation-2;
      } 
      else if (p.x>320)
      {
        fill(166,5,247);
        rect(0,0,640,480);
        img = loadImage("pacmanEast.jpg");
        xLocation = xLocation+2;
      }
    }
    PVector loc = new PVector(xLocation,yLocation);
    count++;
    return loc;
  }
}


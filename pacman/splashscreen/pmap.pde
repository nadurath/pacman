class pmap
{
  int xLocation;
  int yLocation;
  int xLength;
  int yLength;
  int[] values = new int[4];
  
  pmap(int xLoc,int yLoc,int xL,int yL)
  {
    xLocation = xLoc+640;
    yLocation = yLoc;
    xLength = xL;
    yLength = yL;
    values[0] = xLocation;
    values[1] = yLocation;
    values[2] = xLength;
    values[3] = yLength;
  }
  
  void display()
  {
    fill(255);
    noStroke();
    rect(xLocation,yLocation,xLength,yLength);
  }
  
  int[] vals()
  {
    return values;
  }
  
}

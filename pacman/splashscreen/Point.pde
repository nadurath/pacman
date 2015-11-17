class Point {
  int x;
  int y;
  int size;

  Point(int xLoc, int yLoc) {
    x = xLoc;
    y = yLoc;
    size = 7;
  }
  
  void display()
  {
    noStroke();
    fill(255);
    ellipse(x,y,size,size);
  }
}

 

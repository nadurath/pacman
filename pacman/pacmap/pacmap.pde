import SimpleOpenNI.*;

SimpleOpenNI kinect;
PImage img;

void setup()
{
  size(640,480);
  background(0);
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableUser();
}

void draw()
{
  kinect.update();
  background(0);
  int[] userList = kinect.getUsers();
  
  for(int i = 0; i<userList.length; i++)
  {
    int userId = userList[i];
    PVector position = new PVector();
    kinect.getCoM(userId, position);
    
    kinect.convertRealWorldToProjective(position, position);
    fill(255,0,0);
    //ellipse(position.x, position.y, 25, 25);
  }
  
  fill(255);
  //fill(124,129,255);
  stroke(255,255,0);
  //noStroke();
  strokeWeight(1);
  //strokeWeight(3);
  img = loadImage("pacman.jpg");
  //image(img,0,0);
  rect(0,0,640,10);
  rect(0,0,25,150);
  rect(0,150,125,15);
  rect(0,200,125,15);
  rect(115,150,15,65);
  
  rect(0,245,130,15);
  rect(0,290,125,10);
  rect(115,245,15,55);
  rect(0,290,25,190);
  rect(0,470,640,10);
  rect(25,375,45,15);
  
  
  rect(65,40,70,30);
  rect(500,40,70,30);
  
  rect(170,40,95,30);
  rect(370,40,95,30);
  
  rect(305,10,25,65);
  
  rect(65,100,70,15);
  rect(500,100,70,15);
  
  rect(505,290,190,10);
  
  rect(615,290,25,190);
  rect(615,10,25,145);
  
  rect(570,375,45,15);
  
  rect(505,245,15,50);
  rect(505,245,135,15);
  
  rect(505,145,135,15);
  
  rect(505,200,135,15);
  rect(505,145,15,65);
  
  rect(60,330,70,15);
  rect(115,330,15,60);
  
  rect(505,330,70,15);
  rect(505,330,15,60);
  
  rect(370,420,200,15);
  rect(60,420,200,15);
  
  rect(175,380,15,40);
  rect(445,380,15,40);
  
  rect(245,380,145,15);
  rect(310,395,15,40);
  
  rect(245,285,145,15);
  rect(310,300,15,40);
  
  rect(245,105,145,15);
  rect(310,120,15,40);
  
  rect(170,330,90,15);
  rect(370,330,90,15);
  
  rect(170,240,25,60);
  rect(440,240,25,60);
  
  rect(170,105,25,100);
  rect(195,145,60,15);
  
  rect(440,105,25,100);
  rect(370,145,70,15);
  
  rect(240,195,60,5);
  rect(240,195,5,55);
  
  rect(330,195,60,5);
  rect(385,195,5,55);
  
  rect(240,245,60,5);
  rect(330,245,60,5);
  
  fill(0,0,255);
  text(mouseX + ", " + mouseY,mouseX,mouseY);
}


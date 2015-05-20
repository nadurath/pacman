import java.io.*;
import java.util.*;
import java.awt.*;
import SimpleOpenNI.*;
PFont f;
SimpleOpenNI kinect;

Point test;

int drawRuns = 0;
Boolean GameStart = false;
Ghost redGhost;
Ghost blueGhost;
Ghost pinkGhost;
Ghost sunsentOrangeGhost;
Pacman PacMan;

int[] userMap;
ArrayList<pmap> Map;

void setup()
{
  size(640*2, 480);
  background(0);
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableUser();
////////////////////////////////////////
  Map = new ArrayList<pmap>();
  test = new Point(680,240);
  Map.add(new pmap(0,0,640,10));
  Map.add(new pmap(0,0,25,150));
  Map.add(new pmap(0,150,125,15));
  Map.add(new pmap(0,200,125,15));
  Map.add(new pmap(115,150,15,65));
  
  Map.add(new pmap(0,245,130,15));
  Map.add(new pmap(0,290,125,10));
  Map.add(new pmap(115,245,15,55));
  Map.add(new pmap(0,290,25,190));
  Map.add(new pmap(0,470,640,10));
  Map.add(new pmap(25,375,45,15));
  
  
  Map.add(new pmap(65,40,70,30));
  Map.add(new pmap(500,40,70,30));
  
  Map.add(new pmap(170,40,95,30));
  Map.add(new pmap(370,40,95,30));
  
  Map.add(new pmap(305,10,25,65));
  
  Map.add(new pmap(65,100,70,15));
  Map.add(new pmap(500,100,70,15));
  
  Map.add(new pmap(505,290,190,10));
  
  Map.add(new pmap(615,290,25,190));
  Map.add(new pmap(615,10,25,145));
  
  Map.add(new pmap(570,375,45,15));
  
  Map.add(new pmap(505,245,15,50));
  Map.add(new pmap(505,245,135,15));
  
  Map.add(new pmap(505,145,135,15));
  
  Map.add(new pmap(505,200,135,15));
  Map.add(new pmap(505,145,15,65));
  
  Map.add(new pmap(60,330,70,15));
  Map.add(new pmap(115,330,15,60));
  
  Map.add(new pmap(505,330,70,15));
  Map.add(new pmap(505,330,15,60));
  
  Map.add(new pmap(370,420,200,15));
  Map.add(new pmap(60,420,200,15));
  
  Map.add(new pmap(175,380,15,40));
  Map.add(new pmap(445,380,15,40));
  
  Map.add(new pmap(245,380,145,15));
  Map.add(new pmap(310,395,15,40));
  
  Map.add(new pmap(245,285,145,15));
  Map.add(new pmap(310,300,15,40));
  
  Map.add(new pmap(245,105,145,15));
  Map.add(new pmap(310,120,15,40));
  
  Map.add(new pmap(170,330,90,15));
  Map.add(new pmap(370,330,90,15));
  
  Map.add(new pmap(170,240,25,60));
  Map.add(new pmap(440,240,25,60));
  
  Map.add(new pmap(170,105,25,100));
  Map.add(new pmap(195,145,60,15));
  
  Map.add(new pmap(440,105,25,100));
  Map.add(new pmap(370,145,70,15));
  
  Map.add(new pmap(240,195,60,5));
  Map.add(new pmap(240,195,5,55));
  
  Map.add(new pmap(330,195,60,5));
  Map.add(new pmap(385,195,5,55));
  
  Map.add(new pmap(240,245,60,5));
  Map.add(new pmap(330,245,60,5));

///////////////////////////////////////
  f = loadFont("TrebuchetMS-48.vlw");
  textFont(f, 48);
  textAlign(CENTER);
  redGhost = new Ghost(1,Map);
  blueGhost= new Ghost(2,Map);
  pinkGhost= new Ghost(3,Map);
  sunsentOrangeGhost= new Ghost(4,Map);
  PacMan = new Pacman(Map);
  GameStart = true;
  
}

//boolean sketchFullScreen() 
{
  //return true;
}

void draw()
{
  background(0);
  kinect.update();
  
  for(pmap p:Map)
    p.display();
  
  stroke(5);
  test.display();
  fill(0,255,255);
  rect(250,255,70,15);

  int[] users = kinect.getUsers();

  if (users.length>0)
  { 
      int userId = users[0];
      if (kinect.isTrackingSkeleton(userId))
      {
        PVector position = new PVector();
        kinect.getCoM(userId, position);
        kinect.convertRealWorldToProjective(position, position);
        PVector pac = PacMan.moving(position,(int)position.z);
        redGhost.moving(pac);
        blueGhost.moving(pac);
        pinkGhost.moving(pac);
        sunsentOrangeGhost.moving(pac);
        fill(0,255,255);
        rect(250,255,70,15);
        fill(255, 0, 0);
        ellipse(position.x, map(position.z,750,1200,150,300), 10, 10); 
    }
  }
  //System.out.println(mouseX+"   "+mouseY);
  drawRuns++;
}

void drawJoint(int userId, int jointId)
{
  PVector joint = new PVector();
  float confidence = kinect.getJointPositionSkeleton(userId, jointId, joint);

  if (confidence < 0.5)
    return;
  PVector cjoint = new PVector();
  kinect.convertRealWorldToProjective(joint, cjoint);
  fill(0, 255, 255);
  ellipse(cjoint.x, cjoint.y, 20, 20);
}


void onNewUser(SimpleOpenNI ourNI, int userId)
{
  println("Reach for the Skyyyy");
  kinect.startTrackingSkeleton(userId);
}


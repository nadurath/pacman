import SimpleOpenNI.*;

PFont f;
PImage redGhost;
PImage blueGhost;
PImage pac;
PImage pacClosed;
PVector rightHand;
PVector leftHand;
int xLoc;
SimpleOpenNI kinect;

void setup()
{
  size(640, 480);
  background(73, 13, 13);
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableUser();
  xLoc = -50;
  redGhost = loadImage("redghost.jpg");
  blueGhost = loadImage("blueghost.jpg");
  pac = loadImage("pacopen.jpg");
  pacClosed = loadImage("pacclosed.jpg");
  f = loadFont("FuturaBT-Medium-26.vlw");  
  textFont(f, 26);
  textAlign(CENTER);
  imageMode(CENTER);
}

void draw()
{
  kinect.update();

  PImage depth = kinect.depthImage();
  PImage user = kinect.userImage();


  boolean leftIn = false;
  boolean rightIn = false;
  //image(user, 0, 0);
  int[] users = kinect.getUsers();

  background(73, 13, 13);
  text("Welcome to Kinect Pacman!", width/2, height/2-25);
  text("Place hands in the corresponding ghosts to continue.", width/2, height/2+25);
  image(redGhost, width/2+200, 100, 100, 100);
  image(blueGhost, width/2-200, 100, 100, 100);

  for (int i = 0; i<users.length; i++)
  { 
    int userId = users[i];

    if (kinect.isTrackingSkeleton(userId))
    {
      drawJoint(userId, SimpleOpenNI.SKEL_LEFT_HAND);
      drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_HAND);
    }

    rightHand = new PVector();
    leftHand = new PVector();

    kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_HAND, rightHand);
    kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_HAND, leftHand);
    kinect.convertRealWorldToProjective(leftHand, leftHand);
    kinect.convertRealWorldToProjective(rightHand, rightHand);

    if((leftHand.x >= 70 && leftHand.x <= 170) && (leftHand.y > 50 && leftHand.y < 150))
      leftIn = true;
    else
      leftIn = false;
      
    if((rightHand.x >= 450 && rightHand.x <= 600) && (rightHand.y > 50 && rightHand.y < 150))
      rightIn = true;
    else
      rightIn = false;
      
    if(leftIn == true && rightIn == true)
       System.out.println("alright");
    else
       System.out.println("butt");
    //if ((rightHand.x > width/2+100 && leftHand.x < width/2+300))
    //System.out.println("AAPAOWIEJ");
  }

  xLoc+=4;

  if (xLoc == 690)
    xLoc = -50;

  if (xLoc%60<30)
    image(pacClosed, xLoc, 380, 100, 100);
  else
    image(pac, xLoc, 380, 100, 100);
}

void drawSkeleton(int userId)
{
  stroke(255, 0, 0);
  strokeWeight(5);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_HEAD, SimpleOpenNI.SKEL_NECK);

  kinect.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_LEFT_SHOULDER);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_LEFT_ELBOW);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, SimpleOpenNI.SKEL_LEFT_HAND);

  kinect.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_RIGHT_ELBOW);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, SimpleOpenNI.SKEL_RIGHT_HAND);

  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_TORSO);

  kinect.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_LEFT_HIP);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_RIGHT_HIP);

  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_HIP, SimpleOpenNI.SKEL_LEFT_KNEE);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_KNEE, SimpleOpenNI.SKEL_LEFT_FOOT);

  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_RIGHT_KNEE);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, SimpleOpenNI.SKEL_RIGHT_FOOT);

  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_LEFT_HIP);

  noStroke();
  fill(255, 255, 255);

  drawJoint(userId, SimpleOpenNI.SKEL_HEAD);
  drawJoint(userId, SimpleOpenNI.SKEL_NECK);
  drawJoint(userId, SimpleOpenNI.SKEL_TORSO);
  drawJoint(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER);
  drawJoint(userId, SimpleOpenNI.SKEL_LEFT_ELBOW);
  drawJoint(userId, SimpleOpenNI.SKEL_LEFT_HIP);
  drawJoint(userId, SimpleOpenNI.SKEL_LEFT_KNEE);
  drawJoint(userId, SimpleOpenNI.SKEL_LEFT_FOOT);
  drawJoint(userId, SimpleOpenNI.SKEL_LEFT_HAND);
  drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW);
  drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_HIP);
  drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_KNEE);
  drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_FOOT);
  drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_HAND);
}

void drawJoint(int userId, int jointId)
{
  PVector joint = new PVector();

  float confidence = kinect.getJointPositionSkeleton(userId, jointId, joint);
  if (confidence < .5)
    return;

  PVector cJoint = new PVector();
  kinect.convertRealWorldToProjective(joint, cJoint);

  //fill(73, 13, 13);
  ellipse(cJoint.x, cJoint.y, 10, 10);
}

void onNewUser(SimpleOpenNI blaze, int blaze1)
{
  //println("blaze blaze blaze blaze blaze blaze blaze REACH FOR THE SKY blaze blaze blaze blaze blaze blaze");
  kinect.startTrackingSkeleton(blaze1);
}


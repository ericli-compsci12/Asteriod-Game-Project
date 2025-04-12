//--------------------------------------------------------------
//**************************************************************
// THIS PAGE CREATES THE BULLET IN THE GAME
//**************************************************************
//--------------------------------------------------------------
class Bullet extends GameObject {
  //PVector loc;//bullet location
  //PVector vel;//bullet velocity
  
  //times the bullet
  int timer;
  
  Bullet () {
    //loc = new PVector(player1.loc.x,player1.loc.y);
    //loc = player1.loc.copy();
    //vel = player1.vel.copy();
    super(player1.loc.copy(),player1.dir.copy());
    

    vel.setMag(10);
    timer = 60;
    d = 5;
    lives = 1;
  }
  
  void show () {
    fill(black);
    stroke(white);
    strokeWeight(2);
    circle(loc.x,loc.y,d);
  }
  
  void act () {
    loc.add(vel);
    timer--;
    if (timer == 0) {
     lives = 0;
    }
    
    wrapAround();
  }
  
  
    
    
  }
  

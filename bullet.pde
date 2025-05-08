//--------------------------------------------------------------
//**************************************************************
// THIS PAGE CREATES THE BULLET IN THE GAME
//**************************************************************
//--------------------------------------------------------------

//--------------------------------------------------------------
//Bullet Class:Makes bullets
//--------------------------------------------------------------
class Bullet extends GameObject {
  //PVector loc;//bullet location
  //PVector vel;//bullet velocity
  
  //times the bullet
  int timer;
  //checks whether the bullet is from the player
  boolean frompl;
  
  
  Bullet (boolean fromp) {
    //loc = new PVector(player1.loc.x,player1.loc.y);
    //loc = player1.loc.copy();
    //vel = player1.vel.copy();
    //makes sure it shoots from the spaceship
    super(player1.loc.copy(),player1.dir.copy());
    if (fromp == true) {
      frompl = true;
    }
  else if (fromp == false) {
    frompl = false; 
  }
    //Time it 
    vel.setMag(10);
    timer = 60;
    d = 5;
    //Die when collided
    lives = 1;
  }
  
  
  Bullet(PVector startLoc, PVector startVel, boolean fromp) {
    super(startLoc.copy(), startVel.copy());
    if (fromp == true) {
      frompl = true;
    }
  else if (fromp == false) {
    frompl = false; 
  }
    this.vel.setMag(10);   // ensure consistent speed
    this.timer = 60;       // bullet lives for 60 frames
    this.d = 5;            // diameter
    this.lives = 1;        // one hit
  }

  
  //draw the bullet
  void show () {
    fill(black);
    if (frompl == true) {
    stroke(white);
    }
    else if (frompl == false)
    {
      stroke(red);
    }
    strokeWeight(2);
    circle(loc.x,loc.y,d);
  }
  
  //disappear automatically when timer is 0
  void act () {
    loc.add(vel);
    timer--;
    if (timer == 0) {
     lives = 0;
    }
    
    //wrap around the screen
    wrapAround();
  } 
 }
  

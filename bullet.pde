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
    
    if (frompl) {
      loc.set(ship.loc);
      vel.set(ship.dir.copy().mult(10)); 
    } else {
      // UFO bullet - find UFO and target player
      UFO shooter = findUFO();
      if (shooter != null) {
        loc.set(shooter.loc);
        PVector direction = PVector.sub(ship.loc, shooter.loc).normalize();
        vel.set(direction.mult(13)); 
      }
    }
  }
  
  UFO findUFO() {
    for (GameObject obj : objects) {
      if (obj instanceof UFO) return (UFO) obj;
    }
    return null;
  }
  
  //draw the bullet
  void show () {
    fill(black);
    stroke(white);
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
  

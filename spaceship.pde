//--------------------------------------------------------------
//**************************************************************
// THIS PAGE CREATES THE PLAYER SPACESHIP IN THE GAME 
//**************************************************************
//--------------------------------------------------------------
class Spaceship extends GameObject {
  
  //Instance variables
  //PVector loc;//location
  //PVector vel;//velocity
  PVector dir;//direction
  int cooldown;
  
  //Speed limit 
  
  final float MAX_SPEED = 7;
  
  //spaceship position
  PVector iconloc;
  int angle;
  float scale;
  
  //teleport cooldown
  //reset it 
  int teleportCooldown = 0;
  //15s
  final int timer = 900;

  //constructor
  Spaceship() {
    //loc = new PVector(width/2,height/2);
    //vel = new PVector(0,0);
    super(width/2,height/2,0,0);
    dir  = new PVector(0,-1);
    cooldown = 0;
    lives = 3;
  }
  //behaviour function
  void show() {
    pushMatrix();
    translate(loc.x,loc.y);
    rotate(dir.heading());
    scale(1.5);
    drawShip();
    popMatrix();
  }
  
  void icon (PVector il,int ag,float sc) {
    angle = ag;
    iconloc = il;
    scale = sc;
    pushMatrix();
    translate(il.x,il.y);
    rotate(radians(ag));
    scale(sc);
    drawShip();
    popMatrix();
    
  }
  
  
  void drawShip() {
    fill(black);
    stroke(white);
    strokeWeight(2);
    triangle(-5,-15,-5,15,20,0);//wings
    line(-5,-15,5,-15);//left antena
    line(-5,15,5,15);//right antena
    strokeWeight(1);
    line(0,-12,0,12);//wing detail
    strokeWeight(2);
    triangle(-10,-10,-10,10,30,0);//body
    strokeWeight(1);
    line(-6,-8,-6,8);//body detail
    line(-6,0,7,0);//body detail
    circle(9,0,5);
    line(12,0,30,0);//body detail
    if (upkey) {
      effect();
    }
  }
  
  void effect() {
    fill(black);
    stroke(white);
    strokeWeight(2);
    
    //random size
    float fSize = random(10, 20); //flicker size
    
    triangle(-20, -5, 
            -20 - fSize, 0, 
            -20, 5);
  }
  
  void act () {
    move();
    applySpeedLimit();//Enforce speed limit
    shoot();
    wrapAround();
    
    //timer
     if (teleportCooldown > 0) {
    teleportCooldown--;
  }
  
     if (zkey && teleportCooldown <= 0) {
        boolean validPosition = false;
        int attempts = 0;
        PVector newLoc = new PVector();
        
        // Try up to 100 times to find valid position
        while (!validPosition && attempts < 100) {
            newLoc.x = random(10, width-10);
            newLoc.y = random(10, height-10);
            validPosition = true;
            
            // Check against all asteroids
            for (GameObject obj : objects) {
                if (obj instanceof Asteriod) {
                    if (dist(newLoc.x, newLoc.y, obj.loc.x, obj.loc.y) < 200) {
                        validPosition = false;
                        break; // Exit loop early if any asteroid is too close
                    }
                }
            }
            
            attempts++;
        }

        if (validPosition) {
            loc.set(newLoc);
            vel.setMag(0);
            teleportCooldown = timer;
        }
    }
  }
  
  //enforce speed limit
   void applySpeedLimit() {
    if (vel.mag() > MAX_SPEED) {
      vel.setMag(MAX_SPEED);
    }
  }
  
  void move () {
    loc.add(vel);
    if(upkey) vel.add(PVector.mult(dir, 0.5));
    else {
    vel.mult(0.98); }
    if (leftkey) dir.rotate(-radians(3)); 
    if (rightkey) dir.rotate(radians(3)); 
  }
  
  void shoot() {
     cooldown = cooldown-1;
    if (spacekey && cooldown <= 0 ) {
    objects.add (new Bullet());
    cooldown = 15;
    }
  }
  
  
 
  
  
}

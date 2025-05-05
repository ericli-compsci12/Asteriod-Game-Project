//--------------------------------------------------------------
//**************************************************************
// THIS PAGE CREATES THE NPC IN THIS GAME
//**************************************************************
//--------------------------------------------------------------
class UFO extends GameObject {
  int timer=0;//times the time when the ufo first appears
  boolean npcalive;
  PVector initialVel; // Store the initial velocity
  int cooldown=0;
  
  UFO(PVector loc, PVector vel) {
    super(loc, vel);
    this.d = 100; // Size of UFO
    lives = 1;
    this.initialVel = vel.copy(); // Capture initial velocity
  }

  void act() {
  // Adjust y velocity towards the spaceship
  Spaceship ship = null;
  for (GameObject obj : objects) {
    if (obj instanceof Spaceship) {
      ship = (Spaceship) obj;
      break;
    }
    shoot2();
  }
  if (ship != null) {
    npcalive = true;
    float dy = ship.loc.y - this.loc.y;
    // Set Y velocity to move towards the spaceship at 2 per frame
    if (dy >= 2)
    {
      vel.y = 2;
    }
    else if (dy <=-2)
    {
      vel.y = -2;
    }
    else if ((dy >= -2) && (dy <= 2))
    vel.y = 0;
  }
  else {
    npcalive =false;
  }
  
  // Gradually correct X velocity towards initial velocity
  float xCorrection = (initialVel.x - vel.x) * 0.01; 
  vel.x += xCorrection;

  loc.add(vel);
  checkForCollisions2(); // Detect collisions with other objects
  if (loc.x < -d || loc.x > width+d || loc.y < -d || loc.y > height+d) {
    lives = 0;
    ufoTimer = 0;
    enermy.pause();
  }
  
  if (lives == 0) {
    enermy.pause();
  }
  
  if (npcalive == true) {
    timer++;
  }
  if ((timer <= 1000) && (timer >= 0)) {
    wrapAround();
  }
}

  void show() {
    //draw the ufo to ratio
    float ratio = (float)ufo.height/ufo.width;
    float displayWidth = d;  // width
    float displayHeight = displayWidth * ratio;
    image(ufo, loc.x, loc.y, displayWidth, displayHeight);
  }
  
//--------------------------------------------------------------
// Second collision Detection System 
//--------------------------------------------------------------
  void checkForCollisions2() {
    int i = 0;
  // Repeat through all game objects
  while (i < objects.size()) {
    GameObject currentObject = objects.get(i);
    
    //ufo collision logic with asteriod
   if (currentObject instanceof Asteriod && currentObject != this) {
     //calculate distance
      float distance = dist(loc.x, loc.y, currentObject.loc.x, currentObject.loc.y);
      float minDist = d/2 + currentObject.d/2; // Minimum safe distance
      
      if (distance < minDist) {
        // Calculate collision normal
        PVector collisionNormal = PVector.sub(loc, currentObject.loc).normalize();
        
        // Calculate relative velocity
        PVector relVel = PVector.sub(vel, currentObject.vel);
        
        // Only resolve if moving towards each other
        float velAlongNormal = relVel.dot(collisionNormal);
        if (velAlongNormal > 0) return;

        // Calculate impulse ( physics based )
        float impulse = (-(1 + 1) * velAlongNormal) / (1 + 1);
        PVector impulseVec = collisionNormal.mult(impulse);
        
        // Apply velocity changes
        vel.add(impulseVec);
        currentObject.vel.sub(impulseVec);
        
        // Position correction to prevent overlap
        float penetration = minDist - distance;
        PVector correction = collisionNormal.mult(penetration / (1 + 1));
        loc.add(correction);
        currentObject.loc.sub(correction);
      }
    }
    
    else if (currentObject instanceof Spaceship) {
      //check distance
      float collisionDistance = d/2 + currentObject.d/2 + 30;
      if (dist(loc.x, loc.y, currentObject.loc.x, currentObject.loc.y) < collisionDistance) {
         if (ship.invincibilityTimer <= 0) {
        //decrease life on both sides
        lives--;
        currentObject.lives--;
        beep.rewind();
        beep.play();
        if (currentObject.lives == 2) {
          firstc.rewind();
          firstc.play();
        }
        else if (currentObject.lives == 1) {
          secondc.rewind();
          secondc.play();
        }
        else if (currentObject.lives == 0) {
          thirdc.rewind();
          thirdc.play();
        }
        ship.invincibilityTimer = ship.INVINCIBILITY_DURATION; // Reset timer
         }
        //calculate push force
        PVector collisionNormal = PVector.sub(loc, currentObject.loc).normalize();
        float force = 2.0;
        
        // Apply forces to both objects
        vel.add(PVector.mult(collisionNormal, force));
        currentObject.vel.add(PVector.mult(collisionNormal, -force * 0.8));
      }
    }
    
    else if (currentObject instanceof Bullet) {
      // check distance
      if ((dist(loc.x, loc.y, currentObject.loc.x, currentObject.loc.y) < d/2 + currentObject.d/2) && (frompl == true)) {
        //decrease life on both sides
        lives--;
        currentObject.lives--;
        enermyde.rewind();
        enermyde.play();
      }
    }
    i++;
  }
}

void shoot2() {
  cooldown = cooldown-1;
     if (cooldown <= 0) {
    objects.add(new Bullet(false));
    cooldown = 10;
  }
 }
}

void makeUFO() {
  //check if theres no ufo on screen
  for (GameObject obj : objects) {
    if (obj instanceof UFO) {
      return; // Exit function if UFO exists
    }
  }

  //left:0,right:1
  int edge = int(random(2)); 
  float x, y, vx, vy;
  float speed = 3;
  
   if (edge == 0) { // Left side
    x = 0;
    y = random(height);
    vx = speed;  // Move right
    vy = 0;
  } else { // Right side
    x = width;
    y = random(height);
    vx = -speed; // Move left
    vy = 0;
  }
  
  objects.add(new UFO(new PVector(x, y), new PVector(vx, vy))); 
}








    
  

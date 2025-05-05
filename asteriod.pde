//--------------------------------------------------------------
//**************************************************************
// ASTEROID CLASS IMPLEMENTATION 
//**************************************************************
//--------------------------------------------------------------


//--------------------------------------------------------------
//Asteriod Class:Makes asteriods
//--------------------------------------------------------------
class Asteriod extends GameObject {
  // Asteroid rotation properties
  float angle = 0; // Current rotation angle
  float spin; // Rotation speed (radians per frame)
  //asteriod size change 
  int size; // Size category (3=large, 2=medium, 1=small)
  //asteriod icon 
  PVector iconloc;//icon location
  float dia;//icon diameter
  float iconAngle = 0;//icon angle

  //Asteriod constructor(size of asteriod)
  Asteriod(int size) {
    // Initialize GameObject at random position with size parameters
    super(random(width), random(height), 1, 1);
    
    //asteriod size configurations
    this.size = size;
    lives = 1; // Each asteroid takes 1 hit to split
    d = size * 50;// Diameter based on size (150px for size 3)
    
    //asteriod random speed
    vel.setMag(random(1, 3));
    //asteriod random rotation direction
    vel.rotate(random(TWO_PI));
    //asteriod random rotation speed
    spin = random(-0.03, 0.03);
  }
  
  
//default constructor
  Asteriod() {
    this(3);//default size 3 ( maximum)
  }
 
//--------------------------------------------------------------
//display asteriod (called once)
//--------------------------------------------------------------
  void show() {
    pushStyle(); // Preserve current drawing style
    pushMatrix(); // Save current transformation matrix
    // Apply asteroid transformations
    translate(loc.x, loc.y);// Move to asteroid position
    rotate(angle); // Apply rotation
    imageMode(CENTER); //Center image on position
    image(asteriods, 0, 0, d, d); //draw image (name,x,y,width,height)
    popMatrix();// Restore transformation matrix
    popStyle(); // Restore original drawing styles
  }
 
//--------------------------------------------------------------
// Update Method (called every frame)
//--------------------------------------------------------------
  void act() {
    loc.add(vel); // Update position based on velocity
    wrap2Around(); // Handle screen wrapping
    checkForCollisions(); // Detect collisions with other objects
    angle += spin; // Update rotation angle
    
    // Handle asteroid splitting
    if (lives <= 0) {
      splitIntoSmaller(); // Break into smaller asteroids
    }
  }

//--------------------------------------------------------------
// Asteroid Splitting Logic
//--------------------------------------------------------------
  void splitIntoSmaller() {
     // Only split if not smallest size
    if (size > 1) {
      int newSize = size - 1; // Determine next size
      // Create two smaller asteroids
      for (int i = 0; i < 2; i++) {
        Asteriod smaller = new Asteriod(newSize);
        
      // Random position to prevent overlap
      smaller.loc.set(loc.x + random(-20, 20), loc.y + random(-20, 20));
        
      // Set opposing velocities with explosion force
      float angleOffset = random(-PI/4, PI/4); // Random directionan
      PVector direction = PVector.fromAngle(angle + angleOffset + (i == 0 ? 0 : PI)); //ensure flying different direction
      smaller.vel = direction.mult(random(4, 6)); // Set random velocity magnitude
      
      // Add random spin variation 
      smaller.spin = spin * 1.5 + random(-0.01, 0.01); //random rotation
      objects.add(smaller); // Add to game object list
      }
    }
  }
  
//--------------------------------------------------------------
// Screen Wrapping Logic 
//--------------------------------------------------------------
  void wrap2Around() {
  // Horizontal wrapping with 70px buffer to make it smoother
  if (loc.x - 70 > width) loc.x = -70;
  if (loc.x + 70 < 0) loc.x = width+70;
   // Vertical wrapping with 70px buffer
  if (loc.y -70 > height) loc.y = -70;
  if (loc.y +70 < 0) loc.y = height+70;
  }
  
//--------------------------------------------------------------
// Collision Detection System
//--------------------------------------------------------------
  void checkForCollisions() {
  int i = 0;
  // Repeat through all game objects
  while (i < objects.size()) {
    GameObject currentObject = objects.get(i);
    
    // Bullet Collision
    if (currentObject instanceof Bullet) {
      // check distance
      if ((dist(loc.x, loc.y, currentObject.loc.x, currentObject.loc.y) < d/2 + currentObject.d/2) && (frompl == true)) {
        //decrease life on both sides
        lives--;
        currentObject.lives--;
        hit.rewind();
        hit.play();
      }
    } 
    // Spaceship collision
    else if (currentObject instanceof Spaceship) {
      //check distance
      float collisionDistance = d/2 + currentObject.d/2 + 15;
      if (dist(loc.x, loc.y, currentObject.loc.x, currentObject.loc.y) < collisionDistance) {
         if (ship.invincibilityTimer <= 0) {
        //decrease life on both sides
        lives--;
        currentObject.lives--;
        beep.rewind();
        beep.play();
        if (currentObject.lives == 2) {
          firstc.rewind();
          firstc.play(); //<>//
         
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
     // Asteroid-Asteroid Collision
    else if (currentObject instanceof Asteriod && currentObject != this) {
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
    i++; //Move to next object
  }
}

  
//--------------------------------------------------------------
// Spinning Asteriod Icon
//--------------------------------------------------------------

void aicon (PVector il,float diam,float spinSpeed) {
    iconloc = il;
    dia = diam;
    iconAngle += spinSpeed; // Update rotation angle 
    pushStyle(); // Preserve current drawing style
    pushMatrix(); // Save current transformation matrix
    translate(il.x, il.y);// Move to requested position
    rotate(iconAngle);//give it rotation
    imageMode(CENTER); //Center image on position
    image(asteriods,0,0, diam, diam); //draw image (name,x,y,width,height)
    popMatrix();// Restore transformation matrix
    popStyle(); // Restore original drawing styles
    
  
}

 
}
  
  

    

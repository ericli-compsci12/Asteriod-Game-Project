//--------------------------------------------------------------
//**************************************************************
// THIS PAGE CREATES THE PARTICLES WHEN GAME OBJECTS EXPLODE
//**************************************************************
//--------------------------------------------------------------
class Particle extends GameObject {
  int ptimer;       // Timer for particle
  color pColor;     // Particle color
  int sides;        // Number of polygon sides
  float spin;       // Rotation speed

  Particle(PVector startLoc) {
    super(startLoc, PVector.random2D().mult(random(2, 5))); // Random direction and speed
    ptimer = 100;   // Start timer at 100 
    // Randomly select color from blue purple and bluish purple
    int colorChoice = (int) random(3);
    pColor = (colorChoice == 0) ? blue : (colorChoice == 1) ? purpblue : purple;
    d = 15;         // Diameter of particle
    lives = 1;      // dies when timer expires
    sides = 20;     // Start as icosagon
    spin = random(-0.1, 0.1); // Random rotation
  }

  void act() {
    // Update position and timer
    loc.add(vel);
    ptimer--;
    if (ptimer <= 0) lives = 0;
    // Decrease sides until triangle
    sides = max(3, 20 - (100 - ptimer)); 
  }

  void show() {
    // Fade based on timer
    float alpha = map(ptimer, 100, 0, 255, 0);
    stroke(pColor, alpha);
    noFill();
    // Draw rotating polygon
    pushMatrix();
    translate(loc.x, loc.y);
    rotate(frameCount * spin);
    polygon(0, 0, d/2, sides);
    popMatrix();
  }

//-------------------------------------------------------------------
//Polygon Drawing Function: Imported from processing official website
//-------------------------------------------------------------------

  void polygon(float x, float y, float radius, int npoints) {
    // Draw polygon with n sides
    float angle = TWO_PI / npoints;
    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * radius;
      float sy = y + sin(a) * radius;
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }
}

//--------------------------------------------------------------
//**************************************************************
// THIS PAGE CREATES THE INTRO SCREEN AT GAME START
//**************************************************************
//--------------------------------------------------------------
void intro() {
  background(black);
  background.show();
  //Font 
  all = createFont("BabaPro.ttf",100);
  // Title text
  fill(white);
  textSize(550);
  textAlign(CENTER, CENTER);
   textFont(all);
  text(  "A S T E R   I D S", width/2, 400);
 
  if (millis() - loadingStartTime > 20000 || mode == intro) {
    // Show and handle button
  myButton.text = "-     PL    Y     -";
  myButton.show();
  
  
  if (mouseReleased && myButton.isHovered()) {
    mode = game;
    ship = new Spaceship(); // Reset the ship
    ship.lives = 3;
    objects.clear(); // Clear existing objects
    objects.add(ship); // Add the new ship
    ship.teleportCooldown = 0;//reset cooldown timer
    
    // Add new asteroids with distance check
    for (int i = 0; i < 4; i++) {
      Asteriod a;
      do {
        a = new Asteriod();
      } while (dist(a.loc.x, a.loc.y, ship.loc.x, ship.loc.y) < 200);
      objects.add(a);
    
  }
  }
  
  }
    //Icon of spaceship
    ship.icon(new PVector(960,620),-90,1.5);
    //Icon of spinning asteriod
    myAsteriod.aicon(new PVector(1080,405),80,0.02);
    
   
    
  
}

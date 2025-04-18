//--------------------------------------------------------------
//**************************************************************
// THIS PAGE CREATES THE GAMING SCREEN DURING GAME
//**************************************************************
//--------------------------------------------------------------
void game() {
  background(black);
  
   drawCooldownBar();//draw the cool down of the bullet
   
    drawLifeBar();//draw the life of the ship
    
    drawTeleportBar();//draw the cooldown of the teleport 
   
   updatePlayerReference();
   
  pushStyle(); 
  pushMatrix();
  pushStyle();
  translate(bullet.width/2, bullet.height/2); // Rotate around image center
  rotate(radians(-30)); // Apply rotation
  imageMode(CENTER);
  image(bullet, 100, 50); // Draw at translated position
  popMatrix();
  popStyle();
  
  //draw teleport icon
  pushMatrix();
  scale(0.08);
  translate(1400,1300);
  teleicon();
  popMatrix();
  
  
  ship.icon(new PVector(130, 80),-45,1);
  
   if (ship.lives <= 0) {
  mode = gameover;
  popStyle();

}

  if (!isPaused) {  
    
    //game engine 
    int i = 0;
    while (i < objects.size()) {
      GameObject currentObject = objects.get(i);
      currentObject.act();
      currentObject.show();
      if (currentObject.lives <= 0 )
      {
        objects.remove(i);
      }
      else {
      i++;}                
    }
  } else {
    //Show frozen frame when paused
    player1.show();
    for (GameObject b :objects) b.show();
  }
  
  //Always draw pause screen on top if paused
  if (isPaused) drawPauseScreen();
  
  //Determine whether game is won
  if (ship.lives <= 0) {
    mode = gameover;
    gameWon = false;
  } else {
    // Check if all asteroids are destroyed
    boolean asteroidsLeft = false;
    for (GameObject obj : objects) {
      if (obj instanceof Asteriod) {
        asteroidsLeft = true;
        break;
      }
    }
    if (!asteroidsLeft) {
      mode = gameover;
      gameWon = true;
    }
  }
  
}

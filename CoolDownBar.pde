//--------------------------------------------------------------
//**************************************************************
// THIS PAGE CONTAINS THE CODE FOR THE BARS
//**************************************************************
//--------------------------------------------------------------


//--------------------------------------------------------------
//Cool Down Bar Function: draws the cooldown of the bullets
//--------------------------------------------------------------

void drawCooldownBar() {
  int barWidth = 200;    // Total width of the bar
  int barHeight = 20;    // Height of the bar
  int x = 10;            // Top-left X position
  int y = 10;            // Top-left Y position

  // Calculate fill percentage (0.0 to 1.0)
  float fillRatio = 1.0 - (ship.cooldown / 15.0);
  //contrain the ration to make sure not overflow
  fillRatio = constrain(fillRatio, 0.0, 1.0);

  // Draw background (empty part of the bar)
  noStroke();
  fill(grey); 
  rect(x, y, barWidth, barHeight);

  // Draw filled part (current cooldown progress)
  fill(green); 
  rect(x, y, barWidth * fillRatio, barHeight);

  // text labels
  fill(white);
  textSize(12);
  textAlign(LEFT, CENTER);
  text("Cooldown: " + (15 - max(ship.cooldown, 0)) + "/15", x, y + barHeight + 5);
}


//--------------------------------------------------------------
//Life Bar Function: shows how many lives the player has left
//--------------------------------------------------------------

void drawLifeBar() {
  int barWidth = 200;    // Total width of the bar
  int barHeight = 20;    // Height of the bar
  int x = 10;            // Top-left X position
  int y = 70;            // Top-left Y position

  // Calculate fill percentage (0.0 to 1.0)
  float fillRatio = ship.lives / 3.0;
  fillRatio = constrain(fillRatio, 0.0, 1.0);
   
  // Draw background (empty part of the bar)
  noStroke();
  fill(grey); 
  rect(x, y, barWidth, barHeight);

  // Draw filled part (current life)
  fill(red); 
  rect(x, y, barWidth * fillRatio, barHeight);

  // text label
  fill(white);
  textSize(12);
  textAlign(LEFT, CENTER);
  text("Lives: " + max(ship.lives, 0) + "/3", x, y + barHeight + 5);
}


//--------------------------------------------------------------
//TELEPORT COOLDOWN BAR: indicates when you can teeport
//--------------------------------------------------------------

void drawTeleportBar() {
  int barWidth = 200;    // Total width of the bar
  int barHeight = 20;    // Height of the bar
  int x = 10;            // Top-left X position
  int y = 130;           // Top-left Y position
  
  // Calculate fill percentage based on full cooldown duration
  float fillRatio = 1.0 - (ship.teleportCooldown / (float)ship.timer);
  fillRatio = constrain(fillRatio, 0.0, 1.0);
  
  // Draw background (empty part of the bar)
  noStroke();
  fill(grey); 
  rect(x, y, barWidth, barHeight);
  
  // Draw filled part (current progress)
  fill(blue); 
  rect(x, y, barWidth * fillRatio, barHeight);
  
  // Text label
  fill(white);
  textSize(12);
  textAlign(LEFT, CENTER);
  text("Teleport: " + ((ship.timer - ship.teleportCooldown)/60) + "/15s", x, y + barHeight + 5);
}

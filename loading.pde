//--------------------------------------------------------------
//**************************************************************
// THIS PAGE CREATES THE LOADING SCREEN AT GAME START 
//**************************************************************
//--------------------------------------------------------------
void loading () {
  background.show();
  background(black);
  
  // Draw background image
  pushStyle();
  imageMode(CORNER);
  image(loadingBg, 0, 0, width, height);
  popStyle();
  
  // Calculate loading progress
   elapsed = millis() - loadingStartTime;
   loadingProgress = map(elapsed, 0, 90000, 0, width);
  
  // Show loading overlay
  drawLoadingScreen();
  
  // Automatic transition after 20 seconds
  if (elapsed > 90000) {
    mode = intro;
  }
  
}


void drawLoadingScreen() {
  pushStyle();
  rectMode(CORNER);
  
  // Dark overlay
  fill(0, 200);
  rect(0, 0, width, height);
  
  // Progress bar background
  fill(white);
  rect(0, height/2 + 350, width, 5);
  
  // Calculate spaceship position along progress bar
  float shipX = map(elapsed, 0, 90000, 0, width)+10;
  float shipY = height/2 + 352; // Same Y as progress bar
  
  // Draw moving spaceship icon
  ship.icon(new PVector(shipX, shipY),0, 0.8);
  
  // Progress bar fill
  fill(green);
  rect(0, height/2 + 350, loadingProgress, 5);
  
  // Loading text
  textAlign(CENTER, CENTER);
  fill(white);
  textSize(100);
  if (elapsed > 0 && elapsed <45000) {
  text("INITIALIZING SYSTEMS...", width/2, height/2 - 100);
}
  if (elapsed > 45000 && elapsed <90000) {
  text("LOADING GAME OBJECTS...", width/2, height/2 - 100);
}
  
  //Hints text
  textSize(30);
  if ((elapsed > 0 && elapsed <10000) || (elapsed >30000 && elapsed < 40000) || (elapsed >60000 && elapsed < 70000) ) {
  text("PRESS ESC TO EXIT",width/2-50,height/2+80);
  text("PRESS ENTER TO PAUSE",width/2-50,height/2+180);}
  if ((elapsed > 10000 && elapsed <20000) || (elapsed >40000 && elapsed < 50000) || (elapsed >70000 && elapsed < 80000) ) {
  text("USE ARROW KEY TO NAVIGATE",width/2-50,height/2+80);
  text("PRESS SPACE TO SHOOT",width/2-50,height/2+180);
  }
  if ((elapsed > 20000 && elapsed <30000) || (elapsed >50000 && elapsed < 60000) || (elapsed >80000 && elapsed < 90000)) {
  text("PRESS Z or z TO TELEPORT",width/2-50,height/2+80);
  text("PRESS A or a TO SKIP THIS PAGE",width/2-50,height/2+180);
  }
  
  
  // Count down text
  textSize(40);
  text("Estimated time remaining: " + (90 - int(elapsed/1000)) + " seconds", 
       width/2, height/2 + 450);
  
  popStyle();
}

//--------------------------------------------------------------
//**************************************************************
// THIS PAGE CREATES THE PAUSE SCREEN IN THE GAME 
//**************************************************************
//--------------------------------------------------------------
void drawPauseScreen() {
  pushStyle();
  rectMode(CORNER);
  fill(0, 150); 
  rect(-20, -20, width+100, height+100);
  fill(white);
  textSize(200);
  text("PAUSED", width/2-400, height/2-100);
  textSize(50);
  text("Press ENTER to resume", width/2-350, height/2 + 160);
  popStyle();
}

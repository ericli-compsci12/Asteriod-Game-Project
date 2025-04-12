//--------------------------------------------------------------
//**************************************************************
// THIS PAGE CREATES THE GAME OVER SCREEN AT GAME END
//**************************************************************
//--------------------------------------------------------------
void gameover() {
  background(black);
  background.show();
  int count = getAsteroidCount();
  textAlign(CENTER,CENTER);

  // Display different messages based on win/loss
  if (gameWon) {
    fill(red);
    textSize(100);
    text("YOU WON !", width/2-10, 350);
    myButton.text = "PLAY AGAIN";
    myButton.show();
  } else {
    fill(red);
    textSize(100);
    text("GAME OVER", width/2, 250);
    fill(white);
    textSize(60);
    text(count+"/16 Asteriods Left", width/2, 450);
    myButton.text = "RETRY";
    myButton.show();
  }

  if (mouseReleased && myButton.isHovered()) {
    mode = intro;
    gameWon = false; // Reset win state
  }
}

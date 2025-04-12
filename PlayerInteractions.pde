//--------------------------------------------------------------
//**************************************************************
// THIS PAGE CONTAINS THE CODE FOR PLAYER INPUTS(shortcuts)
//**************************************************************
//--------------------------------------------------------------


//--------------------------------------------------------------
//Click Function: Checks whether the mouse is being pressed
//--------------------------------------------------------------
void click() {
  if (mousePressed) {
    wasPressed = true;
  } else {
    if (wasPressed) {
      mouseReleased = true;
      wasPressed = false;
    } else {
      mouseReleased = false;
    }
  }
}

//-----------------------------------------------------------------
//Key Pressed Function: Checks which key on the keyboard is pressed
//-----------------------------------------------------------------
void keyPressed () {
  if (keyCode == UP) upkey = true;
  if (keyCode == DOWN) downkey = true;
  if (keyCode == LEFT) leftkey = true;
  if (keyCode == RIGHT) rightkey = true;
  if (keyCode == ENTER) {
    //only pause during game play
    if (mode == game) isPaused = !isPaused;
    enterkey = true;
  }
  if (key == ' ') spacekey = true; 
  if (key == 'a' || key == 'A') akey = true;
  if (key == 'z' || key == 'Z') zkey = true;
   
   //admin key
   if (akey == true) {
      mode = intro;
    }
}

//----------------------------------------------------------------------
//Key Released Function: Checks which key on the keyboard is not pressed
//----------------------------------------------------------------------
void keyReleased () {
  if (keyCode == UP) upkey = false;
  if (keyCode == DOWN) downkey = false;
  if (keyCode == LEFT) leftkey = false;
  if (keyCode == RIGHT) rightkey = false;
  if (keyCode == ENTER) enterkey = false;
  if (key == ' ') spacekey = false; 
  if (key == 'a' || key == 'A') akey = false;
  if (key == 'z' || key == 'Z') zkey = false;
  
}

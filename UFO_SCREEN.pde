//--------------------------------------------------------------
//**************************************************************
// THIS PAGE CREATES THE EFFECT TO TELL PLAYER NPC ARRIVED
//**************************************************************
//--------------------------------------------------------------



//--------------------------------------------------------------
// Helper function to check if any UFO is alive
//--------------------------------------------------------------
boolean isUFOAlive() {
  for (GameObject obj : objects) {
    if (obj instanceof UFO) {
      return true;
    }
  }
  return false;
}

//--------------------------------------------------------------
// Draw red flashing edges when UFO is alive
//--------------------------------------------------------------
void drawUFOBorderEffect() {
  pushStyle();
  if (isUFOAlive()) {
    float alphaBase = 128 + 127 * sin(millis() / 200.0);
    int edgeThickness = 50;

    noStroke();
    rectMode(CORNER); 

    // Top edge (full width)
    for (int y = 0; y < edgeThickness; y++) {
      float a = alphaBase * (1.0 - (float)y / edgeThickness);
      fill(255, 0, 0, a);
      rect(0, y, width, 1); // Full width
    }

    // Bottom edge (full width)
    for (int y = 0; y < edgeThickness; y++) {
      float a = alphaBase * (1.0 - (float)y / edgeThickness);
      fill(255, 0, 0, a);
      rect(0, height - y - 1, width, 1); // Full width
    }

    // Left edge (full height)
    for (int x = 0; x < edgeThickness; x++) {
      float a = alphaBase * (1.0 - (float)x / edgeThickness);
      fill(255, 0, 0, a);
      rect(x, 0, 1, height); // Full height
    }

    // Right edge (full height)
    for (int x = 0; x < edgeThickness; x++) {
      float a = alphaBase * (1.0 - (float)x / edgeThickness);
      fill(255, 0, 0, a);
      rect(width - x - 1, 0, 1, height); // Full height
    }
  }
  popStyle();
}

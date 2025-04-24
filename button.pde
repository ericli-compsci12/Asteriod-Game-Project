//--------------------------------------------------------------
//**************************************************************
// THIS PAGE CONTAINS IMPORTED CLASS BUTTON CLASS
//**************************************************************
//--------------------------------------------------------------

//--------------------------------------------------------------
//Button Class:Makes the transition button in the game
//--------------------------------------------------------------
class Button {
  //class variables
  String text;
  int x, y, w, h;
  color normal, highlight;
  
  //constructor used
  Button(String t, int _x, int _y, int _w, int _h, color norm, color high) {
    text = t;
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    normal = norm;
    highlight = high;
  }
 
  //check if mouse is hovering
  boolean isHovered() {
    return mouseX > x - w/2 && mouseX < x + w/2 && 
           mouseY > y - h/2 && mouseY < y + h/2;
  }

  //display button
  void show() {
    pushStyle();
    // Button appearance
    rectMode(CENTER);
    strokeWeight(4);
    stroke(isHovered() ? highlight : normal);
    fill(normal);
    rect(x, y, w, h);
    
    // Text appearance
    textAlign(CENTER, CENTER);
    fill(highlight);
    textSize(60);
    text(text, x, y);
    popStyle();
  }
 }

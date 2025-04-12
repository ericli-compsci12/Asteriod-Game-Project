//--------------------------------------------------------------
//**************************************************************
// THIS PAGE CONTAINS IMPORTED CLASS BUTTON CLASS
//**************************************************************
//--------------------------------------------------------------
class Button {
  String text;
  int x, y, w, h;
  color normal, highlight;
  
  Button(String t, int _x, int _y, int _w, int _h, color norm, color high) {
    text = t;
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    normal = norm;
    highlight = high;
  }

  boolean isHovered() {
    return mouseX > x - w/2 && mouseX < x + w/2 && 
           mouseY > y - h/2 && mouseY < y + h/2;
  }

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

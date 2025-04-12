//--------------------------------------------------------------
//**************************************************************
// THIS PAGE CONTAINS IMPORTED CLASS GIF CLASS
//**************************************************************
//--------------------------------------------------------------
class Gif  {
  String before;
  String after;
  int numFrames;
  int speed;
  int x;
  int y;
  int w;
  int h;
  PImage [] gif;
  int f;
  int lastUpdate; // Track time of last frame change
  int a;//pikachu speed
  
  Gif (String bef,String aft,int numF,int spee,int _x,int _y,int _w,int _h) {
    before = bef;
    after = aft;
    numFrames = numF;
    speed = spee;
    x = _x;
    y = _y;
    w = _w;
    h = _h;
     act();
   lastUpdate = millis();
   a=0;
  }
  
  
   Gif (String befo,String afte,int numFr,int spe,int __x,int __y) {
    before = befo;
    after = afte;
    numFrames = numFr;
    speed = spe;
    x = __x;
    y = __y;  
    act();
    lastUpdate = millis();
    a=0;
  }
  
   Gif (String be,String af,int num,int sp,int ___x,int ___y,int ___w,int ___h,int _a) {
    before = be;
    after = af;
    numFrames = num;
    speed = sp;
    x = ___x;
    y = ___y;  
    w=___w;
    h=___h;
    a= _a;
    act();
    lastUpdate = millis();
  }
  
 
   void act () {
    gif = new PImage[numFrames];
    int i=0;
    
    if (w <= 0 || h <= 0) {
        w = 300; // default width
        h = 300; // default height
      }
      
   while ( i < numFrames) {
    String filename = before + i + after;
    gif[i] = loadImage(dataPath(filename));
    gif[i].resize(w,h);
    i++;
    
     
      
  }
}
  
  void show () {
   x += a;
  if (millis() - lastUpdate >= speed) {
    f = (f + 1) % numFrames; // Advance frame
    lastUpdate = millis();    // Reset timer
    
    if (x < 0) { // Left edge
    x = 0;
    a = abs(a); // Reverse direction (move right)
  } else if (x + w >= width) { // Right edge
    x = width - w; 
    a = -abs(a); // Reverse direction (move left)
  }
  
  }
  
if (a < 0) {
 
  pushMatrix();
  translate(x + w, y); 
  scale(-1, 1);        
  image(gif[f], 0, 0, w, h); 
  popMatrix();
  
} else {
  image(gif[f], x, y, w, h);
}  

}

  }

//--------------------------------------------------------------
//**************************************************************
// THIS PAGE CONTAINS THE SUPER CLASS 
//**************************************************************
//--------------------------------------------------------------
class GameObject {
  PVector loc;//location
  PVector vel;//velocity
  int lives;//how many lives
  float d; // object size

  GameObject (float lx,float ly,float vx,float vy) {
    loc = new PVector(lx,ly);
    vel = new PVector(vx,vy);
    lives = 1;
    
  }
  
  GameObject(PVector l,PVector n) {
    loc = l;
    vel = n;
    lives = 1;
  }
  
  GameObject(PVector l,PVector n,int lv) {
    loc = l;
    vel = n;
    lives = lv;
  }
  
  void act () {
   
  }
  
   void show () {
    
  }
  
  void wrapAround() {
  if (loc.x > width) loc.x = 0;
  if (loc.x < 0) loc.x = width;
  if (loc.y > height) loc.y = 0;
  if (loc.y < 0) loc.y = height;
  }
  }
    
  
  
  
 
  
 
  

//Eric Li
//April 1st
//--------------------------------------------------------------
//**************************************************************
// THIS PAGE CONTAINS THE DECLARATION & INITIALIZATION CODE OF THE PROJECT
//**************************************************************
//--------------------------------------------------------------


//--------------------------------------------------------------
// Declarations Imports and Initializations
//--------------------------------------------------------------

// Import required Minim libraries for audio handling
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

//import array list
import java.util.ArrayList;

//gif
Gif background;

// Audio system variables
Minim minim;
AudioPlayer backgroundm;
AudioPlayer enermy;
AudioPlayer firstc;
AudioPlayer secondc;
AudioPlayer beep;
AudioPlayer thirdc;
AudioPlayer fireshot;
AudioPlayer teleport;
AudioPlayer victory;
AudioPlayer loss;
AudioInput Input;

//COLOR PALLETE
//white color rgb(255,255,255)
color white = #FFFFFF;
//black color rgb(0,0,0)
color black = #000000;
//blue color rgb(0,0,255)
color blue = #0000FF;
//pink color rgb(193, 28, 132)
color pink = #C11C84;
//red color rgb(255, 0, 0)
color red = #FF0000;
//green color rgb(0, 255, 0)
color green = #00FF00;
//yellow color rgb(255, 255, 0)
color yellow = #FFFF00;
//gold color rgb(255, 215, 0)
color gold = #FFD700;
//orange color rgb(255, 165, 0)
color orange = #FFA500;
//grey color rgb(100, 100, 100)
color grey = #646464;

//MODE FRAMEWORK
int mode = 3;
//the intro mode
final int intro = 0;
//the game mode
final int game = 1;
//the gameovermode
final int gameover = 2;
//the loading mode
final int loading = 3;

//Button class
Button myButton;
boolean mouseReleased;
boolean wasPressed;

 //keyboard
  boolean upkey;
  boolean downkey;
  boolean leftkey;
  boolean rightkey;
  boolean spacekey;
  boolean enterkey;
  boolean akey;
  boolean zkey;

//Game variables
Spaceship player1; //Spaceship class instance variable 1
Spaceship ship; //Spaceship class instance variable 2
Asteriod myAsteriod = new Asteriod(); //Asteriod class instance variable

//List of game objects
ArrayList<GameObject> objects;

//Font for all text
PFont all;

// Picture upload 
PImage bullet;
PImage asteriods;
PImage loadingBg;
PImage ufo;

//Pause variable
boolean isPaused = false; 

//loading variable
int loadingStartTime;
float elapsed;
float loadingProgress;

//check if game is won
boolean gameWon = false;


//--------------------------------------------------------------
// Setup function: Initializes game window and loads resources
//--------------------------------------------------------------


void setup() {
  //size of the window 
  size(1924, 1000, P2D);
  //text aligned
  textAlign(CENTER,CENTER);
  //rectangle mode
  rectMode(CENTER);
  // Initialize button (text, x, y, w, h, normalColor, highlightColor)
  myButton = new Button("-     PLAY     -", width/2-15, height/2 + 100, 600, 100, black, white);
  //initialization of player objects
  player1 = new Spaceship();
  ship = new Spaceship(); 
   // Create a list to manage all game objects (ships, asteroids, etc.)
  objects = new ArrayList();
  //adding the main player
  objects.add(player1);
  //add the ship
  objects.add(ship);
  //adding asteriods(size is maxed)
  objects.add(new Asteriod (3));
  objects.add(new Asteriod (3));
  objects.add(new Asteriod (3));
  objects.add(new Asteriod (3));
  
  //upload pictures
  bullet = loadImage("bullet.png");//the bullet icon
  asteriods = loadImage("asteriod.png");//the asteriod picture
  loadingBg = loadImage("loading baackground.jpg");//the background of the loading page
  ufo = loadImage("ufo.png");//the ufo picture
  
  //scaling loading mode background picture 
  loadingBg.resize(0, height);
  
  // Scale the image to 1cm × 1cm (convert cm to pixels)
  float cmToPixels = 57.795;
  int targetSize = round(cmToPixels); 
  bullet.resize(targetSize, targetSize); // Resize the bullet icon image
  
  //uplod the gif
  //Gif(String before, String after, int numFrames,int speed,int x,int y,int w,int h)
  background = new Gif("background/frame_","_delay-0.04s.gif",91,25,0,0,width,height);
  
  //loading page countdown
  loadingStartTime = millis();
  
  ///load font
  all = createFont("BabaPro.ttf", 100); 
  
  // Initialize audio system
  minim = new Minim (this);
  
  // Load all audio files
  backgroundm = minim.loadFile("backgroundmusic.mp3");
  enermy = minim.loadFile("ufonpc.mp3");
  firstc = minim.loadFile("firstcollision.mp3");
  secondc = minim.loadFile("secondcollision.mp3");
  beep = minim.loadFile("27441_beep-beep-beep-beep-80262-[AudioTrimmer.com].mp3");
  thirdc = minim.loadFile("third collision.mp3");
  fireshot = minim.loadFile("space-gun-101680.mp3");
  teleport = minim.loadFile("teleport-14639.mp3");
  victory = minim.loadFile("victorymale-version-230553.mp3");
  loss = minim.loadFile("8bit-lose-life-sound-wav-97245.mp3");
   
  //loop the song
  backgroundm.loop();
}

//--------------------------------------------------------------
// Main draw loop: Handles screen updates based on game mode
//--------------------------------------------------------------

void draw() {
 
  // Update mouseReleased state
  click(); 
  
  //debugging code (monitor object array size)
 //println(objects.size()); //print size of array list
  
  // Handle current mode
  if (mode == loading) {
    loading();
  } 
  else if (mode == intro ) {
    intro();
  }
  else if (mode == game) {
    game();
  } else if (mode == gameover) {
    gameover();
  }
}

// Synchronize player object's position/direction with main ship's state
void updatePlayerReference() {
  // Copy main ship's current location to player1
  player1.loc.set(ship.loc);
  //copy main ship's current direction to player1
  player1.dir.set(ship.dir);
}

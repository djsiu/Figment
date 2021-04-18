// IAT 167 - assignment 4

// by Denise Siu
// 301403268

/*
I have created a tile based game where the player must navigate the game world and advance through 
the 3 levels and 1 boss level in order to complete the game. In each level there is a key which must 
be used to open the door to the next level. In some levels that key is behind a locked gate which only 
opens once the player defeats all the enemies in the that level.

Note: all the graphics in the game were created by me

SOURCES:
- door sound effect: https://www.youtube.com/watch?v=Kx4PBQzE60w&ab_channel=VideoPlasty
- powerup, key, punch, and hit sound effect: https://www.zapsplat.com/
- intro, gameplay, boss, endgame and lose songs: https://soundimage.org/
*/

//importing libraries
import ddf.minim.*;
import controlP5.*;

//game states
int state = 0; // intial state of the game
final int HOWTO = -1;
final int INTRO = 0;
final int LEVEL1 = 1;
final int LEVEL2 = 2;
final int LEVEL3 = 3;
final int LEVEL4 = 4;
final int ENDGAME = 5;
final int LOSE = 6;

//determine whether a level has been intialized yet
boolean setup1 = false;
boolean setup2 = false;
boolean setup3 = false;
boolean setup4 = false;
boolean setupIntro = false;
boolean setupEnd = false;
boolean setupLose = false;
boolean setupHowto = false;

//initial positions
int playerInit1 = 542;
int keyLocation1 = 148;
int powerupLocation1 = 658;
int[] enemyInit1 = {504, 655, 355};
int playerInit2 = 178;
int keyLocation2 = 84;
int powerupLocation2 = 78;
int[] enemyInit2 = {134, 163, 192, 255, 257};
int playerInit3 = 224;
int keyLocation3 = 304;
int[] enemyInit3 = {88, 356, 158, 212, 98, 123, 152, 180, 205, 233};
int[] powerupLocation3 = {338, 227};
int playerInit4 = 191;
int keyLocation4 = 67;
int powerupLocation4[] = {172, 173, 174};
int[] enemyInit4 = {98, 73, 102, 152, 156, 206, 235, 210};
int bossInit = 154;

//colours
color keyColor = color(255, 227, 0);
color textColor = color(200);
color healthColor = color(191, 54, 12);
color bulletColor = color(99, 255, 82);

//buttons 
ControlP5 cP5;
Button start;
Button restart;
Button howToPlay;
Button back;

//sounds
Minim minim;
AudioPlayer door, gameKey, powerup, punch, hit;
AudioPlayer intro, gameplay, boss, endgame, lose;
final String DOOR = "data/sound/door.mp3";
final String GAMEKEY = "data/sound/key.mp3";
final String POWERUP = "data/sound/powerup.mp3";
final String PUNCH = "data/sound/punch.mp3";
final String HIT = "data/sound/hit.mp3";
final String INTRO_SONG = "data/sound/intro.mp3";
final String GAMEPLAY_SONG = "data/sound/gameplay.mp3";
final String BOSS_SONG = "data/sound/boss.mp3";
final String ENDGAME_SONG = "data/sound/endgame.mp3";
final String LOSE_SONG = "data/sound/lose.mp3";

//other misc. variables
int speed = 2; //for moving the player in the keyboard_module
int movingState = 0; //direction the player is facing while moving around
int keyCount = 0; //counting the number of keys the player currently has
int keySize = 50; // dimensions of the key icon
boolean doorText = false; //for displaying "this door is locked"

//Objects
int tileSize = 100;
ArrayList<Tile> tiles = new ArrayList<Tile>();
ArrayList<Object> keys = new ArrayList<Object>();
ArrayList<Object> powerups = new ArrayList<Object>();
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
Character player;

void setup() {
  size(1000, 650);
  
  //setting up the font
  PFont font = loadFont("Futura-Medium-48.vlw");
  textFont(font);
  textSize(24);
  
  //setting up the buttons
  cP5 = new ControlP5(this);
  start = cP5.addButton("start", 0, width/2 - 60, height - 300, 150, 50);
  cP5.getController("start").hide();
  restart = cP5.addButton("restart", 0, width/2 - 60, height - 300, 150, 50);
  cP5.getController("restart").hide();
  howToPlay = cP5.addButton("how to play", 0, width/2 - 60, height - 225, 150, 50);
  cP5.getController("how to play").hide();
  back = cP5.addButton("back", 0, width - 200, height - 100, 150, 50);
  cP5.getController("back").hide();
  
  styleButtons();
  
  //setting up the audio
  loadSound();
}

void draw() {
  background(10);
  
  //determines which state the game is currently in 
  switch (state) {
    case INTRO: 
      intro();
      break;
    case LEVEL1:
      level1();
      break;
    case LEVEL2:
      level2();
      break;
    case LEVEL3:
      level3();
      break;
    case LEVEL4:
      level4();
      break;
    case ENDGAME:
      endGame();
      break;
    case LOSE:
      lose();
      break;
    case HOWTO:
      howTo();
      break;
    default:
      intro();
  }
}

//subclass for managing the player and its actions/status

class Player extends Character { 
  
  //arrays for holding the player's moving animations in different states
  PImage[] standing = new PImage[1];
  PImage[] walking_side = new PImage[2];
  PImage[] walking_front = new PImage[2];
  PImage[] walking_back = new PImage[2];
  PImage[] punching = new PImage[1];
  
  Player (PVector pos) {
    super(pos);
    vel = new PVector();
    dim = new PVector(50, 50);
    
    isAlive = true;
    MAX_HEALTH = 15; //maybe change back to 10?
    health = MAX_HEALTH;
    
    standing[0] = loadImage("data/player/stillFront.png");
    punching[0] = loadImage("data/player/punching.png");
    activeImgSeq = standing;
    
    for(int i = 0; i < walking_side.length; i++) {
      walking_side[i] = loadImage("data/player/side_" + i + ".png");
      walking_front[i] = loadImage("data/player/front_" + i + ".png");
      walking_back[i] = loadImage("data/player/back_" + i + ".png");
    }
  }
  
  void update() {
    super.update();
    drawDirection(); 
  }
  
  //drawing the character
  void drawMe() {
    pushMatrix();
    push();
    imageMode(CENTER);
    
    PImage img = activeImgSeq[currentImgIdx];
    if (vel.x > 0) {  //reverse image when going right
      scale(-1.0, 1.0);
      image(img, -width/2, height/2, dim.x, dim.y);
    }
    else {
      image(img, width/2, height/2, dim.x, dim.y);
    }
    
    pop();
    popMatrix();
  }
  
  //drawing the health bar on the top left hand corner of the screen
  void drawHealth() {
    int scale = 200;
    
    pushMatrix();
    translate(25, 30);
    noStroke();
    fill(textColor);
    textSize(24);
    text("health: ", 0, 0);
    
    translate(0, 15);
    fill(100);
    rect(0, 0, scale, 20);
    if(health >= 0) {
      fill(healthColor);
      float healthPercent = (float) health/MAX_HEALTH;
      rect(0, 0, scale * healthPercent, 20);
    }
    popMatrix();
  } 
  
  //for animating player moving and switching depending on the way they are facing
  void drawDirection() {
    if (frameCount % 6 == 0 ) {
      currentImgIdx++;
      
      switch(movingState) {
        case 1: //walking sideways
          if(currentImgIdx == walking_side.length) {
            currentImgIdx = 0;
          }
          activeImgSeq = walking_side;
          break;
        case 2:
          if(currentImgIdx == walking_front.length) {
            currentImgIdx = 0;
          }
          activeImgSeq = walking_front;
          break;
        case 3:
          if(currentImgIdx == walking_back.length) {
            currentImgIdx = 0;
          }
          activeImgSeq = walking_back;
          break;
        case 4:
          //println("punching case");
          currentImgIdx = 0;
          activeImgSeq = punching;
          break;
        default: //standing
          currentImgIdx = 0;
          activeImgSeq = standing;
      }
    }
  }
  
  //for the player to attack the enemy
  void attack() {
    for(int i = 0; i < enemies.size(); i++) {
      if (closeTo(enemies.get(i))) {
        enemies.get(i).health--;
        playSound(PUNCH);
      }
    }
  }
  
  //if the player dies then the game will show the game over screen
  void dead() {
    if(health == 0) {
      isAlive = false;
      state = LOSE;
    }
  }
}

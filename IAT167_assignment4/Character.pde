// this is the class used for instances of characters such as the player or enemies

class Character {
  
  PVector pos, vel, dim;
  float damp = 0.8;
  boolean isAlive; //determines whether a character is alive
  int health; //the health that the character has
  int MAX_HEALTH; // the maximum amount of health a character can have
  
  //fields for animating the character
  PImage[] activeImgSeq;
  int currentImgIdx = 0;
  
  Character(PVector pos) {
    this.pos = pos; 
    vel = new PVector();
    dim = new PVector(32, 32);
  }
  
  void update() {
    vel.mult(damp);
    pos.add(vel);
    dead();
    drawHealth();
  }
  
  //moves the character based on the acceleration
  void move(PVector acc) {
    vel.add(acc);
  }
  
  //draw the character
  void drawMe() {
    fill(255, 0, 0);
    ellipse(width/2+dim.x/2, height/2+dim.y/2, dim.x, dim.y);
  }
  
  //determining if a character is close to another
  boolean closeTo(Character other) {
    if(abs(pos.x - other.pos.x) < (dim.x/8 + other.dim.x)
       && abs(other.pos.y - pos.y) < (dim.y/8 + other.dim.y)) {
         return true;
    }
    return false;
  }
  
  //checking if the character is alive or not
  void dead() {
    if(health == 0) {
      isAlive = false;
    }
  }
  
  //place holder for the characters' attack
  void attack() {}
  
  //place holder for the characters' draw health
  void drawHealth() {}
}

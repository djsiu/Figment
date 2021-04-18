//this class is for projectiles that will be shot by the enemy

class Projectile {
  PVector pos, vel, dim;
  boolean isAlive;
  color projColor; // color of the projectile
  float angle = 0; //angle which the projectile will be shot at
  int direction = 0; // -1 is left and 1 is right, for the side the player is on
  
  
  Projectile(PVector pos, PVector vel, color projColor, float angle) {
    this.pos = pos;
    this.vel = vel;
    this.angle = angle;
    dim = new PVector(8, 5);
    isAlive = true;
    this.projColor = projColor;
  }
  
  //moving the projectile towards the player
  void move() {
    PVector vel2 = PVector.fromAngle(angle);
    vel2.mult(vel.x);
    pos.add(vel2);
  }
  
  void update() {
    move();
    drawProjectile();
  }
  
  //drawing the projectile
  void drawProjectile() {
    pushMatrix();
    translate(-player.pos.x + width/2 + pos.x, -player.pos.y + height/2 + pos.y);
    fill(projColor);
    ellipse(0, 0, dim.x, dim.y);
    popMatrix();
  }
  
  //determine if a bullet hits a character
  boolean hit(Character character) {
    if(abs(pos.x - character.pos.x) < dim.x/2 + character.dim.x/2 
        && abs(pos.y - character.pos.y) < dim.y/2 + character.dim.y/2
        && isAlive) {
       isAlive = false;
       //print("hit\n");
       return true;
    }
    return false;
  }
}

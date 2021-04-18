//this subclass is for the enemies in the game

class Enemy extends Character {
  
  PVector diff, absDiff; //used for detecting collision with the player
  
  ArrayList<Projectile> bullets; //the bullets that the enemy is shooting
  int randTime = 0; //random time the bullets will be shot at
  
  PImage[] moving = new PImage[3]; //for holding the images of the enemy moving
  
  Enemy(PVector pos) {
    super(pos);
    vel = new PVector(0, 0);
    dim = new PVector(50, 50);
    
    isAlive = true;
    MAX_HEALTH = 5;
    health = MAX_HEALTH;
    
    bullets = new ArrayList<Projectile>();
    
    //loading the images of the enemy
    for (int i = 0; i < moving.length; i++) {
      moving[i] = loadImage("data/enemy/enemy_" + i + ".png");
    }
    activeImgSeq = moving;
  }
  
  void update() {
    super.update();
    drawMe();
    collision(player);
    fireTime();
    checkProjectiles();
  }
  
  //drawing the enemy
  void drawMe() {
    pushMatrix();
    translate(-player.pos.x + width/2 + pos.x, 
     -player.pos.y + height/2 + pos.y);
     image(activeImgSeq[currentImgIdx], -dim.x/2, -dim.y/2, dim.x, dim.y);
    popMatrix();
    animate();
  }
  
  //animating the enemy to appear like it is constantly moving
  void animate() {
    if (frameCount % 6 == 0 ) {
      currentImgIdx++;
      
      if (currentImgIdx == moving.length) {
        currentImgIdx = 0;
      }
    }
  }
  
  // when the enemy's health is zero is will die and all its bullets will be removed
  void dead() {
    if(health == 0) {
      isAlive = false;
      for (int i = 0; i < bullets.size(); i++) bullets.remove(i); //remove all bullets
      enemies.remove(this);
    }
  }
  
  //insures the player can't walk through the enemy
  void collision(Character c) {
    diff = PVector.sub(c.pos, pos);
    absDiff = new PVector(abs(diff.x), abs(diff.y));
    
    if (absDiff.x < c.dim.x / 2 + dim.x / 2 && 
      absDiff.y < c.dim.y / 2 + dim.y / 2) {
        
      c.pos.x += diff.x*0.05;
      c.pos.y += diff.y*0.05;
      c.vel.mult(0.0);
    }
  }
  
  //for firing bullets at the player at a random time interval
  void fire() {
    bullets.add(new Projectile(new PVector(pos.x, pos.y), new PVector(8, 8), 
                bulletColor, atan2(player.pos.y - pos.y, player.pos.x - pos.x)));
    randTime = (int) random(30, 60); //the boss can fire bullets every .5 to 1 seconds
  }
  
  //fire bullets at random times
  void fireTime() {
    if (randTime == 0 && isAlive) fire();
    if (randTime > 0) randTime--; 
  }
  
  //check if the enemy has hit the player with a bullet
  void checkProjectiles() {
    for (int i = 0; i < bullets.size(); i++) {
      Projectile bb = bullets.get(i);
      bb.update();
      if(bb.hit(player)) {
        player.health -= 1; // if player is hit its health is decreased by one
        playSound(HIT);
        bullets.remove(i);
      } 
    }
  }
  
  //drawing the health of the enemy above its head
  void drawHealth() {
   float scale = dim.x - 5;
    pushMatrix();
    translate(-player.pos.x + width/2 + pos.x - scale/2, 
     -player.pos.y + height/2 + pos.y - dim.y + 10);
    fill(100);
    rect(0, 0, scale, 8);
    if(health >= 0) {
      fill(healthColor);
      float healthPercent = (float) health/MAX_HEALTH;
      rect(0, 0, scale * healthPercent, 8);
    }
    popMatrix();
  }
}

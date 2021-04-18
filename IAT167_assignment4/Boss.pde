// sub-sub class for the boss in the final level
class Boss extends Enemy {
  
  Boss(PVector pos) {
    super(pos);
    dim = new PVector(200, 200);
    
    MAX_HEALTH = 30;
    health = MAX_HEALTH;
  }
  
  //generating the bullets and time interval they will be shot at, the boss shoots bullets faster than regular enemies
  void fire() {
    bullets.add(new Projectile(new PVector(pos.x, pos.y), new PVector(8, 8), 
                bulletColor, atan2(player.pos.y - pos.y, player.pos.x - pos.x)));
    randTime = (int) random(5, 15); //the boss fires bullets at a random time interval
  }
  
  //drawing the health of the boss above its head
  void drawHealth() {
   float scale = dim.x - 5;
    pushMatrix();
    translate(-player.pos.x + width/2 + pos.x - scale/2, 
     -player.pos.y + height/2 + pos.y - dim.y + 50);
    fill(100);
    rect(0, 0, scale, 20);
    if(health >= 0) {
      fill(healthColor);
      float healthPercent = (float) health/MAX_HEALTH;
      rect(0, 0, scale * healthPercent, 20);
    }
    popMatrix();
  }
}

//subclass for the powerup object in the game
//the player can pick it up for an addtional 5 points of health

class Powerup extends Object {
  
  int BOOST_VALUE = 5; //the value the player's health will increase when powerup is collected
  boolean collected = false; //determines whether or not the powerup has been collected
  
  Powerup(PVector pos) {
    super(pos);
    dim = new PVector(65, 35);
    for (int i = 0; i < img.length; i++) {
      img[i] = loadImage("data/object/healthPack" + i + ".png");
    }
    activeImgSeq = img;
  }
  
  //detect if player has bumped into the powerup
  boolean bump(Character other) {
    return (abs(pos.x - other.pos.x) < (dim.x/2 + other.dim.x/2)
         && abs(other.pos.y - pos.y) < (dim.y/2 + other.dim.y/2));
  }
  
  //adding the BOOST_VALUE to the player's health
  void addHealth() {
    if(bump(player) && collected == false) {
      if (player.health <= player.MAX_HEALTH - BOOST_VALUE)
        player.health += BOOST_VALUE;
      else player.health = player.MAX_HEALTH;
      
      playSound(POWERUP);
      collected = true;
    }
  }
  
  //drawing the health boost object
  void drawMe() {
    pushMatrix();
    translate(-player.pos.x + width/2 + pos.x, 
     -player.pos.y + height/2 + pos.y);
    image(activeImgSeq[currentImgIdx], -dim.x/2, -dim.y/2, dim.x, dim.y);
    popMatrix();
    animate();
  }
  
  void update() {
    addHealth();
    if(collected == false) drawMe();
  }
}

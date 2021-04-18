//superclass for the tile object,
// handles collisions and helps insure the tiles move on the screen while the player moves the arrow keys

//note to self: resize tiles to 100*100 pixels before using

class Tile {
  PVector pos, diff, absDiff;
  PImage img; //for holding the image for the tile
  boolean block; //detemining whether a player can walkthrough a block or not
  
  Tile(String path, PVector pos, boolean block) {
    img = loadImage(path);
    this.pos = pos;
    this.block = block;
  }
  
  //prevents players from walking into the walls / blocked tiles
  void collision(Character c) {
    diff = PVector.sub(c.pos, pos);
    absDiff = new PVector(abs(diff.x), abs(diff.y));
    if (block && 
      absDiff.x < c.dim.x / 2 + img.width / 2 && 
      absDiff.y < c.dim.y / 2 + img.height / 2) {
        
      c.pos.x += diff.x*0.05;
      c.pos.y += diff.y*0.05;
      c.vel.mult(0.0);
    }
  }
  
  // removes the bullets from the arraylist if they hit a wall/blocked tile
  void bulletCollision(ArrayList<Projectile> bullets) {
    for(int i = 0; i < bullets.size(); i++) {
      Projectile b = bullets.get(i);
      diff = PVector.sub(b.pos, pos);
      absDiff = new PVector(abs(diff.x), abs(diff.y));
      if (block && 
        absDiff.x < b.dim.x / 2 + img.width / 2 && 
        absDiff.y < b.dim.y / 2 + img.height / 2) {
          b.isAlive = false;
          bullets.remove(b);
        }
    }
  }
  
  //determines whether a tile is in the window or not
  boolean inWindow() {
    if (absDiff.x < width && absDiff.y < height) {
      return true;
    }
    return false;
  }
  
  //drawing the tile
  void drawMe(Character player) {
    pushMatrix();
    translate( -player.pos.x + width/2 + pos.x, 
     -player.pos.y + height/2 + pos.y);

    scale(1.04, 1.04);
    image(img, -img.width/2, -img.height/2);
    popMatrix();
  }
  
  //placeholder for the Door subclass
  void checkEnter(Character other) {}
  
  //placeholder for the Blockade subclass
  void checkEnemies() {}
}

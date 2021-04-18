// this is a blockade tile that only goes away once the player defeats all the enemies in the level

class Blockade extends Tile { 
    
  Blockade(String path, PVector pos, boolean block) {
    super(path, pos, block);
  }
  
  //checking if all the enemies in the level have been defeated to turn off the block
  void checkEnemies() {
    if(enemies.size() <= 0 ) {
      block = false;
      img = loadImage("data//tile/tile" + TILE_EMPTY + ".png"); // makes the tile a normal floor tile once the blockade disappears
    }
  }
}

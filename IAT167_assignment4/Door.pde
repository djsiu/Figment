//this is a subclass for the door tile, 
//it detects if the player has a key and if the player does it allows the player to enter the door

class Door extends Tile {
  
  Door(String path, PVector pos, boolean block) {
    super(path, pos, block);
  }
  
  //detect if the player enters the door with/without the key
  void checkEnter(Character other) {
    doorText = false;
    if (abs(pos.x - other.pos.x) < (tileSize/2 + other.dim.x/2)
         && abs(other.pos.y - pos.y) < (tileSize/2 + other.dim.y/2)) {
           if (keyCount >= 1) {
             playSound(DOOR);
             tiles.clear();
             keyCount--;
             state++;
           }
           else {
             doorText = true;
           }
         }
  }
}

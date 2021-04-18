// subclass for managing the key object in the game
// the player can pick up the key and use it to unlock doors

class Key extends Object {
  
  Key(PVector pos) {
    super(pos);
    dim = new PVector(keySize, keySize);
    img = new PImage[2];
    for(int i = 0; i < img.length; i++) {
      img[i] = loadImage("data/object/key" + i + ".png");
      img[i].resize((int) dim.x, (int) dim.y);
    }
    activeImgSeq = img;
  }
  
  //draw the key
  void drawMe() {
    pushMatrix();
    translate(-player.pos.x + width/2 + pos.x, 
    -player.pos.y + height/2 + pos.y);
    image(activeImgSeq[currentImgIdx], -dim.x/2, -dim.y/2);
    popMatrix();
    animate();
  }
  
  //when the key is collected the item is deleted and the key count goes up by one
  void collected() {
    if (collision(player)) {
      keyCount++;
      playSound(GAMEKEY);
      //println("keys: ", keyCount);
      keys.remove(this);
    }
  }
  
  void update() {
    drawMe();
    collected();
  }
}

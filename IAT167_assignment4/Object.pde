//super class for the objects that the player interacts with in the game

class Object {
  PVector pos, dim;
  
  //fields for the images/animation of the images
  PImage[] img;
  PImage[] activeImgSeq;
  int currentImgIdx = 0;
  
  Object(PVector pos) {
    this.pos = pos;
    dim = new PVector(25, 25);
    img = new PImage[2];
  }
  
  //placeholder for drawing objects
  void drawMe() {
    rect(pos.x, pos.y, dim.x, dim.y);
  }
  
  //check if the character has collided with/collected the object
  boolean collision(Character other) {
    if(abs(pos.x - other.pos.x) < (dim.x/2 + other.dim.x/2)
         && abs(other.pos.y - pos.y) < (dim.y/2 + other.dim.y/2)) {;
         return true;
    }
    return false;
  }
  
  //animating the object to make it appear like it is flashing
  void animate() {
    if (frameCount % 4 == 0 ) {
      currentImgIdx++;
      
      if (currentImgIdx == img.length) {
        currentImgIdx = 0;
      }
    }
  }
  
  //placeholder for the update method
  void update() {}
}

//manage keyboard commands and direction the character is facing (movingState)
//allows the player to use the arrow keys or WASD to move around their player and the space bar to attack the enemies


//variables for determining whether a key has been pressed
boolean up, down, left, right;
boolean space;

//variables for moving the player once a key has been pressed
PVector upForce = new PVector(0, -speed);
PVector downForce = new PVector(0, speed);
PVector leftForce = new PVector(-speed, 0);
PVector rightForce = new PVector(speed, 0);

void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      movingState = 1;
      left = true;
    }
    if (keyCode == RIGHT) {
      movingState = 1;
      right = true;
    }
    if (keyCode == DOWN) {
      movingState = 2;
      down = true;
    }
    if (keyCode == UP) {
      movingState = 3;
      up = true;
    }
  }
  else {
    if (key == 'a') {
      movingState = 1;
      left = true;
    }
    if (key == 'd') {
      movingState = 1;
      right = true;
    }
    if (key == 's') {
      movingState = 2;
      down = true;
    }
    if (key == 'w') {
      movingState = 3;
      up = true;
    }
  }
  if (key == ' ') {
    //println("space pressed");
    movingState = 4;
    space = true;
    
    //only allow a player to attack when they're in a game level
    if (state == LEVEL1 || state == LEVEL2 || state == LEVEL3 || state == LEVEL4) {
      player.attack(); //player attacks the enemy when the space bar is pressed and player is close enough to the enemy
    }
  }
}

void keyReleased() {
  if (key == CODED) {
    movingState = 0;
    if (keyCode == LEFT) left = false;
    if (keyCode == UP) up = false;
    if (keyCode == DOWN) down = false;
    if (keyCode == RIGHT) right = false;
  }
  else {
    movingState = 0;
    if (key == 'a') left = false;
    if (key == 'w') up = false;
    if (key == 's') down = false;
    if (key == 'd') right = false;
  }
  if (key == ' ') {
    space = false;
  }
}

// moving the player according to the player's keyboard commands
void keyboardMove() {
  if (left) player.move(leftForce);
  if (right) player.move(rightForce);
  if (up) player.move(upForce);
  if (down) player.move(downForce);
}

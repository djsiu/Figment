//this file is for the management of all the levels/states in the game


// intro screen
void intro() {
  if (!setupIntro) {
    setupIntro = true;
    
    //managing music
    endgame.pause();
    lose.pause();
    intro.loop();
  }
  background(255);
  fill(0);
  textSize(64);
  text("FIGMENT", 375, height/2 - 50);
  cP5.getController("start").show();
  cP5.getController("how to play").show();
  
  //reset all levels
  setup1 = false;
  setup2 = false;
  setup3 = false;
  setup4 = false;
}

//function to run level 1
void level1() {
  if (!setup1) {
    setup1 = true;
    clearLists();
    generateMap(map1);
    
    //managing music
    intro.pause();
    gameplay.play();
    gameplay.loop();
    
    //initialize the player for level 1
    Tile startTile = tiles.get(playerInit1); // start/spawn position
    player = new Player(new PVector(startTile.pos.x, startTile.pos.y)); 
    
    //initialize level 1 key
    Tile keyTile = tiles.get(keyLocation1);
    keys.add(new Key(new PVector(keyTile.pos.x, keyTile.pos.y)));
    
    //initialize level 1 powerup
    Tile powerupTile = tiles.get(powerupLocation1);
    powerups.add(new Powerup(new PVector(powerupTile.pos.x, powerupTile.pos.y)));
    
    //initialize level 1 enemies
    generateEnemies(enemyInit1);
  }
  update();
  printLevel(1);
}

// function to run level 2
void level2() {
  
  if (!setup2) {
    setup2 = true;
    clearLists();
    generateMap(map2);
    
    //initialize the player for level 2
    Tile startTile = tiles.get(playerInit2); 
    player = new Player(new PVector(startTile.pos.x, startTile.pos.y)); 
    
    //initialize level 2 key
    Tile keyTile = tiles.get(keyLocation2);
    keys.add(new Key(new PVector(keyTile.pos.x, keyTile.pos.y)));
    
    //intialize level 2 powerup
    Tile powerupTile = tiles.get(powerupLocation2);
    powerups.add(new Powerup(new PVector(powerupTile.pos.x, powerupTile.pos.y)));
    
    //initialize level 2 enemies
    generateEnemies(enemyInit2);
  }
  update();
  printLevel(2);
}

//function to run level 3
void level3() {
  if (!setup3) {
    setup3 = true;
    clearLists();
    generateMap(map3);
    
    //initialize the player for level 3
    Tile startTile = tiles.get(playerInit3);
    player = new Player(new PVector(startTile.pos.x, startTile.pos.y)); 
    
    //initialize level 3 key
    Tile keyTile = tiles.get(keyLocation3);
    keys.add(new Key(new PVector(keyTile.pos.x, keyTile.pos.y)));
    
    //intialize level 3 powerup
    for(int i = 0; i < powerupLocation3.length; i++) {
      Tile powerupTile = tiles.get(powerupLocation3[i]);
      powerups.add(new Powerup(new PVector(powerupTile.pos.x, powerupTile.pos.y)));
    }
    
    //initilize level 3 enemies
    generateEnemies(enemyInit3);
  }
  update();
  printLevel(3);
}

//function to run level 4/boss level
void level4() {
  if (!setup4) {
    setup4 = true;
    clearLists();
    generateMap(map4);
    
    //managing music
    gameplay.pause();
    boss.loop();
    
    //initialize the player for level 4
    Tile startTile = tiles.get(playerInit4);
    player = new Player(new PVector(startTile.pos.x, startTile.pos.y)); 
    
    //initialize level 4 key
    Tile keyTile = tiles.get(keyLocation4);
    keys.add(new Key(new PVector(keyTile.pos.x, keyTile.pos.y)));
    
    //intialize level 4 powerups
    for (int i = 0; i < powerupLocation4.length; i++) {
      Tile powerupTile = tiles.get(powerupLocation4[i]);
      powerups.add(new Powerup(new PVector(powerupTile.pos.x, powerupTile.pos.y)));
    }
    //initilize level 4 enemies
    Tile enemyTile = tiles.get(bossInit);
    enemies.add(new Boss(new PVector(enemyTile.pos.x, enemyTile.pos.y)));
    generateEnemies(enemyInit4);
  }
  update();
  //print "boss level" on the bottom left corner of the screen
  textSize(24);
  fill(textColor);
  text("boss level", 25, height - 25);
}

// function to run when the game is over, the player wins/finishes
void endGame() {
  if(!setupEnd) {
    setupEnd = true;
    
    //managing music
    boss.pause();
    endgame.loop();
  }
  
  //displaying end of game text and button
  background(255);
  fill(0);
  textSize(64);
  text("FIGMENT", 375, height/2 - 50);
  fill(200);
  textSize(24);
  text("you've made it to the end", 380, height/2);
  
  cP5.getController("restart").show();
}

// when the player loses
void lose() {
  if(!setupLose) {
    setupLose = true;
    
    //managing music
    gameplay.pause();
    boss.pause();
    lose.loop();
  }
  
  //displaying game over text and button
  background(255);
  fill(0);
  textSize(64);
  text("GAME OVER", 310, height/2);
  
  cP5.getController("restart").show();
  
  //resetting player health, keys, etc.
  player.health = player.MAX_HEALTH;
  keyCount = 0;
  clearLists();
}

// this is for displaying the game instructions / how to play the game
// note to self: maybe find a song for the how to play screen
void howTo() {
  intro.pause();
  
  //displaying the how to play screen and back button
  background(255);
  PImage howToScreen = loadImage("data/howTo.png");
  image(howToScreen, 0, 0);
  
  cP5.getController("back").show();
}

//generating the enemies for any level
void generateEnemies(int[] enemyList) {
  for (int i = 0; i< enemyList.length; i++) {
    Tile enemyTile = tiles.get(enemyList[i]);
    enemies.add(new Enemy(new PVector(enemyTile.pos.x, enemyTile.pos.y)));
  }
}

//clearing the arraylists or enemies, tiles, keys and powerups
void clearLists() {
  enemies.clear();
  tiles.clear();
  keys.clear();
  powerups.clear();
}

//update the player, tiles and objects
void update() {
  
  //updating the tiles
  for (int i = 0; i < tiles.size(); i++) {
    Tile t = tiles.get(i);
    t.collision(player);
    
    if (t.inWindow()) {
      t.drawMe(player);
    }
    if (t instanceof Door) {
      t.checkEnter(player);
    }
    if (t instanceof Blockade) {
      t.checkEnemies();
    }
  }
  
  //updating the objects
  for (int i = 0; i < keys.size(); i++) {
    keys.get(i).update();
  }
  for (int j = 0; j < powerups.size(); j++) {
    powerups.get(j).update();
  }
  
  //updating the enemies and bullets
  for (int k = 0; k < enemies.size(); k++) {
    for (int s = 0; s < tiles.size(); s++) {
      Tile t = tiles.get(s);
      t.bulletCollision(enemies.get(k).bullets);
    }
    enemies.get(k).update();
  }
  
  displayKey();
  printDoor(doorText);
  keyboardMove();
  player.update();
  player.drawMe();
}

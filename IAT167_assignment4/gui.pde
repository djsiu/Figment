//this module is for the gui elements in the game


// displays the number of keys the player has on the top right corner
void displayKey() {
  PImage img = loadImage("data/object/key0.png");
  img.resize(35, 35);
  
  image(img, width - 125, 25);
  fill(keyColor);
  textSize(42);
  text(keyCount, width - 75, 60);
}

//printing the level on the bottom left corner
void printLevel(int level) { 
  textSize(24);
  fill(textColor);
  text("level " + level, 25, height - 25);
}

//print the text that the door is locked when the player enters without a key
void printDoor(boolean doorText) {
  if(doorText) {
    fill(keyColor);
    textSize(30);
    text("this door is locked", width - 300, height - 50);
  }
}
 //<>//
//style the buttons 
void styleButtons() {
  PFont buttonFont = createFont("Futura-Medium", 18);
  
  //styling the start button
  start.getCaptionLabel().setFont(buttonFont);
  start.setColorForeground(color(0)); //color when the mouse hovers
  start.setColorBackground(color(200));
  
  //styling the restart button
  restart.getCaptionLabel().setFont(buttonFont);
  restart.setColorForeground(color(0));
  restart.setColorBackground(color(200));
  
  //styling the how to play button
  howToPlay.getCaptionLabel().setFont(buttonFont);
  howToPlay.setColorForeground(color(0));
  howToPlay.setColorBackground(color(200));
  
  //styling the back button in the how to play window
  back.getCaptionLabel().setFont(buttonFont);
  back.setColorForeground(color(0));
  back.setColorBackground(color(200));
}

//determine whether the buttons have been pressed
void controlEvent(ControlEvent theEvent) {
  
  //when the start buttons is pressed start level one
  if (theEvent.getController().getName() == "start") {
    state = LEVEL1;
    setupIntro = false;
    cP5.getController("start").hide();
    cP5.getController("how to play").hide();
  }
  
  //when the restart button has been pressed return to intro screen
  if (theEvent.getController().getName() == "restart") {
    state = INTRO;
    setupEnd = false;
    setupLose = false;
    cP5.getController("restart").hide();
  }
  
  //when the how to play button is pressed an instructional screen will show up
  if (theEvent.getController().getName() == "how to play") {
    state = HOWTO;
    cP5.getController("how to play").hide();
    cP5.getController("start").hide();
  }
  
  //when the player presses the back button
  if (theEvent.getController().getName() == "back") {
    state = INTRO;
    setupIntro = false;
    cP5.getController("back").hide();
  }
}

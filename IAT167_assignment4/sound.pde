//managing the sound effects and music in the game


//loading the audio files 
void loadSound() {
  minim = new Minim(this);
  door = minim.loadFile(DOOR);
  gameKey = minim.loadFile(GAMEKEY);
  powerup = minim.loadFile(POWERUP);
  punch = minim.loadFile(PUNCH);
  hit = minim.loadFile(HIT);
  intro = minim.loadFile(INTRO_SONG);
  gameplay = minim.loadFile(GAMEPLAY_SONG);
  boss = minim.loadFile(BOSS_SONG);
  endgame = minim.loadFile(ENDGAME_SONG);
  lose = minim.loadFile(LOSE_SONG);
}

//for playing the sound effect files
void playSound(String file) {
  AudioPlayer sound = null;
  switch(file) {
    case DOOR:
      sound = door;
      break;
    case GAMEKEY: 
      sound = gameKey;
      break;
    case POWERUP:
      sound = powerup;
      break;
    case PUNCH:
      sound = punch;
      break;
    case HIT:
      sound = hit;
      break;
    default: //do nothing
  }
  sound.play(0);
}

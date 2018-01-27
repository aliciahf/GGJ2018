// === GGJ2018 - Transmission (Alicia Feng, Sandra Honigman, Wally Simmons-Edler) === 
// Ghost Ouija Computer
// ** Player attempts to communicate with a ghost with a language barrier

PFont font;
Player player;

String convo01[], convo02[], convo03[];
int currentConvo = 1;

int[] reply;
Key[] keys;
int keyCount = 6;
int[] values = {10, 20, 30, 40, 50, 60, 70};
int[] keyIDs = {1, 2, 3, 4, 5, 6};
int counter = 0, score = 0, tempScore = 0;

final int startScreen = 0, play = 1, endScreen = 2;
int state = startScreen;

void setup() {
  fullScreen();
  //size(800,600);
  noCursor();
  smooth();
  background(0,0,0);
  font = loadFont("Silkscreen.vlw");
  
  convo01 = loadStrings("convo01.txt");
  convo02 = loadStrings("convo02.txt");
  convo03 = loadStrings("convo03.txt");
  
  keys = new Key[keyCount];
  for (int i = 0; i < keyCount; i++) {
    keys[i] = new Key(keyIDs[i], i, values);
  }
  player = new Player();
}

void draw() {
  background(0,0,0);
  
  switch(state) {
    case startScreen:
      showStartScreen();
      break;
    case play:
      play();
      break;
    case endScreen:
      showEndScreen();
      break;
    default:
      println("ERROR: State missing.");
      break;
  }
  
  //version history
  fill(255);
  textAlign(RIGHT);
  textFont(font, 10);
  text("GGJ2018 v.0.1", width-10, height-10);
}

void showStartScreen() {
  
}

void showEndScreen() {
  
}

void play() {
  //display choices
  for (int i = 0; i < keyCount; i++) {
    keys[i].display();
    keys[i].detect(player.posX, player.posY);
  }

  //text display
  int text_topMargin = 100;
  fill(255);
  textAlign(CENTER);
  textFont(font, 16);
  
  text(score, width/2, 30);
  
  switch(currentConvo) {
    case 1:
      for (int i = 0; i < convo01.length; i++) {
        text(convo01[i], width/2, text_topMargin + 20*i);
      }
      break;
    case 2:
      for (int i = 0; i < convo02.length; i++) {
        text(convo02[i], width/2, text_topMargin + 20*i);
      }
      break;
    case 3:
      for (int i = 0; i < convo03.length; i++) {
        text(convo03[i], width/2, text_topMargin + 20*i);
      }
      break;
    default:
      println("ERROR: No more available convos.");
      break;
  }
  
  //display picks
  rectMode(CENTER);
  for (int i=0; i < keys.length; i++) {
    if (keys[i].selectID == 1) {
      fill(keys[i].r,keys[i].g,keys[i].b);
      rect(width/4,height/2,180,180);
    } else if (keys[i].selectID == 2) {
      fill(keys[i].r,keys[i].g,keys[i].b);
      rect(width/2,height/2,180,180);
    } else if (keys[i].selectID == 3) {
      fill(keys[i].r,keys[i].g,keys[i].b);
      rect(width*3/4,height/2,180,180);
    }
  }
  
  //draw cursor
  player.display();
  player.move();
}

void mousePressed() {
  for (int i = 0; i < keyCount; i++) {
    if (keys[i].isInRange() && counter<3 && keys[i].selectID==0) {
      counter++;
      keys[i].selectID = counter;
      tempScore += keys[i].value;
    }
  }
}

void keyPressed() {
  switch(state) {
    case startScreen:
      state = play;
      break;
    case play:
      if (key == 'r') {
        //clear board
        counter = 0;
        tempScore = 0;
        for (int i = 0; i < keyCount; i++) {
          keys[i].selectID = 0;
        }
      }
      if (key == ENTER) {
        //submit score for the round
        score += tempScore;
        
        //clear board
        counter = 0;
        tempScore = 0;
        for (int i = 0; i < keyCount; i++) {
          keys[i].selectID = 0;
        }
        
        //conversation progression
        if (currentConvo < 3) {
          currentConvo++;
        } else {
          currentConvo = 1;
        }
      }
  }
}
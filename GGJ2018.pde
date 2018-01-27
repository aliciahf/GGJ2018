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
int counter = 0;


void setup() {
  //fullScreen();
  noCursor();
  smooth();
  size(800,600);
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
  for (int i = 0; i < keyCount; i++) {
    keys[i].display();
    keys[i].detect(player.posX, player.posY);
  }

  //text display
  fill(255);
  textAlign(CENTER);
  textFont(font, 16);

  switch(currentConvo) {
    case 1:
      for (int i = 0; i < convo01.length; i++) {
        text(convo01[i], width/2, 200 + 20*i);
      }
      break;
    case 2:
      for (int i = 0; i < convo02.length; i++) {
        text(convo02[i], width/2, 200 + 20*i);
      }
      break;
    case 3:
      for (int i = 0; i < convo03.length; i++) {
        text(convo03[i], width/2, 200 + 20*i);
      }
      break;
    default:
      println("ERROR: No more available convos.");
      break;
  }
  
  player.display();
  player.move();
  
  // version history
  fill(255);
  textAlign(RIGHT);
  textFont(font, 10);
  text("GGJ2018 v.0.1", width-10, height-10);
}

void mousePressed() {
  for (int i = 0; i < keyCount; i++) {
    if (keys[i].isInRange() && counter < 3) {
      counter++;
      keys[i].selectID = counter;
    }
  }
}

void keyPressed() {
  if (key == 'r') {
    //clear board
    counter = 0;
    for (int i = 0; i < keyCount; i++) {
      keys[i].selectID = 0;
    }
  }
  if (key == ENTER) {
    //clear board
    counter = 0;
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
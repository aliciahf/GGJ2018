// === GGJ2018 - Transmission (Alicia Feng, Sandra Honigman, Wally Simmons-Edler) === 
// Ghost Ouija Computer
// ** Player attempts to communicate with a ghost with a language barrier

PFont font;
Player player;
Message message;
String question = "Hello? Are you there?";
int[] reply;
Key[] keys;
int keyCount = 6;
int[] values = {10, 20, 30, 40, 50, 60, 70};
int[] keyIDs = {1, 2, 3, 4, 5, 6};
int counter = 0;

String levelName = "LevelOne";


void setup() {
  //fullScreen();
  noCursor();
  size(800,600);
  background(0,0,0);
  font = loadFont("Silkscreen.vlw");
  
  player = new Player(width/2, height/2);
  message = new Message(round(random(0, 2)), question);
  keys = new Key[keyCount];
  for (int i = 0; i < keyCount; i++) {
    keys[i] = new Key(keyIDs[i], i, values);
  }
}

void draw() {
  background(0,0,0);
  for (int i = 0; i < keyCount; i++) {
    keys[i].display();
    keys[i].detect(player.posX, player.posY);
  }
  message.display();
  
  player.display();
  player.move();
  
  // version history
  fill(255);
  textAlign(RIGHT);
  textFont(font, 10);
  text("GGJ2018 v.0.1", width-10, height-10);
}

void mousePressed() {
  if (levelName == "LevelOne") {
    for (int i = 0; i < keyCount; i++) {
      if (keys[i].isInRange() && counter < 3) {
        counter++;
        keys[i].selectID = counter;
      }
    }
  }
}

void keyPressed() {
  if (levelName == "LevelOne") {
    if (key == 'r') {
      for (int i = 0; i < keyCount; i++) {
        keys[i].selectID = 0;
        counter = 0;
      }
    }
  }
}
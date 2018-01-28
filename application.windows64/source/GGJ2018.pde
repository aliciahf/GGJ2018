// === GGJ2018 - Transmission (Alicia Feng, Sandra Honigman, Wally Simmons-Edler) === 
// Ghost Ouija Computer
// ** Player attempts to communicate with a ghost with a language barrier

import ddf.minim.*;

PFont font;
PImage icon_ghost, icon_player, logo;
PImage[] activeImages = new PImage[6];
AudioPlayer select, cancel, submit, theme;
Minim minim;
Player player;

String convo01[], convo02[], convo03[], convo04[], convo05[], convo06[], convo07[], convo08[], 
convo09[], convo10[], convo11[], convo12[], convo13[], convo14[], convo15[], convo16[],
convo17[], convo18[], convo19[], convo20[], convo21[], convo22[], convo23[], convo24[],
convo25[], convo26[], convo27[], convo28[], convo29[], convo30[]; //16
String winText[], loseText[];
int currentConvo = 1;
int convoTotal = 30;

int[] reply;
Key[] keys;
int keyCount = 6;
int[] values = {20, 20, 20, 20, 20, 20, 20}; 
int[] keyIDs = {1, 2, 3, 4, 5, 6}; //init
int counter = 0, score = 0, tempScore = 0;
boolean isSelected = false;

final int startScreen = 0, play = 1, endScreen = 2;
int state = startScreen;

int scoreA = 0;
int scoreX, scoreY, displayScore;

int opacity = 100;

void setup() {
  fullScreen();
  noCursor();
  smooth();
  background(236, 156, 200);
  scoreX = width/2;
  scoreY = width/2;
  
  font = createFont("PTM75F.ttf", 32);
  icon_ghost = loadImage("images/icon_cat.png");
  icon_player = loadImage("images/icon_frog.png");
  logo = loadImage("images/logoGGJ18.png");
  minim = new Minim(this);
  select = minim.loadFile("audio/Switch1.mp3");
  cancel = minim.loadFile("audio/Cancel2.mp3");
  submit = minim.loadFile("audio/Computer.mp3");
  theme = minim.loadFile("audio/Komiku_Night_in_a_seashell_3.mp3");
  theme.loop();
  
  convo01 = loadStrings("dialogue/convo01.txt");
  convo02 = loadStrings("dialogue/convo02.txt");
  convo03 = loadStrings("dialogue/convo03.txt");
  convo04 = loadStrings("dialogue/convo04.txt");
  convo05 = loadStrings("dialogue/convo05.txt");
  convo06 = loadStrings("dialogue/convo06.txt");
  convo07 = loadStrings("dialogue/convo07.txt");
  convo08 = loadStrings("dialogue/convo08.txt");
  convo09 = loadStrings("dialogue/convo09.txt");
  convo10 = loadStrings("dialogue/convo10.txt");
  convo11 = loadStrings("dialogue/convo11.txt");
  convo12 = loadStrings("dialogue/convo12.txt");
  convo13 = loadStrings("dialogue/convo13.txt"); //might be a special case
  convo14 = loadStrings("dialogue/convo14.txt");
  convo15 = loadStrings("dialogue/convo15.txt");
  convo16 = loadStrings("dialogue/convo16.txt");
  convo17 = loadStrings("dialogue/convo17.txt");
  convo18 = loadStrings("dialogue/convo18.txt");
  convo19 = loadStrings("dialogue/convo19.txt");
  convo20 = loadStrings("dialogue/convo20.txt");
  convo21 = loadStrings("dialogue/convo21.txt");
  convo22 = loadStrings("dialogue/convo22.txt");
  convo23 = loadStrings("dialogue/convo23.txt");
  convo24 = loadStrings("dialogue/convo24.txt");
  convo25 = loadStrings("dialogue/convo25.txt");
  convo26 = loadStrings("dialogue/convo26.txt");
  convo27 = loadStrings("dialogue/convo27.txt");
  convo28 = loadStrings("dialogue/convo28.txt");
  convo29 = loadStrings("dialogue/convo29.txt");
  convo30 = loadStrings("dialogue/convo30.txt");
  
  winText = loadStrings("winstate.txt");
  loseText = loadStrings("failstate.txt");
  
  for (int i = 0; i < keyCount; i++) {
    activeImages[i] = loadImage("images/reactions/reaction" + i + ".png");
  }
  keys = new Key[keyCount];
  for (int i = 0; i < keyCount; i++) {
    keys[i] = new Key(keyIDs[i], i, values, activeImages);
  }
  player = new Player();
}

void draw() {
  noStroke();
  background(236, 156, 200);
  fill(74, 48, 92);
  rectMode(CENTER);
  stroke(190, 185, 225);
  strokeWeight(2);
  rect(width/2, height/2, width*0.8, height*0.8);
  fill(143, 107, 170);
  rect(width/2, (height/2) - (height*0.8/2), width*0.8, 50);
  rect(width/2, (height/2) + (height*0.8/2 - 120/2), width*0.8, 120);
  noStroke();
  
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
  
  //hide?
  //fill(255,255,255,scoreA);
  //textAlign(CENTER);
  //textFont(font, 16);
  //text("+" + displayScore, scoreX, scoreY);
  //scoreY--;
  //scoreA-=20;
  
  //version history
  fill(255);
  textAlign(RIGHT);
  textFont(font, 10);
  text("GGJ2018 - v.0.1", width-10, height-20);
  fill(255,255,255,100);
  text("Alicia Feng, Sandra Honigman, Wally Simmons-Edler", width-10, height-10);
}

void showStartScreen() {
  imageMode(CENTER);
  image(logo, width/2, height/2-180);
  fill(255);
  textAlign(CENTER);
  textFont(font, 32);
  //text("REACTIONARY", width/2, height/2-130); //rename
  textFont(font, 16);
  text("You really like this person sooo much, and you think the feeling is mutual, \n" 
  +"so you want to ask them out to the RENAISSANCE FAIR this weekend.\n"
  +"Unfortunately, this morning you managed to spill juice all over your keyboard, "
  +"and it's no longer working. \nIf you want to make your move, you'll have to " 
  +"communicate via...\n\n"
  +"REACTION IMAGES\n\n"
  +"Good luck!", width/2, height/2-60);
  
  fill(255,255,255,opacity);
  text("[ PRESS ANY KEY TO CONTINUE ]", width/2, height/2+200); //rename
}

void showEndScreen() {
  fill(255);
  textAlign(CENTER);
  textFont(font, 32);
  //text(score, width/2, height/2);
  
  if (score < 100) {
    textFont(font, 16);
    for (int i = 0; i < loseText.length; i++) { 
      text(loseText[i], width/2, 320 + 20*i); 
    }
  } else {
    textFont(font, 16);
    for (int i = 0; i < winText.length; i++) { 
      text(winText[i], width/2, 320 + 20*i); 
    }
  } 
  
  fill(255,255,255,opacity);
  text("[ PRESS Q TO RESTART ]", width/2, height/2+200); 
}

void play() {
  fill(255,255,255,opacity);
  textFont(font, 10);
  textAlign(CENTER);
  text("[ PRESS R TO CLEAR IMAGES ]", width/2, height/2+220); 
  
  textAlign(CENTER);
  textFont(font, 18);
  fill(190, 185, 225);
  text("== gh0stykat ==", width/2, (height/2) - (height*0.8/2)+8);
  
  //display choices
  for (int i = 0; i < keyCount; i++) {
    keys[i].display();
    keys[i].detect(player.posX, player.posY);
  }

  //text display & convo values
  int text_topMargin = 200;
  int text_leftMargin = 400;
  fill(255);
  
  //ghost username
  textAlign(LEFT);
  textFont(font, 24);
  text("gh0stykat: ", text_leftMargin, text_topMargin-30);
  fill(190, 185, 225);
  image(icon_ghost, text_leftMargin - 40, text_topMargin-30, 50, 50);
  
  textFont(font, 18);
  
  //int[] values01 = {20,20,20,20,20,20}; int[] activeImages01 = {0,1,2,3,4,5}; //0,1,2,3,4,5
  int[] values02 = {30,20,20,30,10,10}; int[] activeImages02 = {52,64,65,66,67,77}; //[52],64,65,[66],67,77
  int[] values03 = {30,30,20,30,20,10}; int[] activeImages03 = {25,60,68,59,66,19}; //[25],[60],68,[59],66
  int[] values04 = {30,30,20,20,10,30}; int[] activeImages04 = {50,55,64,74,2,81}; //[50],[55],64,74,2,[81]
  int[] values05 = {30,30,20,10,10,10}; int[] activeImages05 = {51,37,75,22,13,85}; //[51],[37],75
  int[] values06 = {30,20,20,20,10,10}; int[] activeImages06 = {6,64,74,76,61,59}; //[6],64,74,76,
  int[] values07 = {30,20,30,30,20,10}; int[] activeImages07 = {7,64,71,72,77,2}; //[7],64,[71],[72],2
  int[] values08 = {20,40,10,30,50,60}; int[] activeImages08 = {1,1,1,1,1,1}; //na
  int[] values09 = {30,30,30,20,10,10}; int[] activeImages09 = {9,32,56,64,12,1}; //[9],[32],[56],64,12,1
  int[] values10 = {30,20,20,10,10,10}; int[] activeImages10 = {8,74,77,26,34,23}; //[8],74,77
  int[] values11 = {30,30,30,10,10,10}; int[] activeImages11 = {25,60,59,9,17,38}; //[25],[60],[59]
  int[] values12 = {30,30,30,20,30,10}; int[] activeImages12 = {12,43,44,45,63,70}; //[12],[43],[44],45,[63],70
  int[] values13 = {20,20,30,20,30,10}; int[] activeImages13 = {47,10,13,61,62,5}; //47,10,[13],61,[62],5
  int[] values14 = {20,30,20,20,10,10}; int[] activeImages14 = {24,15,26,2,28,46}; //24,[15],26,84,46
  int[] values15 = {30,30,20,10,10,10}; int[] activeImages15 = {14,57,74,55,33,85}; //[14],[57],74
  int[] values16 = {30,30,30,20,10,10}; int[] activeImages16 = {16,17,18,75,25,61}; //[16],[17],[18],75
  int[] values17 = {30,30,30,20,10,10}; int[] activeImages17 = {20,19,49,75,7,20}; //[20],[19],[49],75
  int[] values18 = {30,20,20,10,10,10}; int[] activeImages18 = {21,64,74,84,12,85}; //[21],64,74
  int[] values19 = {30,20,20,10,10,10}; int[] activeImages19 = {30,46,45,39,21,1}; //[30],46,45,39
  int[] values20 = {30,30,30,30,10,10}; int[] activeImages20 = {23,40,41,73,44,38}; //[23],[40],[41],[73]
  int[] values21 = {30,20,30,10,10,30}; int[] activeImages21 = {22,28,36,38,42,53}; //[22],28,[36],38,42,[53]
  int[] values22 = {30,30,30,10,10,10}; int[] activeImages22 = {27,22,34,64,70,0}; //[27],[22],[34],64
  int[] values23 = {30,30,20,30,10,10}; int[] activeImages23 = {29,30,23,39,46,21}; //[29],[30],23,[39],46
  int[] values24 = {30,30,30,10,10,10}; int[] activeImages24 = {25,60,59,63,7,9}; //[25],[60],[59],63
  int[] values25 = {30,10,30,30,20,10}; int[] activeImages25 = {25,48,58,60,9,14}; //[25],48,[58],[60],9
  int[] values26 = {30,20,30,20,20,10}; int[] activeImages26 = {26,54,63,69,42,18}; //[26],54,[63],75,76
  int[] values27 = {30,30,10,10,10,10}; int[] activeImages27 = {69,70,42,24,6,85};  //[69],[70]
  int[] values28 = {30,30,10,10,10,10}; int[] activeImages28 = {69,70,23,1,77,23}; //[69],[70],77
  int[] values29 = {0,0,0,0,0,30}; int[] activeImages29 = {80,80,80,80,80,83}; 
  int[] values30 = {0,0,0,0,0,0}; int[] activeImages30 = {80,80,80,80,80,80}; //empty
  
  switch(currentConvo) {
    case 1:
      for (int i = 0; i < convo01.length; i++) { text(convo01[i], text_leftMargin, text_topMargin + 20*i); }
      break;
    case 2:
      for (int i = 0; i < keyCount; i++) { keys[i].value = values02[i]; keys[i].image = loadImage("images/reactions/reaction" + activeImages02[i] + ".png"); }
      for (int i = 0; i < convo02.length; i++) { text(convo02[i], text_leftMargin, text_topMargin + 20*i); }
      break;
    case 3:
      for (int i = 0; i < keyCount; i++) { keys[i].value = values03[i]; keys[i].image = loadImage("images/reactions/reaction" + activeImages03[i] + ".png"); }
      for (int i = 0; i < convo03.length; i++) { text(convo03[i], text_leftMargin, text_topMargin + 20*i); }
      break;
    case 4:
      for (int i = 0; i < keyCount; i++) { keys[i].value = values04[i]; keys[i].image = loadImage("images/reactions/reaction" + activeImages04[i] + ".png"); }
      for (int i = 0; i < convo04.length; i++) { text(convo04[i], text_leftMargin, text_topMargin + 20*i); }
      break;
    case 5:
      for (int i = 0; i < keyCount; i++) { keys[i].value = values05[i]; keys[i].image = loadImage("images/reactions/reaction" + activeImages05[i] + ".png"); }
      for (int i = 0; i < convo05.length; i++) { text(convo05[i], text_leftMargin, text_topMargin + 20*i); }
      break;
    case 6:
      for (int i = 0; i < keyCount; i++) { keys[i].value = values06[i]; keys[i].image = loadImage("images/reactions/reaction" + activeImages06[i] + ".png"); }
      for (int i = 0; i < convo06.length; i++) { text(convo06[i], text_leftMargin, text_topMargin + 20*i); }
      break;
    case 7:
      for (int i = 0; i < keyCount; i++) { keys[i].value = values07[i]; keys[i].image = loadImage("images/reactions/reaction" + activeImages07[i] + ".png"); }
      for (int i = 0; i < convo07.length; i++) { text(convo07[i], text_leftMargin, text_topMargin + 20*i); }
      break;
    case 8:
      for (int i = 0; i < keyCount; i++) { keys[i].value = values08[i]; keys[i].image = loadImage("images/reactions/reaction" + activeImages08[i] + ".png"); }
      for (int i = 0; i < convo08.length; i++) { text(convo08[i], text_leftMargin, text_topMargin + 20*i); }
      break;
    case 9:
      for (int i = 0; i < keyCount; i++) { keys[i].value = values09[i]; keys[i].image = loadImage("images/reactions/reaction" + activeImages09[i] + ".png"); }
      for (int i = 0; i < convo09.length; i++) { text(convo09[i], text_leftMargin, text_topMargin + 20*i); }
      break;
    case 10:
      for (int i = 0; i < keyCount; i++) { keys[i].value = values10[i]; keys[i].image = loadImage("images/reactions/reaction" + activeImages10[i] + ".png"); }
      for (int i = 0; i < convo10.length; i++) { text(convo10[i], text_leftMargin, text_topMargin + 20*i); }
      break;
    case 11:
      for (int i = 0; i < keyCount; i++) { keys[i].value = values11[i]; keys[i].image = loadImage("images/reactions/reaction" + activeImages11[i] + ".png"); }
      for (int i = 0; i < convo11.length; i++) { text(convo11[i], text_leftMargin, text_topMargin + 20*i); }
      break;
    case 12:
      for (int i = 0; i < keyCount; i++) { keys[i].value = values12[i]; keys[i].image = loadImage("images/reactions/reaction" + activeImages12[i] + ".png"); }
      for (int i = 0; i < convo12.length; i++) { text(convo12[i], text_leftMargin, text_topMargin + 20*i); }
      break;
    case 13:
      for (int i = 0; i < keyCount; i++) { keys[i].value = values13[i]; keys[i].image = loadImage("images/reactions/reaction" + activeImages13[i] + ".png"); }
      for (int i = 0; i < convo13.length; i++) { text(convo13[i], text_leftMargin, text_topMargin + 20*i); }
      break;
    case 14:
      for (int i = 0; i < keyCount; i++) { keys[i].value = values14[i]; keys[i].image = loadImage("images/reactions/reaction" + activeImages14[i] + ".png"); }
      for (int i = 0; i < convo14.length; i++) { text(convo14[i], text_leftMargin, text_topMargin + 20*i); }
      break;
    case 15:
      for (int i = 0; i < keyCount; i++) { keys[i].value = values15[i]; keys[i].image = loadImage("images/reactions/reaction" + activeImages15[i] + ".png"); }
      for (int i = 0; i < convo15.length; i++) { text(convo15[i], text_leftMargin, text_topMargin + 20*i); }
      break;
    case 16:
      for (int i = 0; i < keyCount; i++) { keys[i].value = values16[i]; keys[i].image = loadImage("images/reactions/reaction" + activeImages16[i] + ".png"); }
      for (int i = 0; i < convo16.length; i++) { text(convo16[i], text_leftMargin, text_topMargin + 20*i); }
      break;
    case 17:
      for (int i = 0; i < keyCount; i++) { keys[i].value = values17[i]; keys[i].image = loadImage("images/reactions/reaction" + activeImages17[i] + ".png"); }
      for (int i = 0; i < convo17.length; i++) { text(convo17[i], text_leftMargin, text_topMargin + 20*i); }
      break;
    case 18:
      for (int i = 0; i < keyCount; i++) { keys[i].value = values18[i]; keys[i].image = loadImage("images/reactions/reaction" + activeImages18[i] + ".png"); }
      for (int i = 0; i < convo18.length; i++) { text(convo18[i], text_leftMargin, text_topMargin + 20*i); }
      break;
    case 19:
      for (int i = 0; i < keyCount; i++) { keys[i].value = values19[i]; keys[i].image = loadImage("images/reactions/reaction" + activeImages19[i] + ".png"); }
      for (int i = 0; i < convo19.length; i++) { text(convo19[i], text_leftMargin, text_topMargin + 20*i); }
      break;
    case 20:
      for (int i = 0; i < keyCount; i++) { keys[i].value = values20[i]; keys[i].image = loadImage("images/reactions/reaction" + activeImages20[i] + ".png"); }
      for (int i = 0; i < convo20.length; i++) { text(convo20[i], text_leftMargin, text_topMargin + 20*i); }
      break;
    case 21:
      for (int i = 0; i < keyCount; i++) { keys[i].value = values21[i]; keys[i].image = loadImage("images/reactions/reaction" + activeImages21[i] + ".png"); }
      for (int i = 0; i < convo21.length; i++) { text(convo21[i], text_leftMargin, text_topMargin + 20*i); }
      break;
    case 22:
      for (int i = 0; i < keyCount; i++) { keys[i].value = values22[i]; keys[i].image = loadImage("images/reactions/reaction" + activeImages22[i] + ".png"); }
      for (int i = 0; i < convo22.length; i++) { text(convo22[i], text_leftMargin, text_topMargin + 20*i); }
      break;
    case 23:
      for (int i = 0; i < keyCount; i++) { keys[i].value = values23[i]; keys[i].image = loadImage("images/reactions/reaction" + activeImages23[i] + ".png"); }
      for (int i = 0; i < convo23.length; i++) { text(convo23[i], text_leftMargin, text_topMargin + 20*i); }
      break;
    case 24:
      for (int i = 0; i < keyCount; i++) { keys[i].value = values24[i]; keys[i].image = loadImage("images/reactions/reaction" + activeImages24[i] + ".png"); }
      for (int i = 0; i < convo24.length; i++) { text(convo24[i], text_leftMargin, text_topMargin + 20*i); }
      break;
    case 25:
      for (int i = 0; i < keyCount; i++) { keys[i].value = values25[i]; keys[i].image = loadImage("images/reactions/reaction" + activeImages25[i] + ".png"); }
      for (int i = 0; i < convo25.length; i++) { text(convo25[i], text_leftMargin, text_topMargin + 20*i); }
      break;
    case 26:
      for (int i = 0; i < keyCount; i++) { keys[i].value = values26[i]; keys[i].image = loadImage("images/reactions/reaction" + activeImages26[i] + ".png"); }
      for (int i = 0; i < convo26.length; i++) { text(convo26[i], text_leftMargin, text_topMargin + 20*i); }
      break;
    case 27:
      for (int i = 0; i < keyCount; i++) { keys[i].value = values27[i]; keys[i].image = loadImage("images/reactions/reaction" + activeImages27[i] + ".png"); }
      for (int i = 0; i < convo27.length; i++) { text(convo27[i], text_leftMargin, text_topMargin + 20*i); }
      break;
    case 28:
      for (int i = 0; i < keyCount; i++) { keys[i].value = values28[i]; keys[i].image = loadImage("images/reactions/reaction" + activeImages28[i] + ".png"); }
      for (int i = 0; i < convo28.length; i++) { text(convo28[i], text_leftMargin, text_topMargin + 20*i); }
      break;
    case 29:
      for (int i = 0; i < keyCount; i++) { keys[i].value = values29[i]; keys[i].image = loadImage("images/reactions/reaction" + activeImages29[i] + ".png"); }
      for (int i = 0; i < convo29.length; i++) { text(convo29[i], text_leftMargin, text_topMargin + 20*i); }
      break;
    case 30:
      for (int i = 0; i < keyCount; i++) { keys[i].value = values30[i]; keys[i].image = loadImage("images/reactions/reaction" + activeImages30[i] + ".png"); }
      for (int i = 0; i < convo30.length; i++) { text(convo30[i], text_leftMargin, text_topMargin + 20*i); }
      break;
    default:
      println("ERROR: No more available convos.");
      break;
  }
  
  //your username
  textAlign(LEFT);
  textFont(font, 24);
  fill(255);
  text("h0ppery: ", text_leftMargin, text_topMargin+260);
  fill(190, 185, 225);
  image(icon_player, text_leftMargin - 40, text_topMargin+260, 50, 50);
  
  //display picks
  rectMode(CENTER);
  for (int i=0; i < keys.length; i++) {
    if (keys[i].selectID == 1) {
      image(keys[i].image, width/4+200/2+40, height/2+125, 200, 200);
    } else if (keys[i].selectID == 2) {
      image(keys[i].image, width/2, height/2+125, 200, 200);
    } else if (keys[i].selectID == 3) {
      image(keys[i].image, width*3/4-200/2-40, height/2+125, 200, 200);
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
      isSelected = true;
      keys[i].selectID = counter;
      tempScore += keys[i].value;
      select.play();
      select.rewind( );
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
        cancel.play();
        cancel.rewind( );
      }
      if (key == ENTER) { //&& isSelected TODO
        //submit score for the round
        score += tempScore;
        submit.play();
        submit.rewind();
        
        //hide?
        //displayScore = tempScore;
        //scoreA = 255;
        //scoreY = height/2;
        
        //clear board
        counter = 0;
        tempScore = 0;
        isSelected = false;
        for (int i = 0; i < keyCount; i++) {
          keys[i].selectID = 0;
        }
        
        //conversation progression
        if (currentConvo < convoTotal) {
          currentConvo++;
          if (currentConvo==8) {
            currentConvo = 9;
          }
        } else {
          currentConvo = 1;
          state = endScreen;
        }
      }
    case endScreen:
      if (key == 'q') {
        state = startScreen;
        break;
      }
  }
}
class Key {
  PImage image;
  int id, posID, value;
  int selectID = 0;
  float posX, posY;
  int keyWidth = 80;
  int keyHeight = 80;
  int r, g, b;
  int opacity = 100;
  boolean inRange = false;
  
  Key(int _id, int _posID, int[] _value, PImage[] _images) {
    id = _id;
    posID = _posID;
    value = _value[id-1];
    image = _images[id-1];
    
    //set posX
    posX = width/2 - (keyWidth+20)*(posID-2.5);
    //set posY
    posY = 3.3*height/4+8;
  }
  
  void display() {
    int tint = 255;
    //draw key
    if (selectID != 0) { 
      tint = 255;
    } else {
      tint = 126;
    };
    imageMode(CENTER);
    tint(255, tint);
    image(image, posX, posY, keyWidth, keyHeight);
    tint(255,255);
    
    //value label
    //fill(255);
    //textAlign(CENTER);
    //textFont(font, 16);
    //text(value, posX, posY); //hide
    //text(selectID, posX, posY+16); //hide
  }
  
  void detect(float playerX, float playerY) {
    float leftBounds = posX - keyWidth/2 + 20;
    float rightBounds = posX + keyWidth/2 + 20;
    float topBounds = posY - keyHeight/2 + 30;
    float bottomBounds = posY + keyHeight/2 + 30;
    
    if (playerX > leftBounds && playerX < rightBounds && playerY > topBounds && playerY < bottomBounds) {
      inRange = true;
      keyWidth = 90;
      keyHeight = 90;
    } else {
      inRange = false;
      keyWidth = 80;
      keyHeight = 80;
    }
  }
  
  boolean isInRange() {
    return inRange;
  }
}
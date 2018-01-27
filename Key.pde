class Key {
  int id, posID, value;
  int selectID = 0;
  float posX, posY;
  int keyWidth = 80;
  int keyHeight = 80;
  int r, g, b;
  int opacity = 100;
  boolean inRange = false;
  
  Key(int _id, int _posID, int[] _value) {
    id = _id;
    posID = _posID;
    value = _value[id-1];
    
    //set posX
    posX = width/2 - (keyWidth+20)*(posID-2.5);
    //set posY
    posY = 3.2*height/4;
    
    //set identity
    switch(id) {
      case 1:
        r = 255;
        g = 0;
        b = 0;
        break;
      case 2:
        r = 0;
        g = 255;
        b = 0;
        break;
      case 3:
        r = 0;
        g = 0;
        b = 255;
        break;
      case 4:
        r = 255;
        g = 255;
        b = 0;
        break;
      case 5:
        r = 255;
        g = 0;
        b = 255;
        break;
      case 6:
        r = 0;
        g = 255;
        b = 255;
        break;
      default:
        r = 255;
        g = 255;
        b = 255;
        break;
    }
  }
  
  void display() {
    //draw key
    if (selectID != 0) { 
      opacity = 230;
    };
    fill(r,g,b,opacity);
    rectMode(CENTER);
    rect(posX, posY, keyWidth, keyHeight);
    
    //value label
    fill(255);
    textAlign(CENTER);
    textFont(font, 16);
    text(value, posX, posY);
    text(selectID, posX, posY+16);
  }
  
  void detect(float playerX, float playerY) {
    float leftBounds = posX - keyWidth/2 + 20;
    float rightBounds = posX + keyWidth/2 + 20;
    float topBounds = posY - keyHeight/2 + 30;
    float bottomBounds = posY + keyHeight/2 + 30;
    
    if (playerX > leftBounds && playerX < rightBounds && playerY > topBounds && playerY < bottomBounds) {
      opacity = 200;
      inRange = true;
    } else {
      opacity = 100;
      inRange = false;
    }
  }
  
  boolean isInRange() {
    return inRange;
  }
}
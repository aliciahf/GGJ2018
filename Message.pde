class Message {
  int roll;
  String messageText;
  
  Message(int _roll, String _messageText) {
    roll = _roll;
    messageText = _messageText;
  }
  
  void display() {
    fill(255);
    textAlign(CENTER);
    textFont(font, 16);
    text(messageText, width/2, 200);
  }
}
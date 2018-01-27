class Message {
  int roll;
  String messageText;
  
  Message(String _messageText) {
    messageText = _messageText;
  }
  
  void display() {
    fill(255);
    textAlign(CENTER);
    textFont(font, 16);
    text(messageText, width/2, 200);
  }
}